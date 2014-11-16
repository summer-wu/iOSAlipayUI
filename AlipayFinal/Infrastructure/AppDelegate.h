//
//  AppDelegate.h
//  AlipayFinal
//
//  Created by wushuyu on 14-11-11.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GesturePasswordController.h"
#import "RootTabBarController.h"
#import "WidgetsVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WidegetsVCDelegate,GesturePasswordControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
//下面两个属性一个方法都是用来显示splash screen的
@property (strong,nonatomic) UIViewController * splashViewController;
-(void)splashAnimate:(NSNumber*)alpha;

-(void)showWidgetsLoginVC;
-(void)showGestureVC;
-(void)showTabbarVC;

@end
