//
//  ViewController.h
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//
// Abstract class, must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController

// for subclass
- (Deck *)createDeck;  // abstruct
-(void)removeGesturesAtIndex:(int)cardIndex;
-(void)removeMatchedCardAtIndex:(int)cardIndex;

@end

