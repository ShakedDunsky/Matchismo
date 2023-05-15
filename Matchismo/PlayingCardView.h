//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Shaked Dunsky on 10/05/2023.
//

#ifndef PlayingCardView_h
#define PlayingCardView_h


#endif /* PlayingCardView_h */

#import "CardView.h"

@interface PlayingCardView : CardView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
//-(void)swipe:(UISwipeGestureRecognizer *)gesture;

@end
