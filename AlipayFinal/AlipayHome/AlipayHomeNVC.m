//
//  AlipayHomeNVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "AlipayHomeNVC.h"

@interface AlipayHomeNVC ()

@end

@implementation AlipayHomeNVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置图片
    self.tabbarItemImagePath=@"tabbed_icon.bundle/zfb支付宝";
    [self setTabBarImage];
    self.tabBarController.view.backgroundColor=[UIColor whiteColor];
    
//    CGRect frame = CGRectMake(0, 0, 320, 49);
//    UIView *v = [[UIView alloc] initWithFrame:frame];
//    UIImage *img = [UIImage imageNamed:@"tabbar.png"];
//    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
//    v.backgroundColor = color;
//    [tabBarController.tabBar insertSubview:v atIndex:0];
//    tabBarController.tabBar.opaque = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
