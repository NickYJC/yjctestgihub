//
//  ZMWCardView.m
//  ZMWCardDemo
//
//  Created by 张美文 on 16/9/21.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWCardView.h"
#import "ZMWCardLayout.h"
#import "ZMWCardCell.h"
#import "GoingToStartModel.h"

@interface ZMWCardView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMWCardView

static NSString *const ZMWCardID = @"ZMWCardRestorationID";

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        [self setupUI];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
//    self.backgroundColor = [UIColor clearColor];
    
    [self requestGoingToStart];
    
    ZMWCardLayout *layout = [[ZMWCardLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = YES;

    [_collectionView registerNib:[UINib nibWithNibName:@"ZMWCardCell" bundle:nil] forCellWithReuseIdentifier:ZMWCardID];
    [self addSubview:_collectionView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
////        [self.dataArray addObject:@"1"];
////        [self.dataArray addObject:@"2"];
////        [self.dataArray addObject:@"3"];
////        [self.dataArray addObject:@"4"];
////        [self.dataArray addObject:@"5"];
////        [self.dataArray addObject:@"6"];
//        
//        [_collectionView reloadData];
//        if (self.block) {
//            self.block((int)self.dataArray.count, kZMWPreSellCardTypeNum);
//        }
//
//    });
    
}

#pragma mark -  GoingToStart  request
- (void)requestGoingToStart{
    ZMWWeakSelf(self)
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    [parm setValue:[NSNumber numberWithInt:1] forKey:@"page"];
    [parm setValue:[NSNumber numberWithInt:10] forKey:@"rows"];
    DebugLog(@"getUpcomingPreSaleGoods>>parm:%@", parm);
    
    //GET /getUpcomingPreSaleGoods
    [AFNetworkingTool  getJSONWithUrl:@"getUpcomingPreSaleGoods" parameters:parm success:^(id json) {
        NSDictionary *resulteDic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        DebugLog(@"success getUpcomingPreSaleGoods =%@ " ,resulteDic);
        if([[resulteDic objectForKey:@"code"]isEqualToString:@"000000"])
        {
            if ([[resulteDic objectForKey:@"data"]isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dicTemp =[resulteDic objectForKey:@"data"];
                
                if ([[dicTemp objectForKey:@"list"]isKindOfClass:[NSArray class]]) {
                    NSArray *endArray = [dicTemp objectForKey:@"list"];
                    
                    [weakself.dataArray removeAllObjects];
                    
                    for (NSDictionary *dic in endArray) {
                        
                        
                        
                        GoingToStartModel *model = [GoingToStartModel mj_objectWithKeyValues:dic];
                        DebugLog(@"sdgffdgfdsgfdg=%@ " ,model.remaining);
                        if ([model.remaining doubleValue] > 1000) {
                            //                        model.remaining = @"10000";
                            [weakself.dataArray addObject:model];
                           
                        }
                    }
                    
                    if (weakself.block) {
                        weakself.block((int)weakself.dataArray.count, kZMWPreSellCardTypeNum);
                    }
                }
            }else
            {
                [self showPromptBox:[resulteDic objectForKey:@"message"] type:kViewSVProgressTypeError];
            }
            
        }
        
        
           else
            {
                 [self showPromptBox:[resulteDic objectForKey:@"message"] type:kViewSVProgressTypeError];
            }
            
            [self.collectionView reloadData];
       
    } fail:^(NSError *error){
        
    }];
    
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMWWeakSelf(self)
    ZMWCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZMWCardID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    cell.block = ^(){
        [weakself requestGoingToStart];
    };
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectedItem: %ld", indexPath.item);
    if (self.pushBlock) {
        self.pushBlock(self.dataArray[indexPath.item]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取当前的偏移量，计算当前第几页
    
    int number = scrollView.contentOffset.x/(scrollView.bounds.size.width*0.85-50)+0.5;
    
    if (self.block) {
        self.block(number, kZMWPreSellCardTypeCurrent);
    }

}

#pragma mark - lazy
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc] init];
        
//        for (int i = 1; i<=1; i++) {
//            [self.dataArray addObject:[NSString stringWithFormat:@"%d", i+100]];
//        }
        
//        [self.dataArray removeAllObjects];
        
//        if (self.block) {
//            self.block((int)self.dataArray.count, kZMWPreSellCardTypeNum);
//        }
    }
    
    return _dataArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end




























































