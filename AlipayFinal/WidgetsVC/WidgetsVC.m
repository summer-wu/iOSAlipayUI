//
//  WidgetsVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "WidgetsVC.h"

@interface WidgetsVC ()

@end

@implementation WidgetsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    //判断显示那个view
    if ([self.whichViewToPresent isEqualToString:@"loginView"]) {
        [self showLoginView];
    }else{ //以后添加
        return ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LoginView
-(void)showLoginView{
    //显示loginview
    self.view=self.loginView;
    //绑定事件
    [self.textField_username addTarget:self action:@selector(resignFirstResponder4textField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.textField_password addTarget:self action:@selector(resignFirstResponder4textField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.loginView addTarget:self action:@selector(resignFirstResponder4LoginView) forControlEvents:UIControlEventTouchDown];
    //隐藏label
    self.label_detail.text=@"";
}


- (IBAction)login:(id)sender {
    NSString * username=self.textField_username.text;
    NSString * password=self.textField_password.text;
    
    if ([username isEqualToString:@"user00"] && [password isEqualToString:@"00user"]) {
        self.label_detail.text=@"输入正确";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key_isLogined"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.delegate WidgetsVC:self loginOK:nil];
    }else{
        self.label_detail.text=@"账号或密码错误，请重新输入";
    }
}

-(void)resignFirstResponder4textField:(id)sender{
    [sender resignFirstResponder];
}

-(void)resignFirstResponder4LoginView{
    [self.textField_password resignFirstResponder];
    [self.textField_username resignFirstResponder];
}
@end
