//
//  PXButton.m
//
//  Created by Daniel Blakemore on 4/4/14.
//
//  Copyright (c) 2015 Pixio
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "PXButton.h"

#define PXButtonIconSpacing 4.0f
#define PXButtonVerticalPadding 8.0f
#define PXButtonDefaultCornerRadius 8.0f

@implementation PXButton
{
    UIColor * _backgroundColor;
}

+ (instancetype)button
{
    return [self new];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;
    
    [super setBackgroundColor:[UIColor clearColor]];
    [[self titleLabel] setFont:[self font]];
    [[self imageView] setContentMode:UIViewContentModeScaleAspectFit];
    
    _iconPosition = PXButtonIconPositionNone;
    [self setCornerRadius:PXButtonDefaultCornerRadius];
    
    return self;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [self setImage:image forState:state tint:TRUE];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state tint:(BOOL)tint
{
    [super setImage:image forState:state];
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image atPosition:(PXButtonIconPosition)iconPosition forState:(UIControlState)state
{
    [self setImage:image atPosition:iconPosition forState:state tint:TRUE];
}

- (void)setImage:(UIImage *)image atPosition:(PXButtonIconPosition)iconPosition forState:(UIControlState)state tint:(BOOL)tint
{
    [self setImage:image forState:state tint:tint];
    [self setIconPosition:iconPosition];
}

- (UIColor *)tintColor
{
    return [super tintColor];
}

- (void)setIconPosition:(PXButtonIconPosition)iconPosition
{
    _iconPosition = iconPosition;
    [self setNeedsLayout];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setNeedsLayout];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    // needs to be here for this to work.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

#pragma mark - UIButton methods

+ (id)buttonWithType:(UIButtonType)buttonType
{
    return [self button];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = CGSizeMake(UIViewNoIntrinsicMetric, 24);
    size.height += PXButtonVerticalPadding;
    return size;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    CGSize size = titleRect.size;
    CGPoint origin = CGPointMake(CGRectGetMidX(contentRect) - size.width / 2.0f, CGRectGetMidY(contentRect) - size.height / 2.0f);
    
    switch (_iconPosition) {
        case PXButtonIconPositionLeft:
            origin.x += (PXButtonIconSpacing + size.height) / 2.0f;
            break;
        case PXButtonIconPositionRight:
            origin.x -= (PXButtonIconSpacing + size.height) / 2.0f;
            break;
        case PXButtonIconPositionCenter:
            break;
        case PXButtonIconPositionNone:
        default:
            break;
    }
    
    return (CGRect){.origin = origin, .size = size};
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    CGSize size;
    
    if (_iconSize) {
        size = CGSizeMake(_iconSize, _iconSize);
    } else {
        size = CGSizeMake(titleRect.size.height, titleRect.size.height);
    }
    
    CGPoint origin = titleRect.origin;
    
    origin.y = CGRectGetMidY(titleRect) - size.height / 2.0f;
    
    switch (_iconPosition) {
        case PXButtonIconPositionLeft:
            origin.x = CGRectGetMinX(titleRect) - (PXButtonIconSpacing + size.height);
            break;
        case PXButtonIconPositionRight:
            origin.x = CGRectGetMaxX(titleRect) + PXButtonIconSpacing;
            break;
        case PXButtonIconPositionCenter:
            origin.x = CGRectGetMidX([self bounds]) - size.width / 2.0f;
            origin.y = CGRectGetMidY([self bounds]) - size.height / 2.0f;
            break;
        case PXButtonIconPositionNone:
        default:
            origin = CGPointZero;
            size = CGSizeZero;
            break;
    }
    
    return (CGRect){.origin = origin, .size = size};
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = [backgroundColor copy];
    [self setNeedsDisplay];
}

- (UIColor *)backgroundColor
{
    return _backgroundColor;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSAssert(context, @"WUUUUUUUT");
    
    CGContextSaveGState(context);
    
    // Get HSB values for the background color
    CGFloat hue, saturation, brightness, alpha;
    UIColor* color = (_backgroundColor ?: [UIColor lightGrayColor]);
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha] != TRUE)
    {
        // Assume it's a grayscale color
        CGFloat* components = (CGFloat*)CGColorGetComponents([color CGColor]);
        hue = 0.0f;
        saturation = 0.0f;
        brightness = components[0];
        alpha = components[1];
    }
    
    // Get HSB values for the border color. If no border color is supplied, skew the brightness of the background color
    CGFloat bHue, bSaturation, bBrightness, bAlpha;
    UIColor* borderColor = _borderColor;
    if (borderColor == nil)
    {
        bHue = hue;
        bSaturation = saturation;
        bBrightness = MAX(brightness - 0.10f, 0.0f);
        bAlpha = alpha;
    }
    else if ([borderColor getHue:&bHue saturation:&bSaturation brightness:&bBrightness alpha:&bAlpha] != TRUE)
    {
        // Assume it's a grayscale color
        CGFloat* components = (CGFloat*)CGColorGetComponents([borderColor CGColor]);
        bHue = 0.0f;
        bSaturation = 0.0f;
        bBrightness = components[0];
        bAlpha = components[1];
    }
    
    
    // Adjust the colors based on the state of the button
    if ([self isEnabled] == FALSE)
    {
        alpha /= 2.0f;
        bAlpha /= 2.0f;
    }
    else if ([self isHighlighted] == TRUE)
    {
        brightness /= 2.0f;
        bBrightness /= 2.0f;
    }
    
    if (!_usesSubtleGradient) {
        CGContextSetFillColorWithColor(context, [[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] CGColor]);
    } else {
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        [(CAGradientLayer*)[self layer] setColors:@[(id)[[UIColor colorWithHue:hue saturation:saturation brightness:brightness * 1.0 alpha:alpha] CGColor],
                                                    (id)[[UIColor colorWithHue:hue saturation:saturation brightness:brightness * 0.95 alpha:alpha] CGColor],
                                                    (id)[[UIColor colorWithHue:hue saturation:saturation brightness:brightness * 0.9 alpha:alpha] CGColor]]];
        [(CAGradientLayer*)[self layer] setLocations:nil];
        [[self layer] setCornerRadius:_cornerRadius];
    }
    
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithHue:bHue saturation:bSaturation brightness:bBrightness alpha:bAlpha] CGColor]);
    
    CGFloat borderWidth = MAX(0.0f, _borderWidth);
    CGContextSetLineWidth(context, borderWidth);
    
    
    CGFloat inset = borderWidth / 2.0f;
    CGContextAddPath(context, [[UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, inset, inset) cornerRadius:_cornerRadius] CGPath]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextRestoreGState(context);
}

+ (Class) layerClass
{
    return [CAGradientLayer class];
}

@end
