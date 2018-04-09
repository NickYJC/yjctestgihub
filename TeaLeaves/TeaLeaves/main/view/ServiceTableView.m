//
//  serviceTableView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/9.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "ServiceTableView.h"
#import "ServiceTabSectionView.h"

@interface ServiceTableView()<UITableViewDataSource, UITableViewDelegate>
//{
//    ServiceTabSectionView *_sectionView;
//}
@property(nonatomic)NSMutableArray *status;
@end

@implementation ServiceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        [self createData];

        self.delegate = self;
        self.dataSource = self;
        [self createHeaderView];
    }
    
    return self;
}

-(void)createData
{
    NSArray *arr = @[@[@"T0102901",@"E01201",@"普洱",@"自提1",@"100",@"云南1",@"已发货"],
                     @[@"T0102901",@"E01201",@"普洱",@"自提2",@"100",@"云南2",@"已发货"],
                     @[@"T0102901",@"E01201",@"普洱",@"自提3",@"100",@"云南3",@"已发货"],
                     @[@"T0102901",@"E01201",@"普洱",@"自提4",@"100",@"云南4",@"已发货"]];
    [self.titles addObjectsFromArray:arr];
    for (NSString *name in arr) {
        NSMutableArray *ac = [NSMutableArray array];
        for (NSInteger i = 0; i <10; i++) {
            NSString *str = [NSString stringWithFormat:@"测试数据: %lu",(long)i];
            [ac addObject:str];
        }
        [self.status addObject:@0];
        [self.data addObject:ac];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.titles removeAllObjects];
        [self.titles addObjectsFromArray:@[@[@"T0102901",@"E01201",@"普洱5",@"自提",@"100",@"云南1",@"已发货"],
                                           @[@"T0102901",@"E01201",@"普洱5",@"自提",@"100",@"云南2",@"已发货"],
                                           @[@"T0102901",@"E01201",@"普洱5",@"自提",@"100",@"云南3",@"已发货"],
                                           @[@"T0102901",@"E01201",@"普洱5",@"自提",@"100",@"云南4",@"已发货"]]];
    });
    
}

-(NSMutableArray *)data{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    
    return _data;
}

-(NSMutableArray *)status{
    if (_status == nil) {
        _status = [NSMutableArray array];
    }
    
    return _status;
}

-(NSMutableArray *)titles{
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    
    return _titles;
}


- (void)createHeaderView{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.00f];
    self.tableHeaderView = headerView;
    
    NSArray * array = @[@"单号",@"商品",@"方式",@"数量",@"仓库",@"状态"];
    for (int i = 0; i < array.count; i++) {
        UILabel * label = [[UILabel alloc] init];
        if (i == 0){
            label.frame = CGRectMake(0 , 5, kScreenWidth/6+50, 21);
        }
        else {
            label.frame = CGRectMake((50-(i-1)*10) + i * (kScreenWidth/6-5), 5, kScreenWidth/6-10, 21);
        }
        
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        [headerView addSubview:label];
    }
    
    [self addSubview:headerView];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    BOOL status = [_status[section] boolValue];
    NSArray *title = _titles[section];
    ServiceTabSectionView * sectionView = [[ServiceTabSectionView alloc] initWithFrame:CGRectMake(0, 0, 60, 60) clickButtonComplete:^{
        NSNumber *num = status? @0 :@1;
        [_status replaceObjectAtIndex:section withObject:num];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }];

    [sectionView updateSectionView:title WithStatus:status];

    return sectionView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _data.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_status[section] isEqualToNumber:@0]) {
        return 0;
    }
    return [_data[section] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _data[indexPath.section][indexPath.row];
//    NSLog(@"%@", _data[indexPath.section][indexPath.row]);
    return cell;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
