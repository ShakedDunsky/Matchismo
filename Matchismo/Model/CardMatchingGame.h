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

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger nCardsToMatch;
@property (nonatomic, readonly) NSInteger scoreUpdate;
@property (nonatomic, strong) NSMutableArray *lastSelection;

- (instancetype)initWithCardCount:(NSInteger) count usingDeck:(Deck *)deck;

/// Does something cool with \c count and  \c deck.
///
///   @param count  Counts sheep
///   @param deck  Contains sheep
- (void)dealCardsWithCardCount:(NSInteger) count UsingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)insertCard:(Card *)card atIndex:(int)index;

@end
