//
//  ViewController.m
//  RunTimeDemo
//
//  Created by yanghuan on 2018/10/25.
//  Copyright © 2018 whs. All rights reserved.
//

#import "ViewController.h"
#import "AniRootViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *dataArrs;
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataArrs = @[@"基本动画平移-CABasicAnimation_position",
                  @"基本动画缩放-CABasicAnimation_bounds",
                  @"基本动画旋转-CABasicAnimation_transform",
                  @"基本动画平移-通过transform（KVC）设置",
                  @"关键帧动画-CAKeyframeAnimation",
                  @"关键帧动画-用path让layer在指定路径移动",
                  @"关键帧动画-图标抖动",
                  @"转场动画",
                  @"组动画",
                  @"UIView封装动画",
                  @"UIView封装的动画与CALayer动画的对比",
                  @"position与anchorPoint"];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArrs[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AniRootViewController *aniVC = [[AniRootViewController alloc]init];
    aniVC.atIndex = indexPath.row;
    [self.navigationController pushViewController:aniVC animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

