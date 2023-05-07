//
//  SetCard.m
//  Matchismo
//
//  Created by Shaked Dunsky on 01/05/2023.
//

#import "SetCard.h"

@implementation SetCard

+ (BOOL)traitMatch:(NSArray *)traits
{
  if ([traits[0] isEqual:traits[1]] && [traits[0] isEqual:traits[2]]) return YES;
  if (![traits[0] isEqual:traits[1]] && ![traits[0] isEqual:traits[2]] && ![traits[1] isEqual:traits[2]]) return YES;
  return NO;

}

- (int)match:(NSArray *)otherCards
{
  int score = 0;

  NSArray *shapes = @[self.shape];
  NSArray *numbers = @[self.number];
  NSArray *colors = @[self.color];
  NSArray *alphas = @[self.alpha];
  for (SetCard *otherCard in otherCards) {
    shapes = [shapes arrayByAddingObject:otherCard.shape];
    numbers = [numbers arrayByAddingObject:otherCard.number];
    colors = [colors arrayByAddingObject:otherCard.color];
    alphas = [alphas arrayByAddingObject:otherCard.alpha];
  }

  if ([SetCard traitMatch:shapes] && [SetCard traitMatch:numbers] &&
      [SetCard traitMatch:colors] && [SetCard traitMatch:alphas]) {
    score = 5;
  }
  return score;
}

- (NSString *)contents
{
  NSString *content = @"";
  for (int i=0; i<[self.number intValue]; i++) {
    content = [content stringByAppendingString:[NSString stringWithFormat:@"%@", self.shape]];
  }
  return content;
}

+ (NSArray *)validShapes
{
  return @[@"●", @"■", @"▲"];
}

+ (NSArray *)validAlphas
{
  return @[@0, @0.4, @1];
}

+ (NSArray *)validNumbers
{
  return @[@1, @2, @3];
}

+ (NSArray *)validColors
{
  return @[@[@(0.25), @(0.6), @(0.15)], @[@1,@0,@0], @[@(0.47),@(0.07),@(0.71)]];    //65, 153, 38
}

- (void)setShape:(NSString *)shape
{
  if ([[SetCard validShapes] containsObject:shape]) {
    _shape = shape;
  }
}

- (void)setAlpha:(NSNumber *)alpha
{
  if ([[SetCard validAlphas] containsObject:alpha]) {
    _alpha = alpha;
  }
}

- (void)setNumber:(NSNumber *)number
{
  if ([[SetCard validNumbers] containsObject:number]) {
    _number = number;
  }
}

- (void)setColor:(NSArray *)color
{
  if ([[SetCard validColors] containsObject:color]) {
    _color = color;
  }
}

@end
