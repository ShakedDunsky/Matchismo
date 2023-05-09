//
//  PlayingCardExampleViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 09/05/2023.
//

#import "PlayingCardExampleViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardExampleViewController ()

//@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong, nonatomic) Deck *deck;

@end

@implementation PlayingCardExampleViewController

-(Deck *)deck
{
  if (!_deck) {
    _deck = [[PlayingCardDeck alloc] init];
  }
  return _deck;
}

- (IBAction)swipe:(id)sender
{
  if (!self.playingCardView.faceUp) [self drawRndomPlayingCard];
  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}


- (void)drawRndomPlayingCard
{

  Card *card = [self.deck drawRandomCard];
  if ([card isKindOfClass:[PlayingCard class]]) {
    PlayingCard *playingCard = (PlayingCard *)card;
    self.playingCardView.rank = playingCard.rank;
    self.playingCardView.suit = playingCard.suit;
  }
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
}

@end
