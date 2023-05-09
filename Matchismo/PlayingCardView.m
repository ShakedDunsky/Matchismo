//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Shaked Dunsky on 09/05/2023.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#pragma mark - Properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

-(CGFloat)faceCardScaleFactor
{
  if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
  return _faceCardScaleFactor;

}

-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
  _suit=suit;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
  _rank=rank;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
  _faceUp=faceUp;
  [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor
{
  return self.bounds.size.height / CORNER_FONT_STANDARD_HIGHT;

}

-(CGFloat)cornerRadius
{
  return CORNER_RADIUS * [self cornerScaleFactor];

}

-(CGFloat)cornerOffset
{
  return [self cornerRadius] / 3.0;

}

- (NSArray *)rankAsString
{
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];

}

#define PIP_HOFFSET_PRECENTAGE 0.165
#define PIP_VOFFSET1_PRECENTAGE 0.090
#define PIP_VOFFSET2_PRECENTAGE 0.175
#define PIP_VOFFSET3_PRECENTAGE 0.270

-(void)drawPips
{
  if ((self.rank==1) || (self.rank==5) || (self.rank==9) || (self.rank==3)) {
    [self drawPipsWithHorizontalOffset:0 verticalOffset:0 mirrorVertically:NO];
  }
  if ((self.rank==6) || (self.rank==7) || (self.rank==8)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PRECENTAGE verticalOffset:0 mirrorVertically:NO];
  }
  if ((self.rank==2) || (self.rank==3) || (self.rank==7) || (self.rank==8) || (self.rank==10)) {
    [self drawPipsWithHorizontalOffset:0 verticalOffset:PIP_VOFFSET2_PRECENTAGE mirrorVertically:(self.rank!=7)];
  }
  if ((self.rank==4) || (self.rank==5) || (self.rank==6) || (self.rank==7) || (self.rank==8) || (self.rank==9) || (self.rank==10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PRECENTAGE verticalOffset:PIP_VOFFSET3_PRECENTAGE mirrorVertically:(YES)];
  }
  if ((self.rank==9) || (self.rank==10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PRECENTAGE verticalOffset:PIP_VOFFSET1_PRECENTAGE mirrorVertically:(YES)];
  }
}

#define PIP_FONT_SCALE_FACTOR 0.012
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset upsideDown:(BOOL)upsideDown
{
  if (upsideDown) [self pushContextAndRotateUPsideDown];
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit
                                                                       attributes:@{NSFontAttributeName: pipFont}];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake(
                                  middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                  middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                  );
  [attributedSuit drawAtPoint:pipOrigin];
  if (hoffset) {
    pipOrigin.x += hoffset*2.0*self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];

  }
  if (upsideDown) [self popContext];
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset mirrorVertically:(BOOL)mirrorVertically
{
  [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
  if (mirrorVertically){
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
  }
}

- (void)pushContextAndRotateUPsideDown
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
  CGContextRestoreGState(UIGraphicsGetCurrentContext());

}

- (void)drawRect:(CGRect)rect
{
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  if (self.faceUp) {
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    if (faceImage) {
      CGRect imageRect = CGRectInset(
                                     self.bounds,
                                     self.bounds.size.width * (1.0-self.faceCardScaleFactor),
                                     self.bounds.size.height * (1.0-self.faceCardScaleFactor));
      [faceImage drawInRect:imageRect];

    } else {
      [self drawPips];
    }
    [self drawCorners];
  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }
}
-(void)drawCorners
{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  NSAttributedString *cornerText = [[NSAttributedString alloc]
                                    initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit]
                                    attributes:@{NSFontAttributeName : cornerFont,
                                                 NSParagraphStyleAttributeName : paragraphStyle}];
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect:textBounds];

}

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
  if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)) {
    self.faceCardScaleFactor *= gesture.scale;
    gesture.scale = 1.0;
  }
}

#pragma mark - Initialization

-(void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

-(void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {}
  return self;
}

@end
