//
//  GesturePasswordView.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//
/*GesturePasswordView:UIView. 这个类的作用是显示九宫格界面。有5个属性.
 TentacleView，tentacle触须，也是一个UIView
 state，一个Label，用来显示当前状态。
 gesturePasswordDelegate，此属性用来让VC实现，实现此view的forget、change功能
 imgView 头像
 forgetButton
 changeButton
 
 
 
 */
 
@protocol GesturePasswordDelegate <NSObject>

- (void)forget;
- (void)change;

@end

#import <UIKit/UIKit.h>
#import "TentacleView.h"

@interface GesturePasswordView : UIView<TouchBeginDelegate>

@property (nonatomic,strong) TentacleView * tentacleView;

@property (nonatomic,strong) UILabel * state;

@property (nonatomic,assign) id<GesturePasswordDelegate> gesturePasswordDelegate;

@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UIButton * forgetButton;
@property (nonatomic,strong) UIButton * changeButton;

@end
