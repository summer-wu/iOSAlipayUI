//
//  ServicesNVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "ServicesNVC.h"

@interface ServicesNVC ()

@end

@implementation ServicesNVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置图片
    if (!self.tabbarItemImagePath) { //如果没有设置过图片则设置
        self.tabbarItemImagePath=@"tabbed_icon.bundle/fw服务窗";
        [self setTabBarImage];
    }else{
        return; 
    }


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
