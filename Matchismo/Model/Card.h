//
//  Card.h
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject


@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
@end
