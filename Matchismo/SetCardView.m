//
//  SetCardView.m
//  Matchismo
//
//  Created by Shaked Dunsky on 10/05/2023.
//

#import "SetCardView.h"

@interface SetCardView ()
@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIColor *strokeColor;
@end

@implementation SetCardView

#define EDGE_PERCENTAGE 0.10

- (UIColor *)fillColor
{
  double r = [self.color[0] doubleValue];
  double g = [self.color[1] doubleValue];
  double b = [self.color[2] doubleValue];
  double a = [self.opacity doubleValue];
  _fillColor =  [UIColor colorWithRed:r green:g blue:b alpha:a];
  return _fillColor;
}

- (UIColor *)strokeColor
{
  double r = [self.color[0] doubleValue];
  double g = [self.color[1] doubleValue];
  double b = [self.color[2] doubleValue];
  _strokeColor =  [UIColor colorWithRed:r green:g blue:b alpha:1.0];
  return _strokeColor;
}

//-(void)swipe:(UISwipeGestureRecognizer *)gesture
//{
//  NSLog(@"set swipe");
////  self.chosen = !self.chosen;
//  self.faceUp = !self.faceUp;
//  [self setNeedsDisplay];
//}

-(float)xEdgeSize
{
  return self.bounds.size.width * EDGE_PERCENTAGE;
}

-(float)yEdgeSize
{
  return self.bounds.size.height * EDGE_PERCENTAGE;
}

-(float)shapeWidth
{
  return self.bounds.size.width * (1 - 2 * EDGE_PERCENTAGE);
}

-(float)shapeHeight
{
  return self.bounds.size.height * (1 - 4 * EDGE_PERCENTAGE) / 3.0;
}

-(void)drawDimondWithCenter:(CGPoint)center
{
  CGPoint left = CGPointMake([self xEdgeSize], center.y);
  CGPoint top = CGPointMake(center.x, center.y-[self shapeHeight]/2);
  CGPoint right = CGPointMake(self.bounds.size.width-[self xEdgeSize], center.y);
  CGPoint bottom = CGPointMake(center.x, center.y+[self shapeHeight]/2);

  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:left];
  [path addLineToPoint:top];
  [path addLineToPoint:right];
  [path addLineToPoint:bottom];
  [path closePath];
  [self.fillColor setFill];
  [self.strokeColor setStroke];
  [path fill];
  [path stroke];
}

-(void)drawOvalWithCenter:(CGPoint)center
{
  CGRect shapeRect = CGRectMake(center.x-[self shapeWidth]/2.0, center.y-[self shapeHeight]/2.0, [self shapeWidth], [self shapeHeight]);
  UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:[self shapeHeight]/2.0];

  [self.fillColor setFill];
  [self.strokeColor setStroke];
  [oval fill];
  [oval stroke];
}

-(void)drawSquiggleWithCenter:(CGPoint)center
{
  CGPoint p1 = CGPointMake([self xEdgeSize], center.y+[self shapeHeight]/2.);
  CGPoint p2 = CGPointMake(center.x, center.y-[self shapeHeight]/2.);
  CGPoint p3 = CGPointMake(self.bounds.size.width-[self xEdgeSize], center.y-[self shapeHeight]/2.);
  CGPoint p4 = CGPointMake(center.x, center.y+[self shapeHeight]/2.);

  CGPoint cp1 = CGPointMake(self.bounds.size.width/5., center.y-[self shapeHeight]);
  CGPoint cp2 = CGPointMake((p2.x+p3.x)/2., center.y);
  CGPoint cp3 = CGPointMake(4.*self.bounds.size.width/5., center.y+[self shapeHeight]);
  CGPoint cp4 = CGPointMake((p4.x+p1.x)/2., center.y);

  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:p1];
  [path addQuadCurveToPoint:p2 controlPoint:cp1];
  [path addQuadCurveToPoint:p3 controlPoint:cp2];
  [path addQuadCurveToPoint:p4 controlPoint:cp3];
  [path addQuadCurveToPoint:p1 controlPoint:cp4];
  [path closePath];
  [self.fillColor setFill];
  [self.strokeColor setStroke];
  [path fill];
  [path stroke];
}

//-(void)drawSquiggleWithCenter:(CGPoint)center
//{
//  float w = self.bounds.size.width;
//  CGPoint p1 = CGPointMake(2*[self xEdgeSize], center.y-[self shapeHeight]/2.);
//  CGPoint p2 = CGPointMake(5*[self xEdgeSize], center.y-[self shapeHeight]/2.);
//  CGPoint p3 = CGPointMake(w-2*[self xEdgeSize], center.y-[self shapeHeight]/2.);
//  CGPoint p4 = CGPointMake(p3.x+[self xEdgeSize], center.y+[self shapeHeight]/2.);
//  CGPoint p5 = CGPointMake(p2.x+0.5*[self xEdgeSize], center.y+[self shapeHeight]/2.);
//  CGPoint p6 = CGPointMake(p1.x+0.5*[self xEdgeSize], center.y+[self shapeHeight]/2.);
//
//  CGPoint cp1 = CGPointMake(0, center.y+[self shapeHeight]/2-0.7*[self yEdgeSize]);
//  CGPoint cp2 = CGPointMake((p1.x+p2.x)/2, p1.y-0.5*[self yEdgeSize]);
//  CGPoint cp3 = CGPointMake((p2.x+p3.x)/2, p2.y+[self yEdgeSize]);
//  CGPoint cp4 = CGPointMake(w, center.y-[self shapeHeight]/2+[self yEdgeSize]);
//  CGPoint cp5 = CGPointMake((p4.x+p5.x)/2, p4.y+[self yEdgeSize]);
//  CGPoint cp6 = CGPointMake((p5.x+p6.x)/2, p5.y-0.5*[self yEdgeSize]);
//
//
//  UIBezierPath *path = [[UIBezierPath alloc] init];
//  [path moveToPoint:p1];
//  [path addQuadCurveToPoint:p2 controlPoint:cp2];
//  [path addQuadCurveToPoint:p3 controlPoint:cp3];
//  [path addQuadCurveToPoint:p4 controlPoint:cp4];
//  [path addQuadCurveToPoint:p5 controlPoint:cp5];
//  [path addQuadCurveToPoint:p6 controlPoint:cp6];
//  [path addQuadCurveToPoint:p1 controlPoint:cp1];
//  [path closePath];
//  [self.fillColor setFill];
//  [self.strokeColor setStroke];
//  [path fill];
//  [path stroke];
//}

-(void)drawShapeWithCenter:(CGPoint)center
{
  if ([self.shape isEqualToString:@"dimond"]) {
    [self drawDimondWithCenter:center];

  } else if ([self.shape isEqualToString:@"oval"]) {
    [self drawOvalWithCenter:center];

  } else {  // [self.shape isEqualToString:@"squiggle"]
    [self drawSquiggleWithCenter:center];
  }
}

-(void)drawCardOutlineWithPath:(UIBezierPath *)roundedRect
{
  if (self.isChosen) {
    [[UIColor redColor] setStroke];
    [roundedRect stroke];
  } else {
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
  }
}

-(void)drawCardContent

{
  if (self.isChosen) {
    [[UIColor grayColor] setFill];
    UIRectFill(self.bounds);
  } else {
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
  }

  if (([self.number intValue] == 1) || ([self.number intValue] == 3)) {
    CGPoint middle = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    [self drawShapeWithCenter:middle];

    if ([self.number intValue] == 3) {
      CGPoint top = CGPointMake(self.bounds.size.width/2.0, [self yEdgeSize] + [self shapeHeight]/2.0);
      CGPoint bottom = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height - [self yEdgeSize] - [self shapeHeight]/2.0);
      [self drawShapeWithCenter:top];
      [self drawShapeWithCenter:bottom];
    }

  } else {  // self.number == 2
    CGPoint top = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/3.0);
    CGPoint bottom = CGPointMake(self.bounds.size.width/2.0, 2*self.bounds.size.height/3.0);
    [self drawShapeWithCenter:top];
    [self drawShapeWithCenter:bottom];
  }
}

@end
