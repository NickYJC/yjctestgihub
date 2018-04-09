//
//  ZMWCardLayout.m
//  ZMWCardDemo
//
//  Created by 张美文 on 16/9/21.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWCardLayout.h"

#define cardW 0.85;
#define cardLineSpacing -50;

@implementation ZMWCardLayout

- (instancetype)init{
    if (self = [super init]) {
        //
    }
    
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.showsHorizontalScrollIndicator = NO;

    self.minimumLineSpacing = cardLineSpacing;

    CGFloat itemW = self.collectionView.frame.size.width * cardW;
    CGFloat itemH = self.collectionView.frame.size.height * 1.0;
    self.itemSize = CGSizeMake(itemW, itemH);
    
    CGFloat inset = (self.collectionView.frame.size.width - itemW) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    DebugLog(@"visibleRect: %@", array);
    if (array.count < 2) {
        return array;
    }
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
////
//    DebugLog(@"visibleRect: %@", NSStringFromCGRect(visibleRect));
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat delta = ABS(centerX - attrs.center.x);
        
        CGFloat scale = 1 - delta / (self.collectionView.frame.size.width + self.itemSize.width);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat minDetal = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDetal) > ABS(attrs.center.x - centerX)) {
            minDetal = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minDetal, proposedContentOffset.y);
}

@end












































