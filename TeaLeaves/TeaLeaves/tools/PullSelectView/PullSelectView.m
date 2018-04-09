//
//  pullSelectView.m
//  textAFNetworking
//
//  Created by 张美文 on 15/11/9.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "PullSelectView.h"
//#import "FindAllBankModel.h"

#define CELLHeight 40
#define TimeOut 0.3

@interface PullSelectView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) NSInteger index;

@end

@implementation PullSelectView

- (instancetype)showSelectView:(UIButton *)button elementArray:(NSArray *)arr onClickButtonAction:(PullSelectViewBlock)block{
    _button = button;
    self.block = block;
    self.isShow = NO;
    if (self == [super init]) {
        CGRect btnFrame = button.frame;
        self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, 0);

        [self.dataArr addObjectsFromArray:arr];
        _index = arr.count;
        
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btnFrame.size.width, 0) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.layer.cornerRadius = 5;
        _listTable.layer.masksToBounds = YES;
        _listTable.layer.borderColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f].CGColor;
        _listTable.layer.borderWidth = 0.5f;
        _listTable.scrollEnabled = YES;
        _listTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _listTable.separatorColor = [UIColor colorWithRed:0.47f green:0.47f blue:0.47f alpha:1.00f];
        
        [button.superview addSubview:self];
        [self addSubview:_listTable];

    }
    
    return self;
}

- (void)setChangeArr:(NSArray *)changeArr{
    _changeArr = changeArr;
//    if (changeArr.count == 0) {
//        return ;
//    }
    _index = changeArr.count + 1;
    [self.dataArr removeAllObjects];
    
    if (self.isShow == YES) {
        if (_index >= 7) {
            self.frame = CGRectMake(_button.frame.origin.x, _button.frame.origin.y+_button.frame.size.height, _button.frame.size.width, CELLHeight*6);
            _listTable.frame = CGRectMake(0, 0, _button.frame.size.width, CELLHeight*6);
            //        _listTable.frame = CGRectMake(0, 0, _button.size.width, CELLHeight*_index);
        }else {
            self.frame = CGRectMake(_button.frame.origin.x, _button.frame.origin.y+_button.frame.size.height, _button.frame.size.width, CELLHeight*_index);
            _listTable.frame = CGRectMake(0, 0, _button.frame.size.width, CELLHeight*_index);
        }
    }
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (FindAllBankModel *model in changeArr) {
        NSString *string;
//        if (model.account.length > 4) {
//            string = [NSString stringWithFormat:@"%@  %@", model.bankName, [model.account substringFromIndex:model.account.length-4]];
//        }else {
//            string = [NSString stringWithFormat:@"%@  %@", model.bankName, model.account];
//        }
//        [tmpArr addObject:string];
    }
    [tmpArr addObject:@"添加新卡 >>"];
    
    [self.dataArr addObjectsFromArray:tmpArr];

    [_listTable reloadData];
}

- (void)showSelectView:(UIButton *)button{
    self.isShow = YES;
    CGRect btnFrame = button.frame;
    [UIView animateWithDuration:TimeOut animations:^{
        if (_index < 7) {
            self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, CELLHeight*_index);
            _listTable.frame = CGRectMake(0, 0, btnFrame.size.width, CELLHeight*_index);
        }else {
            self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, CELLHeight*6);
            _listTable.frame = CGRectMake(0, 0, btnFrame.size.width, CELLHeight*6);
        }

    }];

}

- (void)hiddenSelectView:(UIButton *)button{
    self.isShow = NO;
    CGRect btnFrame = button.frame;
    [UIView animateWithDuration:TimeOut animations:^{
        self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, 0);
        _listTable.frame = CGRectMake(0, 0, btnFrame.size.width, 0);
    }];
}

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELLHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    UIView *backgroudView = [[UIView alloc] init];
    backgroudView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    cell.selectedBackgroundView = backgroudView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DebugLog(@"didSelectRowAtIndexPath:%lu{%lu}", (long)indexPath.row, (unsigned long)self.dataArr.count);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if (indexPath.row == self.dataArr.count-1) {
        if ([self.delegate respondsToSelector:@selector(pullSelectViewSelectedLastItem)]) {
            [self.delegate pullSelectViewSelectedLastItem];
            return;
        }
    }
    
    if (self.block) {
        self.block(_dataArr[indexPath.row]);
    }
    
    if ([self.delegate respondsToSelector:@selector(pullSelectViewSelectedIndex:)]) {
        if (self.changeArr.count > indexPath.row) {
            [self.delegate pullSelectViewSelectedIndex:self.changeArr[indexPath.row]];
        }
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
