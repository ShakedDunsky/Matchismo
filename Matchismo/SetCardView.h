//
//  SetCardView.h
//  Matchismo
//
//  Created by Shaked Dunsky on 10/05/2023.
//

#ifndef SetCardView_h
#define SetCardView_h


#endif /* SetCardView_h */

#import "CardView.h"

@interface SetCardView : CardView

@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSArray *color;
@property (nonatomic) NSNumber *opacity;
@property (nonatomic) NSNumber *number;
@property (nonatomic, getter=isChosen) BOOL chosen;

@end
