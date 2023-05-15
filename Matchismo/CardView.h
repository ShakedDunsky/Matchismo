//
//  CardView.h
//  Matchismo
//
//  Created by Shaked Dunsky on 10/05/2023.
//

#ifndef CardView_h
#define CardView_h


#endif /* CardView_h */

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) BOOL faceUp;
@property (nonatomic, getter=isMatched) BOOL matched;

-(CGFloat)cornerOffset;
-(CGFloat)cornerScaleFactor;
-(void)pinch:(UIPinchGestureRecognizer *)gesture;
-(void)swipe:(UISwipeGestureRecognizer *)gesture;

@end
