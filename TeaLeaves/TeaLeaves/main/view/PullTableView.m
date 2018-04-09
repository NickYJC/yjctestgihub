//
//  PullTableView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/26.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "PullTableView.h"

#define PULLCELLHEIGHT 44
#define PULLORIGIN     0

@interface PullTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, assign) CGRect endFrame;

@end

@implementation PullTableView
{
    UIImageView *menuImageView;
    
    int _tmpStatus;
    BOOL _isStatus;
    NSMutableDictionary *_tmpStatusDic;
    NSMutableArray      *_tmpStatusArr;
    
}


- (instancetype)initWithPullFrame:(CGRect)frame didSelectedBlock:(PullTableViewBlock)block{
    if (self = [super initWithFrame:CGRectMake(0, 60, KScreenW, KScreenH-60)]) {
        self.userInteractionEnabled = YES;
        
        self.backgroundColor                 = [UIColor colorWithWhite:0 alpha:0];
//                self.backgroundColor                 = [UIColor lightGrayColor];
        self.block                           = block;
        _tmpStatus                           = 0;
        _isStatus                            = NO;
        _tmpStatusDic                        = [NSMutableDictionary dictionary];
        _tmpStatusArr                        = [NSMutableArray array];
        menuImageView                        = [[UIImageView alloc] initWithFrame:frame];
        menuImageView.layer.cornerRadius     = 2;
        menuImageView.layer.masksToBounds    = YES;
        menuImageView.layer.borderWidth      = 0.5;
        menuImageView.layer.borderColor      = [UIColor lightGrayColor].CGColor;
        menuImageView.userInteractionEnabled = YES;
        menuImageView.layer.anchorPoint      = CGPointMake(0.3, 0);
        menuImageView.frame                  = CGRectMake(frame.origin.x, PULLORIGIN, frame.size.width, 0);
        menuImageView.backgroundColor        = [UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f];
        [self addSubview:menuImageView];
        
        _pullTableView = [[UITableView alloc] initWithFrame:menuImageView.bounds style:UITableViewStylePlain];
        _pullTableView.backgroundColor = [UIColor magentaColor];
        _pullTableView.delegate = self;
        _pullTableView.dataSource = self;
        [menuImageView addSubview:_pullTableView];
        
//        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//        [self addGestureRecognizer:tapGesgure];
        
    }
    
    return self;

}

- (void)setPullDataArray:(NSMutableArray *)pullDataArray{
    _pullDataArray = pullDataArray;
    _tmpStatus++;
    CGRect frame = menuImageView.frame;
    
    menuImageView.frame = CGRectMake(frame.origin.x, PULLORIGIN, frame.size.width, PULLCELLHEIGHT*pullDataArray.count);
    _pullTableView.frame = menuImageView.bounds;
    
    [_tmpStatusDic setValue:menuImageView forKey:[NSString stringWithFormat:@"%d", _tmpStatus]];
    [_tmpStatusArr addObject:_tmpStatusDic];
    
    [self.pullTableView reloadData];
    [self show];
}

- (void)show {
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    __weak UIImageView *weakImageView = menuImageView;
    [_pullTableView setMinimumZoomScale:0];
    if (_tmpStatusArr.count < 2 || _isStatus == YES) {
        menuImageView.transform           = CGAffineTransformMakeScale(1.0f, 0.f);
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            weakImageView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];

    }else {
        UIImageView *tmpImg1 = [_tmpStatusArr[_tmpStatusArr.count-2] objectForKey:[NSString stringWithFormat:@"%d", _tmpStatus-1]];
        UIImageView *tmpImg2 = [_tmpStatusArr[_tmpStatusArr.count-1] objectForKey:[NSString stringWithFormat:@"%d", _tmpStatus]];
        weakImageView.frame = tmpImg1.frame;
        [UIView animateWithDuration:1.5 animations:^{
            weakImageView.frame = tmpImg2.frame;

        }];

    }
    
//    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        weakImageView.transform = CGAffineTransformIdentity;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
}

- (void)dismiss {
    
    __weak __typeof(self)weakSelf     = self;
    __weak UIImageView *weakImageView = menuImageView;
    [UIView animateWithDuration:.15 animations:^{
        
        weakImageView.transform = CGAffineTransformMakeScale(1.0f, 0.f);
        [weakSelf removeFromSuperview];

        
    } completion:^(BOOL finished) {
        [_pullTableView setMinimumZoomScale:0];
    }];
    
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pullDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%lu行", (long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.block) {
//        self.block(self.pullDataArray[indexPath.row]);
        self.block(cell.textLabel.text);
    }
    
    [self dismiss];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    _isStatus = YES;
    if (![touch.view isEqual:_pullTableView]) {
        [self dismiss];
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
