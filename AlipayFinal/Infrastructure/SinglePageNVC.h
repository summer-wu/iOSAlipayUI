//
//  SinglePageNVC.h
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//SinglePageNVC 是四个page的父类
@interface SinglePageNVC : UINavigationController
@property (nonatomic,retain) NSString * tabbarItemImagePath;
-(void)setTabBarImage;
@end
