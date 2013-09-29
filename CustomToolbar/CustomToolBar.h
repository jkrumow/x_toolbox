//
//  CustomToolBar.h
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

#import <UIKit/UIKit.h>

/**
 This class represents a custom toolbar with context buttons which can be added to the toolbar buttons.
 */
@interface CustomToolBar : UIView

@property (strong, nonatomic) NSArray *toolBarButtons;

/**
 Set to `YES` to add a shadow at the top edge of the CustomToolBar.
 */
@property (unsafe_unretained, nonatomic) BOOL showsShadow;

/**
 Adds an array of context buttons to a tool bar button.
 
 @param contextButtons The array of context buttons.
 @param toolBarButton  The toolbar button to be associated
 */
- (void)setContextButtons:(NSArray *)contextButtons forToolBarButton:(UIButton *)toolBarButton;

/**
 Hides context buttons.
 */
- (void)hideContextButtons;

@end
