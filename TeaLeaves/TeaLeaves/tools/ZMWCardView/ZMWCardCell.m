//
//  ZMWCardCell.m
//  ZMWCardDemo
//
//  Created by 张美文 on 16/9/21.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWCardCell.h"
#import "GoingToStartModel.h"

@interface ZMWCardCell()
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *hourLab;
@property (weak, nonatomic) IBOutlet UILabel *miniteLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;

@property (weak, nonatomic) IBOutlet UILabel *teaName;
@property (weak, nonatomic) IBOutlet UITextView *introduceTextView;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;

@end

@implementation ZMWCardCell
{
    dispatch_source_t timer;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    NSString * string = @"32400000";
//    NSString * string = @"172800000";
    
//    [self countDown:[string intValue]/1000];
    

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //
    }
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(GoingToStartModel *)model {
    _model = model;
    [self countDown:[model.remaining intValue]/1000];
    
    self.teaName.text = [NSString stringWithFormat:@"%@  %@", self.model.productNo, self.model.name];
    if (self.model.productIntroduce.length) {
        self.introduceTextView.text = self.model.productIntroduce;
    }
    
    self.priceLab.text = [NSString stringWithFormat:@"￥%.2f/%@", [self.model.initialPrice floatValue],self.model.unit];
    
    DebugLog(@"self.modelfdsgfas.cover=%@",self.model.cover)
    [self.contentImgView sd_setImageWithURL:[NSURL URLWithString:self.model.background] placeholderImage:[UIImage imageNamed:@"pre_new_backImg"]];

}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    dispatch_cancel(timer);
    
}

- (IBAction)buttonAction:(id)sender {
    if (self.block) {
        self.block();
    }
}

- (void)countDown:(int)timeDown{
    __block int timeout=timeDown; //倒计时时间
    ZMWWeakSelf(self)
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //完成之后调用
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    DebugLog(@"-------------------");
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZMWPreSellViewControllerNotice object:nil];
                });
                
                if (weakself.block) {
                    weakself.block();
                }


            });
        }else{
            int seconds = timeout % (timeDown+1);
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *tmpArray = [strTime walter_timeformatFromSeconds:[strTime integerValue]];
//                DebugLog(@"sdljfwlefjwl");
//                DebugLog(@"lksdjflk:%@", tmpArray);
                self.secondLab.text = tmpArray[3];
                self.miniteLab.text = tmpArray[2];
                self.hourLab.text = tmpArray[1];
                self.dayLab.text = [NSString stringWithFormat:@"%@天", tmpArray[0]];
            });
            weakself.model.remaining = [NSString stringWithFormat:@"%d", timeout*1000];
            timeout--;
            
        }
    });
    timer = _timer;

    dispatch_resume(_timer);
}

@end
