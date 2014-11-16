//
//  TentacleView.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol ResetDelegate <NSObject>
- (BOOL)resetPassword:(NSString *)result;
@end

@protocol VerificationDelegate <NSObject>
- (BOOL)verification:(NSString *)result;
@end

@protocol TouchBeginDelegate <NSObject>
- (void)gestureTouchBegin;
@end

/*
 TentacleView:UIView，用来显示触手，刚创建时什么都不显示。并且触手不知道对不对，需要代理人告诉自己对不对。
 
 有5个属性，1个方法
 buttonArray，用于存储button
 verificationDelegate，这个委托人 验证触手是否正确，委托人具有verification方法。作者是GPC实现了此协议
 resetDelegate，这个委托人有resetPassword方法。作者是让GPC实现了此协议
 touchBeginDelegate，手势开始，委托人有gestureTouchBegin方法。作者是让GesturePasswordView实现了此协议
 style，样式。passwordcontroller有两种状态，一种是reset状态（没有两个按钮）、一种是verify状态（有按钮）。
 
 方法enterArgin，再次输入一次触手。
 
 */

@interface TentacleView : UIView

@property (nonatomic,strong) NSArray * buttonArray;

@property (nonatomic,assign) id<VerificationDelegate> verificationDelegate;

@property (nonatomic,assign) id<ResetDelegate> resetDelegate;

@property (nonatomic,assign) id<TouchBeginDelegate> touchBeginDelegate;

/*
 1: Verify
 2: Reset
 */
@property (nonatomic,assign) NSInteger style;

- (void)enterArgin;

@end
