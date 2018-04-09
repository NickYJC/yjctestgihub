//
//  SearchBarView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/26.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "SearchBarView.h"

#define CELLHeight 40
#define TimeOut 5

@implementation PullDataView

- (instancetype)showSelectView:(UIView *)searchView elementArray:(NSArray *)arr onClickButtonAction:(PullSelectViewBlock)block{
    _searchView = searchView;
    self.block = block;
    self.isShow = NO;
    if (self == [super init]) {
        CGRect searchFrame = searchView.frame;
        self.frame = CGRectMake(searchFrame.origin.x, searchFrame.origin.y+searchFrame.size.height, searchFrame.size.width, 200);
        
        [self.dataArr addObjectsFromArray:arr];
        _index = arr.count;
        
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, searchFrame.size.width, 200)];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.layer.cornerRadius = 5;
        _listTable.scrollEnabled = NO;
        _listTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _listTable.separatorColor = [UIColor grayColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [searchView.superview.window addSubview:self];
        [self addSubview:_listTable];
        
    }
    
    return self;
}

- (void)showSelectView:(UIView *)view{
    CGRect searchFrame = view.frame;
    [UIView animateWithDuration:TimeOut animations:^{
        self.frame = CGRectMake(searchFrame.origin.x, searchFrame.origin.y+searchFrame.size.height, searchFrame.size.width, CELLHeight*_index);
        _listTable.frame = CGRectMake(0, 0, searchFrame.size.width, CELLHeight*_index);
    }];
    
}

- (void)hiddenSelectView:(UIView *)view{
    CGRect searchFrame = view.frame;
    [UIView animateWithDuration:TimeOut animations:^{
        self.frame = CGRectMake(searchFrame.origin.x, searchFrame.origin.y+searchFrame.size.height, searchFrame.size.width, 0);
        _listTable.frame = CGRectMake(0, 0, searchFrame.size.width, 0);
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
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    UIView *backgroudView = [[UIView alloc] init];
    backgroudView.backgroundColor = [UIColor cyanColor];
    cell.selectedBackgroundView = backgroudView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(_dataArr[indexPath.row]);
    }
}

//

@end



@interface SearchBarView()
@property (nonatomic, retain) PullDataView *pullDataView;

@end

@implementation SearchBarView

- (instancetype)initWithFrame:(CGRect)frame fetchCompletionHandlerTextFieldChanged:(SearchBarViewBlock)block fetchCompletionHandlerSearchButtonAction:(SearchBarViewSearchBlock)searchBlock{
    
    if (self = [super initWithFrame:frame]) {
        //
        self.block = block;
        self.searchBlock = searchBlock;
        self.layer.cornerRadius = frame.size.height*0.5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        [self createSubViews];
    }
    
    return self;

}

- (void)createSubViews{
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _textfield.borderStyle = UITextBorderStyleNone;
    _textfield.textColor = [UIColor whiteColor];
//    _textfield.backgroundColor = [UIColor yellowColor];
    _textfield.placeholder = @"请输入名字或编码";
    [_textfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textfield setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textfield.font = [UIFont systemFontOfSize:14];
    [_textfield addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textfield];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 20);
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"搜索图标"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    _textfield.leftView = button;
    _textfield.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)searchAction:(UIButton *)button{
    if (self.searchBlock) {
        self.searchBlock();
    }
}

- (void)textFieldDidChanged:(UITextField *)textField{
    if (self.block) {
        self.block();
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
