//
//  WidgetsVC.h
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WidgetsVC;

//Widgets需要用到的代理
@protocol WidegetsVCDelegate <NSObject>
//LoginView专用
-(void)WidgetsVC:(WidgetsVC *)widgetsVC loginOK:(id)nilplaceholder;

@end

@interface WidgetsVC : UIViewController

//一个falg，用于判断显示哪个view
@property (weak,nonatomic) NSString * whichViewToPresent;

//LoginView
-(void)showLoginView;
@property (strong, nonatomic) IBOutlet UIControl *loginView;
@property (weak, nonatomic) IBOutlet UITextField *textField_username;
@property (weak, nonatomic) IBOutlet UITextField *textField_password;
@property (weak, nonatomic) IBOutlet UILabel *label_detail;
@property (weak,nonatomic) id<WidegetsVCDelegate> delegate;
- (IBAction)login:(id)sender;
-(void)resignFirstResponder4textField:(id)sender;
-(void)resignFirstResponder4LoginView;
@end



