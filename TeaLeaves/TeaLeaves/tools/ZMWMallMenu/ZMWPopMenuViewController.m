//
//  ZMWPopMenuViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/15.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWPopMenuViewController.h"
#import "ZMWPopMenuCollectionViewCell.h"

static NSString * const reuseIdentifier = @"ZMWPopMenuViewIdentifier";

@interface ZMWPopMenuViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ZMWPopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZMWPopMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

}

#pragma mark - buttonAction
- (IBAction)buttonAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:ZMWPopMenuViewControllerButtonNotice object:nil];
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMWPopMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.titleBtn setTitle:self.dataArray[indexPath.item] forState:UIControlStateNormal];
    [cell.titleBtn setTitle:self.dataArray[indexPath.item] forState:UIControlStateSelected];
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:ZMWPopMenuViewControllerIndex];
    if (index == indexPath.item) {
        [cell.titleBtn setSelected:YES];
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    DebugLog(@"didSelectItemAtIndexPath: %ld", indexPath.item);
    ZMWPopMenuCollectionViewCell *cell = (ZMWPopMenuCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleBtn.selected = YES;
    
    if (self.block) {
        self.block(indexPath.item);
    }
    
    // 消失menu延时动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ZMWPopMenuViewControllerButtonNotice object:nil];

    });

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    DebugLog(@"didDeselectItemAtIndexPath: %ld", indexPath.item);
    ZMWPopMenuCollectionViewCell *cell = (ZMWPopMenuCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleBtn.selected = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
