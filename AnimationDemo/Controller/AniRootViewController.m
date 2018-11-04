//
//  AniRootViewController.m
//  AnimationDemo
//
//  Created by yanghuan on 2018/10/31.
//  Copyright © 2018 whs. All rights reserved.
//  

#import "AniRootViewController.h"
#import "UIViewExt.h"

@interface AniRootViewController ()<CAAnimationDelegate>
{
    UIButton *leftBtn;
    UIButton *rightBtn;
}
@property(nonatomic,strong)CALayer *myLayer;
@property(nonatomic, strong)UIImageView *iconView;
@property(nonatomic,assign) int index;

@end

@implementation AniRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
    //创建layer
    CALayer *myLayer=[CALayer layer];
    //设置layer的属性
    myLayer.bounds=CGRectMake(0, 0, 150, 60);
    myLayer.backgroundColor=[UIColor yellowColor].CGColor;
    myLayer.position=CGPointMake(50, 50);
    myLayer.anchorPoint=CGPointMake(0, 0);
    myLayer.cornerRadius=40;
    //添加layer
    [self.view.layer addSublayer:myLayer];
    self.myLayer=myLayer;
    
    if (self.atIndex == 9 || self.atIndex == 10) {
        [self addSubViews];
        leftBtn.hidden = YES;
        rightBtn.hidden = YES;
    }
    
    else if (self.atIndex == 11){
        [self addViewsForLocation];
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (weakSelf.atIndex == 0) {
            [self addBasicAnimation_position];
        }else if (weakSelf.atIndex == 1){
            [self addBasicAnimation_bounds];
        }else if (weakSelf.atIndex == 2){
            [self addBasicAnimation_transform];
        }else if (weakSelf.atIndex == 3){
            [self addBasicAnimation_trKVC];
        }else if (weakSelf.atIndex == 4){
            [self addKeyframeAnimation];
        }else if (weakSelf.atIndex == 5){
            [self addKeyAniForPath];
        }else if (weakSelf.atIndex == 6){
            [self addKeyAniForShake];
        }else if (weakSelf.atIndex == 7){
            [self addSubViews];
        }else if (weakSelf.atIndex == 8){
            [self addAnimationGroup];
        }else if (weakSelf.atIndex == 9){
            [self addAnimationForUIView];
        }else if (weakSelf.atIndex == 10){
            [self addAnimationForLayer];
        }
    });
}

#pragma mark - 平移
- (void)addBasicAnimation_position{
    //CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    //要执行什么动画
    basicAnimation.keyPath = @"position";
    basicAnimation.duration = 1.0;
    //动画起始值和终止值
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_myLayer.frame.origin.x, _myLayer.frame.origin.y)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_myLayer.frame.origin.x + 80, _myLayer.frame.origin.y)];
    //NSString *str=NSStringFromCGPoint(self.myLayer.position);
    //NSLog(@"执行前：%@",str);
    //设置保存动画的最新状态
    basicAnimation.fillMode = kCAFillModeForwards;
    //设置动画执行完毕后不删除动画
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate = self;
    //添加动画
    [_myLayer addAnimation:basicAnimation forKey:nil];
}
#pragma mark - 基本动画
#pragma mark - 缩放
- (void)addBasicAnimation_bounds{
    //1.创建动画
    //CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
    CABasicAnimation *anima = [CABasicAnimation animation];
    //要执行什么动画
    anima.keyPath = @"bounds";
   
    //1.1设置动画执行时间
    anima.duration=2.0;
    //1.2设置动画执行完毕后不删除动画
    anima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //1.4修改属性，执行动画
    anima.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    //2.添加动画到layer
    [self.myLayer addAnimation:anima forKey:nil];
}
#pragma mark - 旋转
- (void)addBasicAnimation_transform{
    //1.创建动画
    //CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
    CABasicAnimation *anima = [CABasicAnimation animation];
    //要执行什么动画
    anima.keyPath = @"transform";
    
    //1.1设置动画执行时间
    anima.duration=2.0;
    //1.2设置动画执行完毕后不删除动画
    anima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //1.4修改属性，执行动画
    //anima.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_4, 1, 1, 0)];
    /*
     如果要让图形以2D的方式旋转，只需要把CATransform3DMakeRotation在z方向上的值改为1即可。
     anima.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_4, 1, 1, 0)];
     */
    //2.添加动画到layer
    [self.myLayer addAnimation:anima forKey:nil];
}
#pragma mark - kvc设置平移
- (void)addBasicAnimation_trKVC{
    //1.创建动画
    //CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
    CABasicAnimation *anima = [CABasicAnimation animation];
    //要执行什么动画
    anima.keyPath = @"transform";
    
    //1.1设置动画执行时间
    anima.duration=2.0;
    //1.2设置动画执行完毕后不删除动画
    anima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //1.4修改属性，执行动画
    anima.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 1)];
    //2.添加动画到layer
    [self.myLayer addAnimation:anima forKey:nil];
}
#pragma mark - 关键帧动画
- (void)addKeyframeAnimation{
    CAKeyframeAnimation *keyFAnimation = [CAKeyframeAnimation animation];
    //平移
    keyFAnimation.keyPath = @"position";
    //执行什么动画
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    keyFAnimation.values = @[value1, value2, value3, value4, value5];
    //1.2设置动画执行完毕后，不删除动画
    keyFAnimation.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    keyFAnimation.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyFAnimation.duration=4.0;
    //设置动画的节奏
    keyFAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.myLayer addAnimation:keyFAnimation forKey:nil];
}
#pragma mark - （使用path）让layer在指定的路径上移动（画圆）
- (void)addKeyAniForPath{
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath=@"position";
    //1.1告诉系统要执行什么动画
    //创建一条路径
    CGMutablePathRef path=CGPathCreateMutable();
    //设置一个圆的路径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    keyAnima.path=path;
    //有create就一定要有release
    CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration=5.0;
    //1.5设置动画的节奏
    keyAnima.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //2.添加核心动画
    [self.myLayer addAnimation:keyAnima forKey:nil];
}

#pragma mark - 图标抖动
#define angle2Radian(angle)  ((angle)/180.0*M_PI)
- (void)addKeyAniForShake{
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    keyAnima.keyPath=@"transform.rotation";
    //设置动画时间
    keyAnima.duration=0.1;
    //设置图标抖动弧度
    //把度数转换为弧度  度数/180*M_PI
    keyAnima.values=@[@(-angle2Radian(4)),@(angle2Radian(4)),@(-angle2Radian(4))];
    //设置动画的重复次数(设置为最大值)
    keyAnima.repeatCount= 10;
    
    keyAnima.fillMode=kCAFillModeForwards;
    keyAnima.removedOnCompletion=NO;
    //2.添加动画
    [self.myLayer addAnimation:keyAnima forKey:nil];
}

#pragma mark - 转场动画
- (void)addSubViews{
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake((MAINSCREENWIDTH - 150)/2, 150, 150, 200)];
    _iconView.image = [UIImage imageNamed:@"pic01.png"];
    _iconView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _iconView.layer.position = CGPointMake(_iconView.left + _iconView.width / 2, _iconView.height + _iconView.height / 2);
    
    [self.view addSubview:_iconView];
    
    self.index = 1;
    
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake((MAINSCREENWIDTH - 240)/2, _iconView.bottom + 30, 100, 40);
    [leftBtn setBackgroundColor:[UIColor cyanColor]];
    [leftBtn setTitle:@"上一张" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(preOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(leftBtn.right + 40, _iconView.bottom + 30, 100, 40);
    [rightBtn setBackgroundColor:[UIColor cyanColor]];
    [rightBtn setTitle:@"下一张" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(nextOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
}

- (void)preOnClick:(UIButton *)btn{
    self.index--;
    if (self.index < 1) {
        self.index = 3;
    }
    self.iconView.image=[UIImage imageNamed: [NSString stringWithFormat:@"pic0%d.png",self.index]];
    
    //创建核心动画
    CATransition *ca=[CATransition animation];
    //告诉要执行什么动画
    //设置过度效果
    ca.type=@"cube";
    //设置动画的过度方向（向左）
    ca.subtype=kCATransitionFromLeft;
    //设置动画的时间
    ca.duration=2.0;
    //添加动画
    [self.iconView.layer addAnimation:ca forKey:nil];
}
- (void)nextOnClick:(UIButton *)btn{
    self.index++;
    if (self.index > 3) {
        self.index= 1;
    }
    self.iconView.image=[UIImage imageNamed: [NSString stringWithFormat:@"pic0%d.png",self.index]];
    
    //1.创建核心动画
    CATransition *ca=[CATransition animation];
    
    //1.1告诉要执行什么动画
    //1.2设置过度效果
    ca.type=@"cube";
    //1.3设置动画的过度方向（向右）
    ca.subtype=kCATransitionFromRight;
    //1.4设置动画的时间
    ca.duration=2.0;
    //1.5设置动画的起点
    ca.startProgress=0.5;
    //1.6设置动画的终点
    //ca.endProgress=0.5;
    
    //2.添加动画
    [self.iconView.layer addAnimation:ca forKey:nil];
}

#pragma mark - 组动画
- (void)addAnimationGroup{
    // 平移动画
    CABasicAnimation *a1 = [CABasicAnimation animation];
    a1.keyPath = @"transform.translation.y";
    a1.toValue = @(100);
    // 缩放动画
    CABasicAnimation *a2 = [CABasicAnimation animation];
    a2.keyPath = @"transform.scale";
    a2.toValue = @(0.0);
    // 旋转动画
    CABasicAnimation *a3 = [CABasicAnimation animation];
    a3.keyPath = @"transform.rotation";
    a3.toValue = @(M_PI_2);
    // 组动画
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[a1, a2, a3];
    //设置组动画的时间
    groupAnima.duration = 2;
    groupAnima.repeatCount = 2;
    groupAnima.fillMode = kCAFillModeForwards;
    groupAnima.removedOnCompletion = NO;
    [self.myLayer addAnimation:groupAnima forKey:nil];
}
#pragma mark - UIView封装动画
- (void)addAnimationForUIView{
    //打印动画块的位置
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.iconView.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:2.0];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    self.iconView.center=CGPointMake(200, 300);
    [UIView commitAnimations];
}
-(void)didStopAnimation
{
    NSLog(@"动画执行完毕");
    //打印动画块的位置
    NSLog(@"动画执行之后的位置：%@",NSStringFromCGPoint(self.iconView.center));
}

#pragma mark - UIView封装的动画与CALayer动画的对比
- (void)addAnimationForLayer{
    //1.创建核心动画
    CABasicAnimation *anima=[CABasicAnimation animation];
    //平移
    anima.keyPath=@"position";
    //设置执行的动画
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(_iconView.left, 300)];
    //设置执行动画的时间
    anima.duration=2.0;
    //设置动画执行完毕之后不删除动画
    anima.removedOnCompletion=NO;
    //设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //anima.fillMode=kCAFillModeBackwards;
    //设置动画的代理
    anima.delegate=self;
    //2.添加核心动画
    [self.iconView.layer addAnimation:anima forKey:nil];
}

#pragma mark - position与anchorPoint
- (void)addViewsForLocation{
    /*
     position是layer中的anchorPoint点在superLayer中的位置坐标.
     position点是相对superLayer的.
     */
    UILabel *locaLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 250, 70)];
    locaLabel.text = @"position与anchorPoint";
    locaLabel.textAlignment = NSTextAlignmentCenter;
    locaLabel.backgroundColor = [UIColor cyanColor];
    locaLabel.textColor = [UIColor blueColor];
    locaLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
    locaLabel.layer.position = CGPointMake(0, 100);
    [self.view addSubview:locaLabel];
    
    
    
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    if (self.atIndex == 10) {
        //打印动画块的位置
        NSLog(@"动画开始执行前的位置Layer：%@",NSStringFromCGPoint( self.iconView.layer.position));
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (self.atIndex == 10) {
        //打印动画块的位置
        NSLog(@"动画开始执行前的位置Layer：%@",NSStringFromCGPoint( self.iconView.layer.position));
    }
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
