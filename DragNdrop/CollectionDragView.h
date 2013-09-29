//
//  CollectionDragView.h
//
//  Created by julian krumow on 05.12.12.
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
#import "CollectionDraggableView.h"

@protocol CollectionDragViewDataSource;
@protocol CollectionDragViewDelegate;

/**
 This class represents a UICollectionView subtype whose items can be dragged out. Delegates must implement the 
 CollectionDragViewDataSource and CollectionDragViewDelegate which are inherit UICollectionViewDataSource and UICollectionViewDelegate.
 */
@interface CollectionDragView : UICollectionView <UIGestureRecognizerDelegate>

@property (weak, nonatomic) id<CollectionDragViewDataSource> collectionDragViewDataSource;
@property (weak, nonatomic) id<CollectionDragViewDelegate> collectionDragViewDelegate;

@end

/**
 This protocol must be implemented by the data source of this view class.
 */
@protocol CollectionDragViewDataSource <UICollectionViewDataSource>

@end

/**
 This protocol sends messages about a CollectionDraggableItem being dragged from the CollectionDragView.
 */
@protocol CollectionDragViewDelegate <UICollectionViewDelegate>

/**
 The user began dragging a CollectionDraggableItem.
 
 @param collectionDragView   The CollectionDragView sending the message
 @param item                 The CollectionDraggableItem being dragged
 @param indexPath            The item's index path
 @param gestureRecognizer    The geture recognizer tracking the drag event
 */
- (void)collectionDragView:(CollectionDragView *)collectionDragView userBeganDraggingItem:(CollectionDraggableView *)item atIndex:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

/**
 The user has dragged a grid view cell to a new location.
 
 @param collectionDragView   The CollectionDragView sending the message
 @param indexPath            The item's index path
 @param gestureRecognizer    The geture recognizer tracking the drag event
 */
- (void)collectionDragView:(CollectionDragView *)collectionDragView userDraggedItemAtIndex:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

/**
 The user has dropped a grid view cell.
 
 @param collectionDragView   The CollectionDragView sending the message
 @param indexPath            The item's index path
 @param gestureRecognizer    The geture recognizer tracking the drag event
 */
- (void)collectionDragView:(CollectionDragView *)collectionDragView userDroppedItemAtIndex:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;


/**
 Dragging was canceled.
 
 @param collectionDragView   The CollectionDragView sending the message
 @param indexPath            The item's index path
 @param gestureRecognizer    The geture recognizer tracking the drag event
 */
- (void)collectionDragView:(CollectionDragView *)collectionDragView draggingCancelledForItemAtIndex:(NSIndexPath *)indexPath gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

@end