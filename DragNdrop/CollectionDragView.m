//
//  CollectionDragView.m
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

#import "CollectionDragView.h"
#import "CollectionDragViewCell.h"

@interface CollectionDragView()

@property (strong, nonatomic) NSIndexPath *draggedIndexPath;
@property (strong, nonatomic) UILongPressGestureRecognizer *gestureRecognizer;

/**
 Evaluates the gesture recognizers state and send apropriate messages to the delegate.
 
 @param gestureRecognizer The given gesture recognizer to track the dragging events.
 */
- (void)moveActionGestureRecognizerStateChanged:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation CollectionDragView

@synthesize collectionDragViewDataSource = _collectionDragViewDataSource;
@synthesize collectionDragViewDelegate = _collectionDragViewDelegate;

@synthesize draggedIndexPath = _draggedIndexPath;
@synthesize gestureRecognizer = _gestureRecognizer;

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;
        
        self.bounces = YES;
        
        self.backgroundColor = [UIColor darkGrayColor];
        
        // Add gesture recognizer to the table view.
        _gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveActionGestureRecognizerStateChanged:)];
        self.gestureRecognizer.minimumPressDuration = 0.5;
        self.gestureRecognizer.delegate = self;
        [self addGestureRecognizer:self.gestureRecognizer];
    }
    return self;
}

- (void)setCollectionDragViewDelegate:(id<CollectionDragViewDelegate>)collectionDragViewDelegate
{
    if ((collectionDragViewDelegate != nil) && ([collectionDragViewDelegate conformsToProtocol:@protocol(CollectionDragViewDelegate)] == NO))
        [NSException raise:NSInvalidArgumentException format:@"Argument to -setCollectionDragViewDelegate must conform to the CollectionDragViewDelegate protocol"];
    
    _collectionDragViewDelegate = collectionDragViewDelegate;
    super.delegate = _collectionDragViewDelegate;
}

- (void)setCollectionDragViewDataSource:(id<CollectionDragViewDataSource>)libraryDataSource
{
    if ((libraryDataSource != nil) && ([libraryDataSource conformsToProtocol:@protocol(CollectionDragViewDataSource)] == NO))
        [NSException raise:NSInvalidArgumentException format:@"Argument to -setLibraryDataSource must conform to the CollectionDragViewDataSource protocol"];
    
    _collectionDragViewDataSource = libraryDataSource;
    super.dataSource = _collectionDragViewDataSource;
}


#pragma mark - UIGestureRecognizer Delegate/Actions

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Handle our own gesture recognizer when touch is over a valid cell.
    if (gestureRecognizer == self.gestureRecognizer) {
        
        CGPoint location = [gestureRecognizer locationInView:self];
        if ([self indexPathForItemAtPoint:location])
            return YES;
        
        return NO;
    }
    
    // Handle every other gesture recognizer.
    return YES;
}

- (void)moveActionGestureRecognizerStateChanged:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
            
        default:
        case UIGestureRecognizerStateFailed:
            self.draggedIndexPath = nil;
            break;
            
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
        {
            if (self.draggedIndexPath != nil)
                if ([self.collectionDragViewDelegate respondsToSelector:@selector(collectionDragView:draggingCancelledForItemAtIndex:gestureRecognizer:)])
                    [self.collectionDragViewDelegate collectionDragView:self draggingCancelledForItemAtIndex:self.draggedIndexPath gestureRecognizer:gestureRecognizer];
            self.draggedIndexPath = nil;
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            if (self.draggedIndexPath != nil)
                if ([self.collectionDragViewDelegate respondsToSelector:@selector(collectionDragView:userDroppedItemAtIndex:gestureRecognizer:)])
                    [self.collectionDragViewDelegate collectionDragView:self userDroppedItemAtIndex:self.draggedIndexPath gestureRecognizer:gestureRecognizer];
            self.draggedIndexPath = nil;
            break;
        }
            
        case UIGestureRecognizerStateBegan:
        {
            // Is touch actually above an item?
            CGPoint location = [gestureRecognizer locationInView:self];
            self.draggedIndexPath = [self indexPathForItemAtPoint:location];
            
            if (self.draggedIndexPath != nil) {
                UICollectionViewCell <CollectionDragViewCell> *cell = (UICollectionViewCell <CollectionDragViewCell> *)[self cellForItemAtIndexPath:self.draggedIndexPath];
                CollectionDraggableView *dragView = [cell dragViewRepresentation];
                
                if ([self.collectionDragViewDelegate respondsToSelector:@selector(collectionDragView:userBeganDraggingItem:atIndex:gestureRecognizer:)])
                    [self.collectionDragViewDelegate collectionDragView:self userBeganDraggingItem:dragView atIndex:self.draggedIndexPath gestureRecognizer:gestureRecognizer];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            if (self.draggedIndexPath != nil)
                if ([self.collectionDragViewDelegate respondsToSelector:@selector(collectionDragView:userDraggedItemAtIndex:gestureRecognizer:)])
                    [self.collectionDragViewDelegate collectionDragView:self userDraggedItemAtIndex:self.draggedIndexPath gestureRecognizer:gestureRecognizer];
            break;
        }
    }
}

@end
