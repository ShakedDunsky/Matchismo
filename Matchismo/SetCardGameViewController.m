//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 01/05/2023.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"
#import "PlayingCardView.h"

#define N_CARDS_IN_GAME 12

@interface SetCardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *cardsGridView;

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
  return [[SetCardDeck alloc] init];
}

- (int) nCardsToMatch 
{
  return 3;
}

- (CardView *)getCardViewForFrame:(CGRect)cardFrame withCard:(SetCard *)card
{
  SetCardView *setCardView = [[SetCardView alloc] initWithFrame:cardFrame];
  return setCardView;
}

-(void)handleMatchedCardAtIndex:(int)cardIndex
{
  [self removeMatchedCardAtIndex:cardIndex];
}

- (void)initCardView:(SetCardView *)cardView withCard:(SetCard *)card
{
  cardView.color = card.color;
  cardView.shape = card.shape;
  cardView.number = card.number;
  cardView.opacity = card.opacity;
  cardView.faceUp = YES;
}

- (void) updateCardView:(SetCardView *)cardView withCard:(SetCard *)card
{
  cardView.chosen = card.isChosen;
  cardView.matched = card.isMatched;
}

-(int)nCardsInGame
{
  return N_CARDS_IN_GAME;
}

@end
