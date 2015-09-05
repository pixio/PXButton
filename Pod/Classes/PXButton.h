//
//  PXButton.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PXButtonIconPosition)
{
    PXButtonIconPositionNone = 0,
    PXButtonIconPositionLeft,
    PXButtonIconPositionRight,
    PXButtonIconPositionCenter
};

/**
 *  Custom button class. Buttons can have centered icons, centered pairs of icons and text with either icon on the left or right.
 */
@interface PXButton : UIButton

/**
 *  The color of the border around the button.
 */
@property (nonatomic) UIColor* borderColor;

/**
 *  The width of the border around the button.
 */
@property (nonatomic) CGFloat borderWidth;

/**
 *  The corner radius of the button.
 */
@property (nonatomic) CGFloat cornerRadius;

/**
 *  Whether or not the button is filled with just backgroundColor or a gradient from backgroundColor to a color slightly darker.
 */
@property (nonatomic) BOOL usesSubtleGradient;

/**
 *  Where the icon on the button is drawn.
 */
@property (nonatomic) PXButtonIconPosition iconPosition;

/**
 *  The width and height of the bounding box for the icon.  
 *  The default value of this property (0) indicates that the height of the text drawing rect should be used instead.
 */
@property (nonatomic) CGFloat iconSize;

/**
 *  Make a new button instance.
 *
 *  @return a new button instance.
 */
+ (instancetype) button;

/**
 *  The font for the title in this button.
 */
@property (nonatomic) UIFont* font UI_APPEARANCE_SELECTOR;

/**
 *  Set the image for the button and specifiy whether or not the image should be tinted or colored.
 *
 *  @param image the icon
 *  @param state the control state the image is used for
 *  @param tint  whether or not to tint the image or use its original color
 */
- (void)setImage:(UIImage *)image forState:(UIControlState)state tint:(BOOL)tint;

/**
 *  Set the image for the button and indicate what position it will be relative to the title.
 *  The iconPosition is either none for no icon, left of the text, right of the text, or centered.
 *  This implementation defaults to tinted image.
 *
 *  @param image        the icon
 *  @param iconPosition the position relative to the title
 *  @param state        the control state for this image
 */
- (void)setImage:(UIImage *)image atPosition:(PXButtonIconPosition)iconPosition forState:(UIControlState)state;

/**
 *  Set the image for the button and indicate what position it will be relative to the title.
 *  The iconPosition is either none for no icon, left of the text, right of the text, or centered.
 *  @c tint indicates whether or not the image should be tinted with the tint color for the button or left with its original color.
 *
 *  @param image        the icon
 *  @param iconPosition the position relative to the title
 *  @param state        the control state for this image
 *  @param tint         whether or not to tint the image or use its original color
 */
- (void)setImage:(UIImage *)image atPosition:(PXButtonIconPosition)iconPosition forState:(UIControlState)state tint:(BOOL)tint;

@end
