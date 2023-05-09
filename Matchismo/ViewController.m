//
//  ViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSAttributedString *gameStatus;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *broadcastLabel;
@end

@implementation ViewController

- (CardMatchingGame *)game
{
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    _game.nCardsToMatch = [self nCardsToMatch];
  }
  return _game;
}

- (NSAttributedString *)gameStatusHistory
{
  if (!_gameStatusHistory) {
    _gameStatusHistory = [[NSAttributedString alloc] initWithString:@""];
  }
  return _gameStatusHistory;
}

- (int) nCardsToMatch // abstruct
{
  return 0;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self redeal];
}

- (Deck *)deck
{
  if (!_deck) _deck = [self createDeck];
  return _deck;
}

-  (Deck *)createDeck  // abstruct
{
  return nil;
}

- (IBAction)touchCardButtion:(UIButton *)sender
{
  int cardIndex = (int)[self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex];
  self.gameStatus = [self getGameStatus];
  [self updateGameStatusHistory];
  [self updateUI];
}

- (void)redeal
{
  [self.game dealCardsWithCardCount:[self.cardButtons count] UsingDeck:[self createDeck]];
  self.gameStatus = [[NSAttributedString alloc] init];
  self.gameStatusHistory = [[NSAttributedString alloc] init];
  [self updateUI];
}

- (IBAction)touchRedealButtion:(UIButton *)sender
{
  [self redeal];
  [[NSUserDefaults standardUserDefaults] setInteger:16 forKey:@"some_key"];
}

- (void)updateUI
{
  for (UIButton *cardButton in self.cardButtons) {
    cardButton.titleLabel.numberOfLines = 0;
    int cardIndex = (int)[self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardIndex];
    cardButton.enabled = !card.isMatched;
    [self updateUIButton:cardButton withCard:card];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.broadcastLabel.numberOfLines = 0;
  self.broadcastLabel.attributedText = self.gameStatus;
}

- (void)updateGameStatusHistory
{
  if ([self.game.lastSelection count] == self.game.nCardsToMatch) {
    NSMutableAttributedString *mutableGameStatusHistory = [[NSMutableAttributedString alloc] initWithAttributedString:self.gameStatusHistory];
    NSMutableAttributedString *mutableGameStatus = [[NSMutableAttributedString alloc] initWithAttributedString:self.gameStatus];
    if ([mutableGameStatusHistory length] > 0) {
      NSMutableAttributedString *new_line = [[NSMutableAttributedString alloc] initWithString:@"\n"];
      [mutableGameStatusHistory appendAttributedString:new_line];
    }
    [mutableGameStatusHistory appendAttributedString:mutableGameStatus];
    self.gameStatusHistory = mutableGameStatusHistory;
  }
}

- (NSAttributedString *)getGameStatus
{
  NSMutableAttributedString *message = [self messageStringForSelectedCards:self.game.lastSelection];
  int nChosen = (int)[self.game.lastSelection count];
  if (nChosen == self.game.nCardsToMatch) {
    if (self.game.scoreUpdate > 0) {
      NSMutableAttributedString *prefix = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
      NSMutableAttributedString *suffix = [[NSMutableAttributedString alloc] initWithString:
                                            [NSString stringWithFormat:@" for %ld points", self.game.scoreUpdate]];
      [prefix appendAttributedString:message];
      [prefix appendAttributedString:suffix];
      message = prefix;
    }
    if (self.game.scoreUpdate < 0) {
      NSMutableAttributedString *suffix = [[NSMutableAttributedString alloc] initWithString:
                                            [NSString stringWithFormat:@" don't match! %ld points penalty", -self.game.scoreUpdate]];
      [message appendAttributedString:suffix];
    }
  }
  return message;
}

- (NSMutableAttributedString *)messageStringForSelectedCards: (NSArray *)selectedCards
{
  NSMutableAttributedString *message = [[NSMutableAttributedString alloc] init];
  for (Card *card in selectedCards) {
    [message appendAttributedString:[[NSMutableAttributedString alloc] initWithString:card.contents]];
  };
  return message;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"Show History"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
      HistoryViewController *historyViewController = segue.destinationViewController;
      historyViewController.text=self.gameStatusHistory;
    }
  }
}

- (void) updateUIButton:(UIButton *)cardButton withCard:(Card *)card {} // abstract

@end





