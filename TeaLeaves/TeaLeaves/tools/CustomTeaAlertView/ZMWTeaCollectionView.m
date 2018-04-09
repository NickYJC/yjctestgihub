//
//  ZMWTeaCollectionView.m
//  TeaLeaves
//
//  Created by 张美文 on 16/9/28.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWTeaCollectionView.h"
#import "ZMWTeaCollectionViewCell.h"

static NSString * const reuseIdentifier = @"ZMWTeaIdentifier";

@interface ZMWTeaViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation ZMWTeaViewFlowLayout

- (void)prepareLayout {
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 20;
    CGSize size = self.collectionView.size;
    size.width = self.collectionView.size.width-20;
    self.itemSize = size;
    CGFloat inset = (self.collectionView.frame.size.width - size.width)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;

}

@end

@interface ZMWTeaCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) ZMWTeaViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZMWTeaCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //
        self.collectionViewLayout = self.layout;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"ZMWTeaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    DebugLog(@"contentSize: %@", NSStringFromCGSize(self.contentSize));
}

- (ZMWTeaViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[ZMWTeaViewFlowLayout alloc] init];
    }
    
    return _layout;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"1"];
//        [_dataArray addObject:@"1"];
//        [_dataArray addObject:@"1"];
//        [_dataArray addObject:@"1"];
//        [_dataArray addObject:@"1"];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [_dataArray removeAllObjects];
//            [_dataArray addObject:@"1"];
//            [self reloadData];
//        });

    }
    
    if (self.block) {
        self.block((int)_dataArray.count, kZMWPreSellCardTypeNum);
    }
    
    return _dataArray;
}

#pragma mark - collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMWTeaCollectionViewCell *cell = (ZMWTeaCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.urlString = self.urlString;
//    [cell.imageBtn setImage:[UIImage imageNamed:self.dataArray[indexPath.item]] forState:UIControlStateNormal];
//    cell.titleLab.text = self.titleArray[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DebugLog(@"indexPath: %@", indexPath);
    
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int number = scrollView.contentOffset.x/scrollView.bounds.size.width+0.5;
    
    if (self.block) {
        self.block(number, kZMWPreSellCardTypeCurrent);
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
