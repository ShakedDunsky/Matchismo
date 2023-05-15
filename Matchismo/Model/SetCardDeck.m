//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
  self = [super init];
  if (self) {
    for (NSString *shape in [SetCard validShapes]) {
      for (NSNumber *opacity in [SetCard validOpacities]) {
        for (NSNumber *number in [SetCard validNumbers]) {
          for (NSArray *color in [SetCard validColors]) {
            SetCard *card = [[SetCard alloc] init];
            card.shape = shape;
            card.opacity = opacity;
            card.number = number;
            card.color = color;
            [self addCard:card];
          }
        }
      }
    }
  }
  return self;
}

@end

