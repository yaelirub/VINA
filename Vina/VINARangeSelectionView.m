//
//  VINADistanceSelectionView.m
//  Vina
//
//  Created by Yael Rubinstein on 7/18/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

#import "VINARangeSelectionView.h"
@import QuartzCore;

@interface VINARangeSelectionView ()
@property (nonatomic, strong) CAShapeLayer *shape;

@end

@implementation VINARangeSelectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        _shape = [CAShapeLayer layer];
         self.backgroundColor = [UIColor redColor];
        _shape.frame = self.bounds;
        _shape.lineWidth = 30.0f;
        _shape.strokeColor = [UIColor colorWithRed:233/255.0 green:233.0/255 blue:233.0/255 alpha:1.0].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        _shape.fillColor = [UIColor whiteColor].CGColor;
         [self.layer addSublayer:_shape];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
   
    CAShapeLayer *layer = (CAShapeLayer *)self.layer;
    UIBezierPath *path  = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds,0,0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    _shape.path = path.CGPath;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.shouldRasterize = YES;
    [path fill];

}


@end
