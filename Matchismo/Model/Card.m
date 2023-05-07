//
//  Card.m
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import "Card.h"

@implementation Card

- (NSString *)contents
{
  NSLog(@"card contents: %@", _contents);
  return _contents;
}

- (int)match:(NSArray *)otherCards
{
  int score = 0;
  for (Card *card in otherCards) {
    if ([card.contents isEqualToString:self.contents]){
      score = 1;
    }

  }
  return score;
}

@end
