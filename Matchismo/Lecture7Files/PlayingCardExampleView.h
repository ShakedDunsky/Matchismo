//
//  PlayingCardExampleView.h
//  Matchismo
//
//  Created by Shaked Dunsky on 09/05/2023.
//

#ifndef PlayingCardExampleView_h
#define PlayingCardExampleView_h


#endif /* PlayingCardExampleView_h */

#import <UIKit/UIKit.h>

@interface PlayingCardExampleView : UIView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;
-(void)swipe:(UISwipeGestureRecognizer *)gesture;

@end
