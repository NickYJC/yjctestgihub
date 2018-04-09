//
//  Quartz2D1BasicViewController.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D1BasicViewController.h"
#import "Quartz2D1View.h"
#import "Quartz2D2View.h"
#import "Quartz2D3View.h"
#import "Quartz2D4View.h"
#import "Quartz2D5View.h"

#import "Quartz2D6View.h"
#import "Quartz2D7View.h"
#import "Quartz2D8View.h"
#import "Quartz2D9View.h"
#import "Quartz2D10View.h"

#import "Quartz2D11View.h"
@interface Quartz2D1BasicViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)  Quartz2D1View * QZ1View;
@property (nonatomic, strong)  Quartz2D2View * QZ2View;
@property (nonatomic, strong)  Quartz2D3View * QZ3View;
@property (nonatomic, strong)  Quartz2D4View * QZ4View;
@property (nonatomic, strong)  Quartz2D5View * QZ5View;

@property (nonatomic, strong)  Quartz2D6View * QZ6View;
@property (nonatomic, strong)  Quartz2D7View * QZ7View;
@property (nonatomic, strong)  Quartz2D8View * QZ8View;
@property (nonatomic, strong)  Quartz2D9View * QZ9View;
@property (nonatomic, strong)  Quartz2D10View * QZ10View;

@property (nonatomic, strong)  Quartz2D11View * QZ11View;

@property (nonatomic, strong)UIScrollView *baseScrollView;
/** <#注释#> */
@property (nonatomic, weak) CAGradientLayer *gradientL;

//起始点
@property(nonatomic,assign) CGPoint startP;

@end

@implementation Quartz2D1BasicViewController


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    CGFloat height =(kScreenHeight-64-49-30);
//    [_baseScrollView scrollRectToVisible:CGRectMake(0, -64, kScreenWidth, height+30) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGRect screenSize = [UIScreen mainScreen].bounds;
//    if (screenSize.size.height == 812) {
//        return;
//    }
//    CGFloat height =(kScreenHeight-64-49-30);
//    [_baseScrollView scrollRectToVisible:CGRectMake(0, -64, kScreenWidth, height+30) animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewController = self;
    [self createLeftUI];
    self.view.backgroundColor =[UIColor whiteColor];
    
    //1画线
    _QZ1View =[[Quartz2D1View alloc]initWithFrame:CGRectMake(0, 70, KScreenW,200)];
    _QZ1View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ1View];
    //2 画扇形
    _QZ2View =[[Quartz2D2View alloc]initWithFrame:CGRectMake(0, 280, KScreenW,200)];
    _QZ2View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ2View];
    //3画矩形
    _QZ3View =[[Quartz2D3View alloc]initWithFrame:CGRectMake(0, 490, KScreenW,200)];
    _QZ3View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ3View];
    
    //4画矩形
    _QZ4View =[[Quartz2D4View alloc]initWithFrame:CGRectMake(0, 700, KScreenW,200)];
    _QZ4View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ4View];
    
    
    //5画矩形
    _QZ5View =[[Quartz2D5View alloc]initWithFrame:CGRectMake(0, 910, KScreenW,200)];
    _QZ5View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ5View];
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((KScreenW - 150) / 2, 1130, 150, 20)];
//    slider.minimumValue = 9;// 设置最小值
//    slider.maximumValue = 11;// 设置最大值
//    slider.value = (slider.minimumValue + slider.maximumValue) / 2;// 设置初始值
    slider.continuous = YES;// 设置可连续变化
    //    slider.minimumTrackTintColor = [UIColor greenColor]; //滑轮左边颜色，如果设置了左边的图片就不会显示
    //    slider.maximumTrackTintColor = [UIColor redColor]; //滑轮右边颜色，如果设置了右边的图片就不会显示
    //    slider.thumbTintColor = [UIColor redColor];//设置了滑轮的颜色，如果设置了滑轮的样式图片就不会显示
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [_baseScrollView addSubview:slider];
   
    
    
    //6//画三个扇形
    _QZ6View =[[Quartz2D6View alloc]initWithFrame:CGRectMake(0, 1160, KScreenW,200)];
    _QZ6View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ6View];
    
    //7//要绘制的文字 可以使用UIKit提供的方法
    _QZ7View =[[Quartz2D7View alloc]initWithFrame:CGRectMake(0, 1370, KScreenW,60)];
    _QZ7View.backgroundColor =[UIColor redColor];
    [_baseScrollView addSubview:_QZ7View];
    
    //8图片重新赋值,都做一次重绘. 局部截屏
    _QZ8View =[[Quartz2D8View alloc]initWithFrame:CGRectMake(0, 1440, KScreenW,200)];
//    _QZ8View  = [[Quartz2D8View alloc] initWithImage:[UIImage imageNamed:@"CTO"]];
    _QZ8View.image = [UIImage imageNamed:@"CTO"];
     [_baseScrollView addSubview:_QZ8View];
    
   
   // _QZ8View.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    // self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    //_QZ8View.layer.anchorPoint = CGPointMake(0.5, 0);
    //渐变层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = _QZ8View.bounds;
    //设置渐变的颜色
    gradientL.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor whiteColor].CGColor];
    //设置渐变透明
    gradientL.opacity = 0;
    self.gradientL = gradientL;
    [_QZ8View.layer addSublayer:gradientL];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    
    [_QZ8View addGestureRecognizer:panRecognizer];
    
 
    
    
    
    //9绘制雪花
    _QZ9View =[[Quartz2D9View alloc]initWithFrame:CGRectMake(0, 1650, KScreenW,200)];
    _QZ9View.backgroundColor =[UIColor blackColor];
    [_baseScrollView addSubview:_QZ9View];
    
    //10图形上下文栈
    _QZ10View =[[Quartz2D10View alloc]initWithFrame:CGRectMake(0, 1860, KScreenW,200)];
    _QZ10View.backgroundColor =[UIColor lightGrayColor];
    [_baseScrollView addSubview:_QZ10View];
    
    
    //yjc11获取当前的上下文. 形变操作
    _QZ11View =[[Quartz2D11View alloc]initWithFrame:CGRectMake(0, 2070, KScreenW,200)];
    _QZ11View.backgroundColor =[UIColor lightGrayColor];
    [_baseScrollView addSubview:_QZ11View];
    
    
      //********yjc12添加水印的图片
    UIImageView *QZImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 2280, KScreenW,200)];
    QZImageView.backgroundColor =[UIColor lightGrayColor];
    [_baseScrollView addSubview:QZImageView];
    //加载要添加水印的图片
    UIImage *image = [UIImage imageNamed:@"汽水"];
    
    //创建一个位图上下文.
    //size:要开启一个多大的图片上下文.
    //opaque:不透明度,当为YES为不透明, 为NO的时候透明,
    //scale:是否需要缩放.
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
    
    //把要添加水印的图片绘制到上下文当中.
    //    [image drawAtPoint:CGPointZero];
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1];
    
    //绘制水印
    NSString *str = @"YJC杨竟彩";
    [str drawAtPoint:CGPointMake(20, 400) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:50],
                                                           NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:0.3]
                                                           }];
    
    
    
    //从上下文当中生成一张新图片.
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文.
    UIGraphicsEndImageContext();
    
    QZImageView.image = newImage;
    
    
    //********yjc13裁剪的图片
    UIImageView *QZ13ImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 2490, KScreenW,200)];
    QZ13ImageView.backgroundColor =[UIColor lightGrayColor];
    [_baseScrollView addSubview:QZ13ImageView];
    //加载要裁剪的图片
    UIImage *image13 = [UIImage imageNamed:@"汽水"];
    
    //1.创建一个和原始图片一样大小的位图上下文.
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.设置一个圆形的裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(image13.size.width/2-40, image13.size.height/2-40, 80, 80)];
    //image13.size.height
    //把路径设置成裁剪区域
    [path addClip];
    //3.把原始图片绘制上下文当中.
    [image drawAtPoint:CGPointZero];
    //4.从上下文当中生成一张新的图片.
    UIImage *newImage13 = UIGraphicsGetImageFromCurrentImageContext();
    
    //5.关闭上下文.
    UIGraphicsEndImageContext();
    
    QZ13ImageView.image = newImage13;
}
- (void)sliderValueChanged:(UISlider *)sender {
    
    
    NSLog(@"%f",sender.value);
    
    //注意:%在stringWithFormat当中有特殊含义,不能够直接使用,用两个%%代表一个%
   // self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%",sender.value * 100];
    
    _QZ5View.progress = sender.value;
    
    
}
- (void)createLeftUI
{
    CGFloat height =(kScreenHeight*8);
    
    
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenH)];
    _baseScrollView.backgroundColor = [UIColor backgroundColor];
    _baseScrollView.scrollEnabled = YES;
    _baseScrollView.bounces = YES;
    _baseScrollView.delegate = self;
    _baseScrollView.showsVerticalScrollIndicator = NO;
    _baseScrollView.contentSize = CGSizeMake(kScreenWidth,height+30);
    [self.view addSubview:_baseScrollView];
    
    UIView *topLeftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 60)];
    topLeftView.backgroundColor =[UIColor darkGrayColor];
    [_baseScrollView addSubview:topLeftView];
    NSArray *arr =@[@"截屏",@"AAAA",@"BTC",@"ETC",@"返回"];
    for (int i =0; i<arr.count; i++) {
        UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(KScreenW/5*i, 35,KScreenW/5, 25)];
        leftButton.titleLabel.font =[UIFont systemFontOfSize:11];
        [leftButton setTitle:arr[i] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        leftButton.tag = 200+i;
        [topLeftView addSubview:leftButton];
    }
    
    
}
#pragma mark-渐变层
//渐变层
- (void)gradientLayer {
    
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = _QZ8View.bounds;
    //设置渐变的颜色
    gradientL.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor];
    //设置渐变的方向
    gradientL.startPoint = CGPointMake(0, 0);
    gradientL.endPoint = CGPointMake(1, 0);
    
    //设置一个渐变到另一个渐变的起始位置
    gradientL.locations = @[@0.1,@0.9];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    //获取移动的偏移量
    CGPoint transP = [recognizer translationInView:recognizer.view];
    //让上部图片开始旋转
    CGFloat angle = transP.y * M_PI / 200;
    
    //近大远小
    CATransform3D transform = CATransform3DIdentity;
    //眼睛离屏幕的距离
    transform.m34 = -1 / 300.0;
    
    self.gradientL.opacity = transP.y * 1 / 200.0;
    
    
    //self.topImageV.layer.transform  = CATransform3DMakeRotation(-angle, 1, 0, 0);
    //self.topImageV.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0 );
    
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        self.gradientL.opacity = NO;
        //上部的图片复位
        //usingSpringWithDamping:弹性系数.越小弹性越大
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options: UIViewAnimationOptionCurveLinear  animations:^{
            
            //self.topImageV.layer.transform = CATransform3DIdentity;
            
        } completion:nil];
    }
    
}

- (void)leftBtnClick:(UIButton*)button
{
    
    switch (button.tag-200) {
        case 0:
        {//截屏
            //开启一个跟控制器view相同大小的上下文.
            UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
            
            
            //把View的内容绘制到上下文当中.
            //注意:View是不能够直接绘制到上下文当中的.View之所以能够显示是因为它内部有一个layer(层),
            //层是通过渲染的方式绘制到上下文当中的.
            
            //获取当前的上下文.
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [self.view.layer renderInContext:ctx];
            
            
            //从上下文当中生成一张图片
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            //关闭上下文.
            UIGraphicsEndImageContext();
            
            
            //把生成的图片写到桌面上.
            //桌面都是以流的形式传递数据,所以我们要把图片转成二进流.
            //image:要转的图片
            //compressionQuality:压缩质量,1代表质量最高
            NSData *data = UIImageJPEGRepresentation(newImage, 1);
            [data writeToFile:@"/Users/yangjingcai/Desktop/clipImage.jpg" atomically:YES];
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
             [self.navigationController popViewControllerAnimated:NO];
        }
            break;
        case 4:
        {
            [self.navigationController popViewControllerAnimated:NO];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
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
