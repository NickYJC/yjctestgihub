//
//  ZMWMallContentView.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/11/18.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWMallContentView.h"

static NSString * const reuseIdentifier = @"ZMWMallViewIdentifier";

@interface ZMWMallLayout : UICollectionViewFlowLayout

@end

@implementation ZMWMallLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.itemSize = self.collectionView.size;
    self.collectionView.pagingEnabled = YES;

}

@end

@interface ZMWMallCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation ZMWMallCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
//        [self.contentView addSubview:self.contentLab];
    }
    
    return self;
}

- (UILabel *)contentLab {
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc] initWithFrame:self.bounds];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.textColor = [UIColor whiteColor];
        _contentLab.font = [UIFont systemFontOfSize:18];
        _contentLab.adjustsFontSizeToFitWidth = YES;
    }
    
    return _contentLab;
}

@end

@interface ZMWMallContentView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) ZMWMallLayout *layout;
@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation ZMWMallContentView

- (instancetype)initWithFrame:(CGRect)frame contentItems:(NSArray<NSString *> *)items fetchCompletionHandler:(ZMWMallContentViewBlock)block {
    if (self = [super initWithFrame:frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
        //
        self.block = block;
        [self.itemsArray addObjectsFromArray:items];
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor lightGrayColor];
        self.collectionViewLayout = self.layout;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ZMWMallCell class] forCellWithReuseIdentifier:reuseIdentifier];

    }
    
    return self;
}

#pragma mark - UICollectionView delegate and dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMWMallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeAllObjects)];
    
    UIViewController *vctr = self.mallVctr.childViewControllers[indexPath.item];
//    if ([vctr isViewLoaded]) return cell;

    DebugLog(@"vctr: %@", vctr);
    vctr.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [cell.contentView addSubview:vctr.view];

//    cell.contentLab.text = [NSString stringWithFormat:@"第%lu页", indexPath.item];
    
    return cell;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.itemsArray.count - 1) return;
//    DebugLog(@"scale: %f", scrollView.contentOffset.x / scrollView.frame.size.width);
    
    if (self.block) {
        self.block(scale, kZMWMallContentViewTypeDidScroll, scrollView);
    }

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (self.block) {
        self.block(0, kZMWMallContentViewTypeUnDidScroll, scrollView);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - lazy

- (ZMWMallLayout *)layout {
    if (_layout == nil) {
        _layout = [[ZMWMallLayout alloc] init];
    }
    
    return _layout;
}

- (NSMutableArray *)itemsArray {
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray array];
    }
    
    return _itemsArray;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
