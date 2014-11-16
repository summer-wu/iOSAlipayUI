//
//  AppDelegate.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-11.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //共有三个可选的rootVC loginVC、gestureVC、tabbarVC
    /*先判断是否已登陆.
     Q1:nsuserdefaults是否已登录？
        Q1true:显示gestureVC。设置完手势密码。显示tabbarVC
        Q1false：显示loginVC。loginVC输入正确了，再显示gestureVC。再显示tabbarVC
     */
    BOOL isLogined=[[NSUserDefaults standardUserDefaults] boolForKey:@"key_isLogined"];
    if (isLogined) {
        [self showGestureVC];
     }else{
        //WidgetsVC是一个库，可以创建很多不同的view，这里指使用
         [self showWidgetsLoginVC];
    }
   
    //刚进入的时候还没有view呢！
    [self.window addSubview:self.window.rootViewController.view];
    //设置splashVC，显示splashVC.view。不使用其他splashVC的功能
    self.splashViewController=[[UIViewController alloc]init];
    NSString * splashImageName=@"splash.jpg";
    if(self.window.bounds.size.height>480){
        splashImageName=@"splashR4.jpg";
    }
    self.splashViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:splashImageName]];
    //把splashVC添加进去
    [self.window addSubview:self.splashViewController.view];
    //⬇️ 让splashimage显示2s，让用户看一眼得了。
    [self performSelector:@selector(splashAnimate:) withObject:@0.0 afterDelay:2.0];
    return YES; 
}


-(void) splashAnimate:(NSNumber *)alpha{
    // ⬇️ 只能用UIViewAnimationOptionCurveEaseInOut和ViewAnimationOptionTransitionNone两种效果
    UIView * splashView=self.splashViewController.view;
    [UIView animateWithDuration:1.0 animations:^{
        splashView.transform=CGAffineTransformScale(splashView.transform, 1.5, 1.5);
        splashView.alpha=alpha.floatValue;
    } completion:^(BOOL finished) {
        //ARC通过赋值nil释放内存，动画中不能removeFromSuperview.
        [splashView removeFromSuperview];
        self.splashViewController=nil;
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 三个showVC方法
-(void)showWidgetsLoginVC{
    WidgetsVC * widgetVC=[[WidgetsVC alloc]initWithNibName:@"Widgets" bundle:[NSBundle mainBundle]];
    widgetVC.delegate=self;
    widgetVC.whichViewToPresent=@"loginView";
    self.window.rootViewController=widgetVC;
}
-(void)showGestureVC{
    GesturePasswordController * passwordC=[[GesturePasswordController alloc]init];
    passwordC.delegate=self;
    self.window.rootViewController=passwordC;
}
-(void)showTabbarVC{
    UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RootTabBarController * tabVC=[mainsb instantiateInitialViewController];
    self.window.rootViewController=tabVC;
}

#pragma mark WidegetsVCDelegate
-(void)WidgetsVC:(WidgetsVC *)widgetsVC loginOK:(id)nilplaceholder{
    [self showGestureVC];
}

#pragma mark GesturePasswordControllerDelegate
//验证完手势密码进入tabbarVC
-(void)GesturePasswordController:(GesturePasswordController *)passController verifyOK:(id)nilplaceholder{
    [self showTabbarVC];
}
//设置完手势密码进入tabbarVC
-(void)GesturePasswordController:(GesturePasswordController *)passController resetOK:(id)nilplaceholder{
    [self showTabbarVC];
}


@end
