//
//  CollectionDropViewController.h
//
//  Created by julian krumow on 18.11.12.
//
//  Copyright (c) 2012 Julian Krumow.
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

#import <Foundation/Foundation.h>

/**
 This protocol defines methods used to tell the receiver that a CollectionDraggableView has been dropped onto a CollectionDropViewController's dropzone view.
 
 Used in conjunction with CollectionDragView and CollectionDragViewControllerDelegate.
 */
@protocol CollectionDropViewController <NSObject>

/**
 Returns the view for the given drop zone.
 
 @return The view used as drop zone.
 */
- (UIView *)viewForDropZone;

/**
 Checks wether the given CGPoint is a valid drop location.
 
 @param draggableView The CollectionDraggableView in question
 @param point         The center point of the given view
 
 @return `YES` if drop location is valid.
 */
- (BOOL)canDropView:(CollectionDraggableView *)draggableView atPoint:(CGPoint)point;

/**
 The draggable view has been moved to the specified location.
 
 @param draggableView The CollectionDraggableView in question
 @param point         The center point of the given view
 */
- (void)draggableView:(CollectionDraggableView *)draggableView movedToPoint:(CGPoint)point;

/**
 The draggable view has been dropped above the specified location.
 
 @param draggableView The CollectionDraggableView in question
 @param point         The center point of the given view
 */
- (void)draggableView:(CollectionDraggableView *)draggableView droppedAtPoint:(CGPoint)point;

/**
 Moving the draggable view has been cancelled above the specified location.
 
 @param draggableView The CollectionDraggableView in question
 @param point         The center point of the given view
 */
- (void)draggableView:(CollectionDraggableView *)draggableView cancelledDraggingAtPoint:(CGPoint)point;

@end
