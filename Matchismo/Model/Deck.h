//
//  Deck.h
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#import <Foundation/Foundation.h>
//#import "Card.h"
@class Card;

@interface Deck : NSObject;

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;
- (NSInteger)cardCount;

@end
