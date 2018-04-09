//
//  VerticalLineScrollView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/18.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "VerticalLineScrollView.h"
#import "VerticalLineView.h"

@interface VerticalLineScrollView()
@property (nonatomic, strong) VerticalLineView  *verticalView;
@property(nonatomic,strong)NSMutableArray       *dataArr;
@property (nonatomic, strong) dispatch_source_t articleTimer;

@end

@implementation VerticalLineScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        [self requestGetNewArticle];
    }
    
    return self;
}

//- (void)awakeFromNib{
//    [super awakeFromNib];
//}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - request
static int articleCount;
- (void)requestGetNewArticle{
    
    NSMutableDictionary *parm1 = [NSMutableDictionary dictionary];
    [parm1 setValue:@"30" forKey:@"rows"];
    [parm1 setValue:@"1" forKey:@"page"];
    [AFNetworkingTool getJSONWithUrl:@"getNewArticle" parameters:parm1 success:^(id json) {
        //
//        NSDictionary *resultDic = (NSDictionary *)json;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        DebugLog(@"getSubAccount>>resultDic: %@", resultDic);
        
        if ([[resultDic objectForKey:@"code"] isEqualToString:@"000000"]) {
//            if (![[resultDic objectForKey:@"data"] count]) {
//                return ;
//            }
            
            if (![[resultDic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                return ;
            }
           
            NSDictionary *dicTemp =[resultDic objectForKey:@"data"];
            
            
            if (![[dicTemp objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                return ;
            }
            
            if (self.articleTimer) {
                dispatch_cancel(self.articleTimer);
            }
             NSArray *array =@[@"中国工程院院士 袁隆平",@"国内首次大范围试种海水稻 袁隆平：达1亿亩可养8000万人",@"我国有约15亿亩盐碱地分布在大江南北，气候带、光照条件都不尽相同。",@"今年将首次在全国五个主要类型的盐碱地上同时进行千亩片的试验示范，就是为了在不同的地质条件下，检验这176份海水稻材料的最终产量和品质。",@"目前我国“海水稻”品种还处在研发培育阶段，在正式推广应用前仍需科研与观察。"];
            int i =0;
            for (NSDictionary *dic in [dicTemp objectForKey:@"list"]) {
                ZMWGetNewArticle *model =[ZMWGetNewArticle mj_objectWithKeyValues:dic];
                model.title =array[i];
                [self.dataArr addObject:model];
                i++;
                if(i>4)i=0;
            }
            
            [self createTopLineView];
            
        }

    } fail:^(NSError *error){
        //
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)),5.0*NSEC_PER_SEC, 0);
        self.articleTimer = _timer;
        
        dispatch_source_set_event_handler(_timer, ^{
            if (articleCount < 100) {
                [self requestGetNewArticle];
            }else {
                dispatch_cancel(self.articleTimer);
            }
            articleCount++;
        });
        dispatch_resume(_timer);

    }];

}

#pragma mark - 垂直滚动条

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(void)createTopLineView{
   
    
    _verticalView = [[VerticalLineView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bounds.size.height)];
    _verticalView.backgroundColor = [UIColor backgroundColor];
    __weak __typeof(self)weakSelf = self;
    _verticalView.clickBlock = ^(NSInteger index){
//        NSLog(@"点击广告条：%@",weakSelf.dataArr[index]);
        if (weakSelf.block) {
            weakSelf.block(weakSelf.dataArr[index]);
            
        }
    };
    [self addSubview:_verticalView];
    
    //添加数据源
//    NSArray *arr2 = @[@"品众商城",@"品众商城",@"品众商城",@"品众商城",@"品众商城"];
//    for (int i=0; i<arr2.count; i++) {
//        
//        [self.dataArr addObject:arr2[i]];
//    }
    [_verticalView setVerticalShowDataArr:_dataArr];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
