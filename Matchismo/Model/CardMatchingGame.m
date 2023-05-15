//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger scoreUpdate;

@end

static const int MATCH_BONUS = 4;
static const int MISMATCH_PANELTY = 2;
static const int COST_TO_CHOOSE = 1;

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
  if (!_cards) _cards=[[NSMutableArray alloc] init];
  return _cards;
}

- (NSMutableArray *)lastSelection
{
  if (!_lastSelection) _lastSelection=[[NSMutableArray alloc] init];
  return _lastSelection;
}

- (instancetype)initWithCardCount:(NSInteger) count usingDeck:(Deck *)deck
{
  self = [super init];
  [self dealCardsWithCardCount:count UsingDeck:deck];
  if ([self.cards count]==0) self = nil;
  return self;
}

- (void)dealCardsWithCardCount:(NSInteger) count UsingDeck:(Deck *)deck
{
  self.score = 0;
  self.cards=[[NSMutableArray alloc] init];
  for (int i = 0; i < count; i++) {
    Card *card = [deck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
    } else {
      self.cards = [[NSMutableArray alloc] init];
      break;
    }
  }
  self.lastSelection=[[NSMutableArray alloc] init];
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
  [self updateLastSelection];
  self.scoreUpdate = 0;
  Card *card = [self cardAtIndex:index];
  if (!card.isMatched) {
    if (card.isChosen) {
      card.chosen = NO;
      [self.lastSelection removeObject:card];
    } else {
      [self.lastSelection addObject:card];
      // match against other cards
      NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
      for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
          [chosenCards addObject:otherCard];
          if ([chosenCards count]==self.nCardsToMatch-1) break;
        }
      }
      if ([chosenCards count]==self.nCardsToMatch-1) {
        int matchScore = [card match:chosenCards];
        if (matchScore) {
          self.scoreUpdate += matchScore * MATCH_BONUS;
          for(Card *otherCard in chosenCards) {
            otherCard.matched = YES;
          }
          card.matched = YES;
        } else {
          self.scoreUpdate -= MISMATCH_PANELTY;
          for(Card *otherCard in chosenCards) {
            otherCard.chosen = NO;
          }
        }
      }
      self.score += self.scoreUpdate;
      self.score -= COST_TO_CHOOSE;
      card.chosen = YES;
    }
  }
}

- (void)updateLastSelection
{
  NSMutableArray *newSelection = [[NSMutableArray alloc] init];
  for (Card *card in self.lastSelection) {
    if ((!card.matched) && card.chosen) {
      [newSelection addObject:card];
    }
  }
  self.lastSelection = newSelection;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
  return (index<[self.cards count]) ? self.cards[index] : nil;
}

- (void)insertCard:(Card *)card atIndex:(int)index
{
  self.cards[index] = card;
}

@end

