//
//  EyeView.m
//  ViewTest
//
//  Created by 陈杰 on 2017/5/10.
//  Copyright © 2017年 陈杰. All rights reserved.
//

#import "EyeView.h"

@interface EyeView ()

@property (strong, nonatomic) CAShapeLayer *eyeFirstLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeSecondLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeballLayer;
@property (strong, nonatomic) CAShapeLayer *topEyesocketLayer;
@property (strong, nonatomic) CAShapeLayer *bottomEyesocketLayer;

@end

@implementation EyeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.height*1.2, frame.size.height)];
    
    if (self) {
        
        [self.layer addSublayer:self.eyeFirstLightLayer];
        [self.layer addSublayer:self.eyeSecondLightLayer];
        [self.layer addSublayer:self.eyeballLayer];
        [self.layer addSublayer:self.topEyesocketLayer];
        [self.layer addSublayer:self.bottomEyesocketLayer];
        
        [self setupAnimation];
    }
    
    return self;
}

- (void)setupAnimation {
    self.eyeFirstLightLayer.lineWidth = 0.f;
    self.eyeSecondLightLayer.lineWidth = 0.f;
    self.eyeballLayer.opacity = 0.f;
    self.bottomEyesocketLayer.strokeStart = 0.5f;
    self.bottomEyesocketLayer.strokeEnd = 0.5f;
    self.topEyesocketLayer.strokeStart = 0.5f;
    self.topEyesocketLayer.strokeEnd = 0.5f;
}

- (void)setProgress:(float)progress{
    if (progress < 0) {
        _progress = 0;
    }else if (progress > 100){
        _progress = 100;
    }else{
        _progress = progress;
    }
    
    NSLog( @"- value : %f -",_progress);

    if (_progress < 20) {
        
        _eyeFirstLightLayer.lineWidth = _progress / 4.0;
        _eyeSecondLightLayer.lineWidth = _progress / 4.0;
        
        _eyeballLayer.hidden = YES;
        _topEyesocketLayer.hidden = YES;
        _bottomEyesocketLayer.hidden = YES;

    }else if (_progress < 50){
        
        _eyeballLayer.opacity =  (_progress-20) / 30.0;
        
        _eyeballLayer.hidden = NO;
        _topEyesocketLayer.hidden = YES;
        _bottomEyesocketLayer.hidden = YES;

    }else{
        _eyeballLayer.hidden = NO;
        _topEyesocketLayer.hidden = NO;
        _bottomEyesocketLayer.hidden = NO;
        
        _topEyesocketLayer.strokeStart = (100 - _progress)/100.0;
        _topEyesocketLayer.strokeEnd = 1-(_topEyesocketLayer.strokeStart);
        
        _bottomEyesocketLayer.strokeStart = _topEyesocketLayer.strokeStart;
        _bottomEyesocketLayer.strokeEnd = _topEyesocketLayer.strokeEnd;
    }
}


- (CAShapeLayer *)eyeFirstLightLayer{
    
    if (_eyeFirstLightLayer == nil) {
        
        _eyeFirstLightLayer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
                                                            radius:CGRectGetHeight(self.frame) * 0.2
                                                        startAngle:230.0/180.0 * M_PI
                                                          endAngle:265.0/180.0 * M_PI
                                                         clockwise:YES];
        
        _eyeFirstLightLayer.lineWidth = 5.f;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
 
    }
    
    return _eyeFirstLightLayer;
}


- (CAShapeLayer *)eyeSecondLightLayer {
    if (_eyeSecondLightLayer == nil) {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
                                                            radius:CGRectGetHeight(self.frame) * 0.2
                                                        startAngle:211.0/180.0 * M_PI
                                                          endAngle:220.0/180.0 * M_PI
                                                         clockwise:YES];
        
        _eyeSecondLightLayer.lineWidth = 5.f;
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeSecondLightLayer;
}

- (CAShapeLayer *)eyeballLayer {
    if (_eyeballLayer == nil) {
        _eyeballLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
                                                            radius:CGRectGetHeight(self.frame) * 0.3
                                                        startAngle:(0.f / 180.f) * M_PI
                                                          endAngle:(360.f / 180.f) * M_PI
                                                         clockwise:YES];
        
        _eyeballLayer.lineWidth = 1.f;
        _eyeballLayer.path = path.CGPath;
        _eyeballLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeballLayer.strokeColor = [UIColor whiteColor].CGColor;
//        _eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return _eyeballLayer;
}

- (CAShapeLayer *)topEyesocketLayer{
    
    if (_topEyesocketLayer == nil) {
        
        _topEyesocketLayer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)/2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)
                     controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)*1.2)];
        
        _topEyesocketLayer.lineWidth = 1.f;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
 
    }
    
    return _topEyesocketLayer;
}

- (CAShapeLayer *)bottomEyesocketLayer{
    
    if (_bottomEyesocketLayer == nil) {
        
        _bottomEyesocketLayer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)/2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)
                     controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, -CGRectGetHeight(self.frame)*0.2)];
        
        _bottomEyesocketLayer.lineWidth = 1.f;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
        
    }

    return _bottomEyesocketLayer;
}
@end
