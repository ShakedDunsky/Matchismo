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


@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardViewArray;


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

//- (IBAction)swipe:(id)sender
//{
//  int cardIndex = (int)[self.playingCardViewArray indexOfObject:[sender view]];
//  PlayingCardView *pcv = (PlayingCardView *)self.playingCardViewArray[cardIndex];
//  if (!pcv.faceUp) [self drawRandomPlayingCardForView:pcv];
//  pcv.faceUp = !pcv.faceUp;
//}

- (void)drawRandomPlayingCardForView:(PlayingCardView *)playingCardView
{

  Card *card = [self.deck drawRandomCard];
  if ([card isKindOfClass:[PlayingCard class]]) {
    PlayingCard *playingCard = (PlayingCard *)card;
    playingCardView.rank = playingCard.rank;
    playingCardView.suit = playingCard.suit;
  }
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  for (PlayingCardView *pcv in self.playingCardViewArray) {
    [pcv addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:pcv action:@selector(pinch:)]];
    [pcv addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:pcv action:@selector(swipe:)]];
  }
}

@end
