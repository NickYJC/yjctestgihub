//
//  ZMWPopMenuLayout.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/15.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWPopMenuLayout.h"

static int items = 6;

@implementation ZMWPopMenuLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    self.itemSize = CGSizeMake((self.collectionView.bounds.size.width-(items/2-1))/(items/2), self.collectionView.bounds.size.height-20);

//    self.itemSize = CGSizeMake((self.collectionView.bounds.size.width-(items/2-1))/(items/2), self.collectionView.bounds.size.height/2-0.5);
}

@end
