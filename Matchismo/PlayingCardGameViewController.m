//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 01/05/2023.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

#define N_CARDS_IN_GAME 16

@interface PlayingCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *cardsGridView;

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
  return [[PlayingCardDeck alloc] init];
}

- (int) nCardsToMatch
{
  return 2;
}

- (CardView *)getCardViewForFrame:(CGRect)cardFrame withCard:(PlayingCard *)card
{
  PlayingCardView *playingCardView = [[PlayingCardView alloc] initWithFrame:cardFrame];
  return playingCardView;
}

-(void)handleMatchedCardAtIndex:(int)cardIndex
{
  [self removeGesturesAtIndex:cardIndex];
}

- (void)initCardView:(PlayingCardView *)cardView withCard:(PlayingCard *)card
{
  cardView.suit = card.suit;
  cardView.rank = card.rank;
  cardView.faceUp = YES;
}

- (void) updateCardView:(PlayingCardView *)cardView withCard:(PlayingCard *)card
{
  cardView.faceUp = card.isChosen;
  cardView.matched = card.isMatched;
}

-(int)nCardsInGame
{
  return N_CARDS_IN_GAME;
}

@end
