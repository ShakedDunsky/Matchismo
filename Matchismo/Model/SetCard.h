//
//  SetCard.h
//  Matchismo
//
//  Created by Shaked Dunsky on 01/05/2023.
//

#ifndef SetCard_h
#define SetCard_h


#endif /* SetCard_h */

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSArray *color;
@property (nonatomic) NSNumber *alpha;
@property (nonatomic) NSNumber *number;

+ (NSArray *)validShapes;
+ (NSArray *)validAlphas;
+ (NSArray *)validNumbers;
+ (NSArray *)validColors;

@end
