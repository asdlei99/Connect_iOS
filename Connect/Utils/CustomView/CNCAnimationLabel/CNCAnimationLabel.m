////  CNCAnimationLabel.m
//  Connect
//
//  Created by Dwang on 2018/9/20.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAnimationLabel.h"

@interface CNCAnimationLabel ()

@property(nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CNCAnimationLabel

- (void)setText:(NSString *)text {
    [self layoutIfNeeded];
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.geometryFlipped = YES;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = (self.lineWidth?self.lineWidth:0.5);
    self.shapeLayer.lineJoin = kCALineJoinRound;
    UIBezierPath *path = [self bezierPathWithText:text attributes:@{NSFontAttributeName : UIFontMake(self.fontSize?self.fontSize:14)}];
    self.shapeLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = (self.strokeColor?self.strokeColor:UIColorBlack).CGColor;
    [self.shapeLayer removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.25f;
    pathAnimation.fromValue = @(0.1);
    pathAnimation.toValue = @(1.0);
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(pathAnimation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.shapeLayer.fillColor = (weakSelf.fill?(weakSelf.strokeColor?weakSelf.strokeColor:UIColorBlack):UIColorClear).CGColor;
    });
    [self.shapeLayer addAnimation:pathAnimation forKey:@"path_animation"];
    [self.layer addSublayer:self.shapeLayer];
}

- (UIBezierPath *)bezierPathWithText:(NSString *)text attributes:(NSDictionary *)attrs; {
    NSAssert(text!= nil && attrs != nil, @"参数不能为空");
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:attrs];
    CGMutablePathRef paths = CGPathCreateMutable();
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef path = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(paths, &t,path);
                CGPathRelease(path);
            }
        }
    }
    CFRelease(line);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    CGPathRelease(paths);
    return path;
}

@end


