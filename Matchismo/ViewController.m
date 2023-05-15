//
//  ViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "CardView.h"
#import "Card.h"
#import "Grid.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(CardView) NSMutableArray *cardViewsArray;
@property (weak, nonatomic) IBOutlet UIView *cardsGridView;
@property (strong, nonatomic) Grid *grid;
@end

@implementation ViewController

-(NSMutableArray *)cardViewsArray
{
  if (!_cardViewsArray) {
    _cardViewsArray = [[NSMutableArray alloc] init];
  }
  return _cardViewsArray;
}

- (Grid *)grid
{
  if (!_grid) {
    _grid = [[Grid alloc] init];
    _grid.size = self.cardsGridView.bounds.size;
    _grid.cellAspectRatio = 0.7;
    _grid.minimumNumberOfCells = [self nCardsInGame];
  }
  return _grid;
}

- (CardMatchingGame *)game
{
  if (!_game) {
    _game = [[CardMatchingGame alloc] init];
    _game.nCardsToMatch = [self nCardsToMatch];
  }
  return _game;
}

- (int) nCardsToMatch // abstruct
{
  return 0;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initUI];
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

-(int)nCardsInGame {return 0;} // abstruct

- (void)redeal
{
  self.deck = [self createDeck];
  [self.game dealCardsWithCardCount:[self nCardsInGame] UsingDeck:self.deck];
  for (CardView *cardView in self.cardViewsArray) {
    Card *card = [self.game cardAtIndex:[self.cardViewsArray indexOfObject:cardView]];
    [self initCardView:cardView withCard:card];
  }
  [self addGestures];
  [self updateUI];
}

- (IBAction)touchRedealButtion:(UIButton *)sender
{
  [self redeal];
}

- (void)updateUI
{
  for (int cardIndex=0; cardIndex<[self.cardViewsArray count]; cardIndex++){
    CardView *cardView = self.cardViewsArray[cardIndex];
    Card *card = [self.game cardAtIndex:cardIndex];
    if (card.matched) {
      [self handleMatchedCardAtIndex:cardIndex];
    }
    [self updateCardView:self.cardViewsArray[cardIndex] withCard:[self.game cardAtIndex:cardIndex]];
    [cardView setNeedsDisplay];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

-(void)handleMatchedCardAtIndex:(int)cardIndex {}

-(void)removeGesturesAtIndex:(int)cardIndex
{
  CardView *cardView = self.cardViewsArray[cardIndex];
  for (UIGestureRecognizer *recognizer in cardView.gestureRecognizers) {
    [cardView removeGestureRecognizer:recognizer];
  }
}

-(void)removeMatchedCardAtIndex:(int)cardIndex
{
  if ([self.deck cardCount] >= self.game.nCardsToMatch) {
    Card *card = [self.deck drawRandomCard];
    [self.game insertCard:card atIndex:cardIndex];
    [self initCardView:self.cardViewsArray[cardIndex] withCard:card];
  }
}

- (void)initUI
{
  int cardIndex = 0;
  for (int row=0; row<self.grid.rowCount; row++) {
    for (int col=0; col<self.grid.columnCount; col++) {
      if (cardIndex<[self nCardsInGame]) {
        Card *card = [self.game cardAtIndex:cardIndex];
        CGRect cardFrame = [self.grid frameOfCellAtRow:row inColumn:col];
        CardView *cardView = [self getCardViewForFrame:cardFrame withCard:card];
        [self.cardViewsArray addObject:cardView];
        [self.cardsGridView addSubview:cardView];
        cardIndex++;
      }
    }
  }
}

- (IBAction)swipe:(id)sender
{
  CardView *cardView = (CardView *)[sender view];
  int cardIndex = (int)[self.cardViewsArray indexOfObject:cardView];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];
}

-(void)addGestures
{
  for (CardView *cardView in self.cardViewsArray) {
    if ([cardView.gestureRecognizers count]==0) {
      [cardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:cardView
                                                                               action:@selector(pinch:)]];
      UISwipeGestureRecognizer *swipeGestureRecognizer = [
        [UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
      [swipeGestureRecognizer addTarget:cardView action:@selector(swipe:)];
      [cardView addGestureRecognizer:swipeGestureRecognizer];
    }
  }
}

- (CardView *)getCardViewForFrame:(CGRect)cardFrame withCard:(Card *)card // abstract
{
  return nil;
}

- (void)initCardView:(CardView *)cardView withCard:(Card *)card {} // abstract

- (void)updateCardView:(CardView *)cardView withCard:(Card *)card {} // abstract

@end





