//
//  ViewController.h
//  Matchismo
//
//  Created by Shaked Dunsky on 23/04/2023.
//
// Abstract class, must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) NSAttributedString *gameStatusHistory;

// for subclass
-  (Deck *)createDeck;  // abstruct

@end

