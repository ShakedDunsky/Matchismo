//
//  PlayingCard.m
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)pairwiseMatch:(PlayingCard *)otherCard
{
  int score = 0;
  if ([self.suit isEqualToString:otherCard.suit]) {
    score = 1;
  } else if (self.rank == otherCard.rank) {
    score = 4;
  }
  return score;
}

- (int)match:(NSArray *)otherCards
{
  int score = 0;
  BOOL allMatch = YES;
  int curScore = 0;
  for (PlayingCard *otherCard in otherCards) {
    curScore = [self pairwiseMatch:otherCard];
    allMatch = allMatch && (curScore > 0);
    score += curScore;
  }
  if ([otherCards count] == 2) {
    curScore = [otherCards[0] pairwiseMatch:otherCards[1]];
    allMatch = allMatch && (curScore > 0);
    score += curScore;
    if (allMatch) {
      score *= 5;
    }
  }

  return score;
}

- (NSString *)contents
{
  NSArray *rankStrings = [PlayingCard rankStrings];
  NSString *str = [rankStrings[self.rank] stringByAppendingString:self.suit];
  return str;
}

+ (NSArray *)validSuits
{
  return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (void)setSuit:(NSString *)suit
{
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit
{
  return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
  return  @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
  return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
  if (rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

@end
