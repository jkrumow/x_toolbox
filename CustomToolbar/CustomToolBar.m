//
//  CustomToolBar.m
//
//  Created by Julian Krumow on 13.04.12.
//
//  Copyright (c) 2012 Julian Krumow ()
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

#import <QuartzCore/QuartzCore.h>

#import "CustomToolBar.h"
#import "CustomContextButton.h"

@interface CustomToolBar()

@property (assign, nonatomic) NSInteger toolBarButtonIndex;

@property (strong, nonatomic) NSMutableDictionary *contextButtonsForToolBar;
@property (strong, nonatomic) UIView *contextButtonView;

/**
 Configures all neccessary parameters of the toolbar.
 */
- (void)configureToolBar;

/**
 Calculates the x-coordinate of the button layout.
 
 @return The calculated left edge.
 */
- (CGFloat)calculateLeftEdge;

/**
 Lays out toolbarButtons array. Buttons are always centered on x- and y-coordinate.
 */
- (void)layoutToolBarButtons;

/**
 Lays out all buttons in the given array. Buttons are always centered on x- and y-coordinate.
 
 @param contextButtons The given context buttons.
 */
- (void)layoutContextButtons:(NSArray *)contextButtons;

/**
 Notifies the receiver that a toolbar button has been pressed.
 
 @param sender The sender of this message.
 */
- (void)didPressToolBarButton:(id)sender;

/**
 Notifies the receiver that a context button has been pressed.
 
 @param sender The sender of this message.
 */
- (void)didPressContextButton:(id)sender;

/**
 Shows or hides the context buttons of a given toolbar button.
 
 @param toolBarButton The tool bar button
 */
- (void)toggleContextButtonsForToolBarButton:(UIButton *)toolBarButton;

/**
 Shows the context buttons of a given toolbar button of a given index.
 
 @param toolBarButtonIndex The index of the given toolbar button.
 */
- (void)showContextButtonsForToolBarButtonWithIndex:(NSUInteger)toolBarButtonIndex;

/**
 Hides the context buttons of a given toolbar button of a given index.
 
 @param toolBarButtonIndex The index of the given toolbar button.
 @param completion The completion block to be executed afterwards.
 */
- (void)hideContextButtonsForToolBarButtonWithIndex:(NSUInteger)toolBarButtonIndex withCompletion:(void (^)(BOOL finished))completion;

@end

@implementation CustomToolBar

@synthesize toolBarButtonIndex = _toolBarButtonIndex;
@synthesize contextButtonsForToolBar = _contextButtonsForToolBar;
@synthesize contextButtonView = _contextButtonView;

@synthesize toolBarButtons = _toolBarButtons;
@synthesize showsShadow = _showsShadow;

#define BUTTON_SPACING 10.0
#define INDEX_NONE -1

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self configureToolBar];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self configureToolBar];
    }
    return self;
}

- (void)configureToolBar
{
    self.backgroundColor = [UIColor lightGrayColor];
    self.autoresizesSubviews = YES;
    
    self.contextButtonsForToolBar = nil;
    self.toolBarButtonIndex = INDEX_NONE;
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.0;
    self.layer.shadowRadius = 3.0;
    
    self.showsShadow = YES;
}

#pragma mark - View Layout

- (void)layoutSubviews
{
    // Tool bar buttons and context view setup (only when not animating).
    [self layoutToolBarButtons];
    
    // Draw shadow around the edges.
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect pathRect = self.layer.bounds;
    CGPathAddRect(path, NULL, pathRect);
    self.layer.shadowPath = path;
    CGPathRelease(path);
}

- (CGFloat)calculateLeftEdge
{
    CGFloat centeredLayoutLeftEdge = self.bounds.size.width * 0.5;
    
    for (UIButton *button in self.toolBarButtons)
        centeredLayoutLeftEdge -= button.bounds.size.width * 0.5;
    
    centeredLayoutLeftEdge -= (BUTTON_SPACING * (self.toolBarButtons.count - 1) * 0.5);
    
    if (self.toolBarButtonIndex != INDEX_NONE)
        centeredLayoutLeftEdge -= (self.contextButtonView.bounds.size.width) * 0.5;
    
    return centeredLayoutLeftEdge;
}

- (void)layoutToolBarButtons
{
    CGFloat centeredLayoutLeftEdge = [self calculateLeftEdge];
    
    for (NSUInteger i=0; i < self.toolBarButtons.count; i++) {
        UIButton *button = [self.toolBarButtons objectAtIndex:i];
        
        CGRect frame = button.frame;
        frame.origin.x = centeredLayoutLeftEdge;
        frame.origin.y = (self.bounds.size.height - button.bounds.size.height) * 0.5;
        button.frame = frame;
        
        centeredLayoutLeftEdge += button.bounds.size.width + BUTTON_SPACING;
        
        // Layout contextButtonView when visible.
        if (self.toolBarButtonIndex == i) {
            CGRect frame = self.contextButtonView.frame;
            frame.origin.x = centeredLayoutLeftEdge;
            frame.origin.y = (self.bounds.size.height - self.contextButtonView.bounds.size.height) * 0.5;
            self.contextButtonView.frame = frame;
            centeredLayoutLeftEdge += (self.contextButtonView.bounds.size.width);
        }
    }
}

- (void)layoutContextButtons:(NSArray *)contextButtons
{
    // Layout buttons side by side in contextButtonView.
    CGFloat leftEdge = 0.0;
    for (CustomContextButton *button in contextButtons) {
        
        CGRect buttonFrame = button.frame;
        buttonFrame.origin.x = leftEdge;
        buttonFrame.origin.y = (self.bounds.size.height - button.bounds.size.height) * 0.5;
        button.frame = buttonFrame;
        
        [self.contextButtonView addSubview:button];
        
        leftEdge += button.bounds.size.width + BUTTON_SPACING;
    }
    self.contextButtonView.frame = CGRectMake(0.0, 0.0, leftEdge, self.bounds.size.height);
}

- (void)didPressToolBarButton:(id)sender
{
    UIButton *toolBarButton = (UIButton *)sender;
    [self toggleContextButtonsForToolBarButton:toolBarButton];
}

- (void)didPressContextButton:(id)sender
{
    CustomContextButton *contextButton = (CustomContextButton *)sender;
    if (contextButton.hidesContextButtonsWhenPressed)
        [self hideContextButtonsForToolBarButtonWithIndex:self.toolBarButtonIndex withCompletion:nil];
}

- (void)hideContextButtons
{
    if (self.toolBarButtonIndex != INDEX_NONE)
        [self hideContextButtonsForToolBarButtonWithIndex:self.toolBarButtonIndex withCompletion:nil];
}

- (void)toggleContextButtonsForToolBarButton:(UIButton *)toolBarButton
{
    NSUInteger toolBarButtonIndex = [self.toolBarButtons indexOfObject:toolBarButton];
    
    if (self.toolBarButtonIndex == INDEX_NONE)
        [self showContextButtonsForToolBarButtonWithIndex:toolBarButtonIndex];
    else
        if (self.toolBarButtonIndex == toolBarButtonIndex)
            [self hideContextButtonsForToolBarButtonWithIndex:toolBarButtonIndex withCompletion:nil];
        else {
            
            void(^completeShow)(BOOL) = ^(BOOL complete2) {
                [self showContextButtonsForToolBarButtonWithIndex:toolBarButtonIndex];
            };
            
            [self hideContextButtonsForToolBarButtonWithIndex:self.toolBarButtonIndex withCompletion:completeShow];
        }
}

#pragma mark - Animations

- (void)showContextButtonsForToolBarButtonWithIndex:(NSUInteger)toolBarButtonIndex
{
    self.toolBarButtonIndex = toolBarButtonIndex;
    
    if ([self.contextButtonsForToolBar objectForKey:[NSString stringWithFormat:@"%i", self.toolBarButtonIndex]]) {
        
        NSMutableArray *contextButtons = (NSMutableArray *)[self.contextButtonsForToolBar objectForKey:[NSString stringWithFormat:@"%i", self.toolBarButtonIndex]];
        
        [self layoutContextButtons:contextButtons];
        
        // Animate shift of toolBarButtons.
        void(^shift)(void) = ^(void) {
            
            [self layoutToolBarButtons];
        };
        
        // Fade in contextButtonView.
        void(^fadeIn)(void) = ^(void) {
            self.contextButtonView.alpha = 1.0;
        };
        
        void(^complete)(BOOL) = ^(BOOL complete) {
            
            // Display contextButtonView.
            self.contextButtonView.alpha = 0.0;
            [self addSubview:self.contextButtonView];
            
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                             animations:fadeIn completion:nil];
        };
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                         animations:shift completion:complete];
    }
}

- (void)hideContextButtonsForToolBarButtonWithIndex:(NSUInteger)toolBarButtonIndex withCompletion:(void (^)(BOOL finished))completion
{
    // Fade out contextButtonView.
    void(^fadeOut)(void) = ^(void) {
        
        self.toolBarButtonIndex = INDEX_NONE;
        self.contextButtonView.alpha = 0.0;
    };
    
    // Animate shift of toolBarButtons.
    void(^shift)(void) = ^(void) {
        
        [self layoutToolBarButtons];
    };
    
    // Remove contextButtonView.
    void(^complete2)(BOOL) = ^(BOOL complete2) {
        
        [self.contextButtonView removeFromSuperview];
        self.contextButtonView = nil;
        
        // Executing completion block.
        dispatch_async(dispatch_get_main_queue(), ^(void) {
			if (completion)
				completion(YES);
		});
    };
    
    void(^complete)(BOOL) = ^(BOOL complete) {
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                         animations:shift completion:complete2];
    };
    
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                     animations:fadeOut completion:complete];
}

#pragma mark - Accessor methods

- (void)setToolBarButtons:(NSArray *)toolBarButtons
{
    if (self.toolBarButtons == toolBarButtons)
        return;
    
    // If bogus objects have been passed - raise exception.
    for (id object in toolBarButtons)
        if ([object isKindOfClass:[UIButton class]] == NO)
            [NSException raise: NSInvalidArgumentException format: @"Objects in toolBarButtons array must be of class UIButton."];
    
    [self.toolBarButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _toolBarButtons = toolBarButtons;
    
    for (UIButton *button in self.toolBarButtons) {
        [self addSubview:button];
        [button addTarget:self action:@selector(didPressToolBarButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setContextButtons:(NSArray *)contextButtons forToolBarButton:(UIButton *)toolBarButton
{
    // If toolBarButton does not exist - raise exception.
    if ((toolBarButton == nil) || (self.toolBarButtons == nil) || ([self.toolBarButtons containsObject:toolBarButton] == NO))
        [NSException raise: NSInvalidArgumentException format: @"The given toolBarButton has not been registered as valid toolbarButton of this CustomToolBar."];
    
    NSUInteger toolBarButtonIndex = [self.toolBarButtons indexOfObject:toolBarButton];
    
    if (contextButtons) {
        // If bogus objects have been passed - raise exception.
        for (id object in contextButtons)
            if ([object isKindOfClass:[CustomContextButton class]] == NO)
                [NSException raise: NSInvalidArgumentException format: @"Objects in contextButtons array must be of class CustomContextButton."];
        
        for (CustomContextButton *contextButton in contextButtons)
            [contextButton addTarget:self action:@selector(didPressContextButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contextButtonsForToolBar setObject:contextButtons forKey:[NSString stringWithFormat:@"%i", toolBarButtonIndex]];
    } else
        [self.contextButtonsForToolBar removeObjectForKey:[NSString stringWithFormat:@"%i", toolBarButtonIndex]];
}

- (NSMutableDictionary *)contextButtonsForToolBar
{
    if (_contextButtonsForToolBar == nil)
        _contextButtonsForToolBar = [[NSMutableDictionary alloc] init];
    
    return _contextButtonsForToolBar;
}

- (UIView *)contextButtonView
{
    if (_contextButtonView == nil) {
        _contextButtonView = [[UIView alloc] initWithFrame:CGRectZero];
        _contextButtonView.autoresizesSubviews = YES;
    }
    return _contextButtonView;
}

- (void)setShowsShadow:(BOOL)showsShadow
{
    _showsShadow = showsShadow;
    
    self.layer.shadowOpacity = (float)_showsShadow;
    
    [self setNeedsDisplay];
}

@end
