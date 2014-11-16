//
//  WealthNVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "WealthNVC.h"

@interface WealthNVC ()

@end

@implementation WealthNVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置图片
    self.tabbarItemImagePath=@"tabbed_icon.bundle/cf财富";
    [self setTabBarImage];
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
