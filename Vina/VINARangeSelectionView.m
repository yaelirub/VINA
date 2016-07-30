//
//  VINADistanceSelectionView.m
//  Vina
//
//  Created by Yael Rubinstein on 7/18/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

#import "VINARangeSelectionView.h"
@import QuartzCore;
#import "UIColor+VINASettings.h"

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees) / 180)
@interface VINARangeSelectionView ()

@property (nonatomic, strong) UIView *fillView;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) CGPoint currentPoint;
@property (nonatomic) CGFloat endAngle;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) BOOL didTouch;
@property (nonnull, strong) CAShapeLayer *distanceIndicator;
@property (nonnull, strong) UIView *distanceIndicatorView;
@property (nonnull, strong) UILabel *distanceIndicatorLabel;

@end

@implementation VINARangeSelectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        _lastPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds));
    }
    return self;
}

-(void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:233/255.0 green:233.0/255 blue:233.0/255 alpha:1.0];
    [self setupFillView];
    
}

-(void)setupFillView
{
    CGRect frame = self.bounds;
    frame.origin.x += 20.0;
    frame.origin.y += 20.0;
    frame.size.width -= 40.0;
    frame.size.height -= 40.0;
    _fillView = [[UIView alloc] initWithFrame:frame];
    _fillView.layer.cornerRadius = CGRectGetWidth(frame) / 2;
    _fillView.layer.masksToBounds = YES;
    _fillView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_fillView];
}


- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
    self.layer.masksToBounds = YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.distanceIndicatorView.alpha = 0.0;
    if(!_didTouch) {
        _lastPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds));
        _didTouch  = YES;
        [self addDistanceIndicatorAtPoint:_lastPoint];
    }
    else {
        _lastPoint = [(UITouch *)[touches anyObject] locationInView:self];
    }

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _currentPoint = [(UITouch *)[touches anyObject] locationInView:self];
   _startAngle = atan2(_lastPoint.y - CGRectGetMidY(self.bounds), _lastPoint.x - CGRectGetMidX(self.bounds));
    CGFloat endAngle = atan2(_currentPoint.y - CGRectGetMidY(self.bounds), _currentPoint.x - CGRectGetMidX(self.bounds));
    [self addAnimationLayerWithStartAngle:3 * M_PI_2 endAngle:endAngle];
    _endAngle = endAngle;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView *distanceIndicatorView = self.distanceIndicatorView;
      CGPoint point = CGPointMake(CGRectGetMidX(self.bounds) + self.layer.cornerRadius * cos(_endAngle) - CGRectGetWidth(distanceIndicatorView.bounds) / 2, CGRectGetMidY(self.bounds) + self.layer.cornerRadius * sin(_endAngle) - CGRectGetHeight(distanceIndicatorView.bounds) / 2);

    CGRect frame = distanceIndicatorView.frame;
    frame.origin =  CGPointMake(MAX(5.0, MIN(point.x + CGRectGetWidth(distanceIndicatorView.frame), 230.0)), MAX(5.0, MIN(point.y + CGRectGetHeight(_distanceIndicatorView.frame), 230.0)));
    distanceIndicatorView.frame = frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        distanceIndicatorView.alpha = 1.0;
    }];
}


-(void)addAnimationLayerWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.position = CGPointMake(CGRectGetMidX(self.bounds) - self.layer.cornerRadius, CGRectGetMidY(self.bounds) - self.layer.cornerRadius);
    
    layer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path;
    if(_startAngle > _endAngle) {
        layer.strokeColor = self.backgroundColor.CGColor;
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.layer.cornerRadius, self.layer.cornerRadius) radius:self.layer.cornerRadius - 10 startAngle:startAngle endAngle:endAngle clockwise:NO];
         layer.lineCap = kCALineCapButt;
    }
    else {
        layer.strokeColor = [UIColor vinaColor].CGColor;
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.layer.cornerRadius, self.layer.cornerRadius) radius:self.layer.cornerRadius - 10 startAngle:startAngle endAngle:endAngle clockwise:YES];
         layer.lineCap = kCALineCapRound;
    }
    layer.path = path.CGPath;
   
    layer.lineWidth = 20.0;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.3;
    animation.repeatCount = 1.0;
    
    
    animation.fromValue = @(0.0f);
    animation.toValue   = @(1.0f);
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:@"fillDistanceAnimation"];
    
    [self.layer insertSublayer:layer below:_fillView.layer];
    [self setNeedsDisplay];
    
}

-(void)addDistanceIndicatorAtPoint:(CGPoint)point
{
    UIView *distanceIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 30.0, 30.0)];
    distanceIndicatorView.layer.cornerRadius = CGRectGetWidth(distanceIndicatorView.frame) / 2;
    distanceIndicatorView.layer.borderColor = [UIColor grayColor].CGColor;
    distanceIndicatorView.layer.borderWidth = 1.0;
    distanceIndicatorView.backgroundColor = [UIColor whiteColor];
    UILabel *distanceIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 10.0, 10.0)];
    distanceIndicatorLabel.text = @"5";
    distanceIndicatorLabel.textColor = [UIColor blackColor];
    distanceIndicatorLabel.center = CGPointMake(CGRectGetMidX(distanceIndicatorView.bounds), CGRectGetMidY(distanceIndicatorView.bounds));
    distanceIndicatorLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    distanceIndicatorView.alpha = 0.0;
    [distanceIndicatorView addSubview:distanceIndicatorLabel];
    [self addSubview:distanceIndicatorView];
    [self bringSubviewToFront:distanceIndicatorView];
    [self setNeedsDisplay];
    _distanceIndicatorView = distanceIndicatorView;
    _distanceIndicatorLabel = distanceIndicatorLabel;
    
    
}

@end
