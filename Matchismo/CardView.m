//
//  CardView.m
//  Matchismo
//
//  Created by Shaked Dunsky on 10/05/2023.
//

#import "CardView.h"

//@interface CardView()

//@end

@implementation CardView

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

-(CGFloat)faceCardScaleFactor
{
  if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
  return _faceCardScaleFactor;

}

- (void)setFaceUp:(BOOL)faceUp
{
  _faceUp=faceUp;
  [self setNeedsDisplay];
}

-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}

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

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
  if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)) {
    self.faceCardScaleFactor *= gesture.scale;
    gesture.scale = 1.0;
  }
}

-(void)swipe:(UISwipeGestureRecognizer *)gesture
{
//  NSLog(@"generic card swipe");
//  self.faceUp = !self.faceUp;
  [self setNeedsDisplay];
}


-(void)drawCardContent {} // abstract method

-(void)drawCardOutlineWithPath:(UIBezierPath *)roundedRect
{
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

- (void)drawRect:(CGRect)rect
{
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  [roundedRect addClip];

  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);

  if (self.faceUp) {
    [self drawCardContent];
  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }
  [self drawCardOutlineWithPath:roundedRect];
  if (self.isMatched) {
    self.alpha = 0.5;
  } else {
    self.alpha = 1.0;
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

