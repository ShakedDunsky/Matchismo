//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//

#ifndef CardMatchingGame_h
#define CardMatchingGame_h


#endif /* CardMatchingGame_h */

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject;

- (instancetype)initWithCardCount:(NSInteger) count usingDeck:(Deck *)deck;
- (void)dealCardsWithCardCount:(NSInteger) count UsingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger nCardsToMatch;
@property (nonatomic, readonly) NSInteger scoreUpdate;
@property (nonatomic, strong) NSMutableArray *lastSelection;

@end
