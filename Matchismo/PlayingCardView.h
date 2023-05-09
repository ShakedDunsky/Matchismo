//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Shaked Dunsky on 09/05/2023.
//

#ifndef PlayingCardView_h
#define PlayingCardView_h


#endif /* PlayingCardView_h */

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
