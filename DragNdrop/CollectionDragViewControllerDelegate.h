//
//  CollectionDragViewControllerDelegate.h
//
//  Created by julian krumow on 19.11.12.
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

#import <Foundation/Foundation.h>
#import "CollectionDraggableView.h"

/**
 This protocol defines methods used to tell the receiver that a CollectionDraggableView object is being dragged out of a UICollectionView.
 
 Used in conjunction with CollectionDragView and CollectionDropViewController.
 */
@protocol CollectionDragViewControllerDelegate <NSObject>

/**
 The user began dragging an item.
 
 @param collectionDragViewController The view controller sending the message
 @param item                         The item being dragged
 @param indexPath                    The item's index path
 @param gestureRecognizer            The gesture recognizer tracking the drag event
 */
- (void)collectionDragViewController:(UIViewController *)collectionDragViewController userBeganDraggingItem:(CollectionDraggableView *)item atIndexPath:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

/**
 The user has dragged an item.
 
 @param collectionDragViewController The view controller sending the message
 @param indexPath                    The item's index path
 @param gestureRecognizer            The gesture recognizer tracking the drag event
 */
- (void)collectionDragViewController:(UIViewController *)collectionDragViewController userDraggedItemAtIndexPath:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

/**
 The user has dropped an item.
 
 @param collectionDragViewController The view controller sending the message
 @param indexPath                    The item's index path
 @param gestureRecognizer            The gesture recognizer tracking the drag event
 */
- (void)collectionDragViewController:(UIViewController *)collectionDragViewController userDroppedItemAtIndexPath:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

/**
 Dragging was canceled.
 
 @param collectionDragViewController The view controller sending the message
 @param indexPath                    The item's index path
 @param gestureRecognizer            The gesture recognizer tracking the drag event
 */
- (void)collectionDragViewController:(UIViewController *)collectionDragViewController draggingCancelledForItemAtIndexPath:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

@end
