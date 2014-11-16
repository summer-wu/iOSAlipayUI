//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import "GesturePasswordController.h"

#define BLog(formatString, ...) NSLog((@">Blog:%s " formatString), __PRETTY_FUNCTION__, ##__VA_ARGS__);

//VC控制器有两个方法，clear、exist。还有3个私有实例变量 gesturePasswordView、previousString、password
@interface GesturePasswordController ()

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;

@end

@implementation GesturePasswordController {
    NSString * previousString;
    NSString * password;
}

@synthesize gesturePasswordView;

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
    // Do any additional setup after loading the view.
    previousString = [NSString string];
    
    
    password = [self getDecryptedPassword];
    BLog(@"password: %d",password);
    //preset这个viewcontroller之后，读取以前保存的password。
    if ([password isEqualToString:@""]) { //以前没有保存过，就reset创建一个手势密码
        [self reset];
    }
    else { // 以前保存过password，就验证。
        [self verify];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 验证手势密码，显示passwordview让用户触摸
- (void)verify{
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setVerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];//GesturePasswordDelegate要实现forget和change两个方法
    [self.view addSubview:gesturePasswordView];
}

#pragma mark - 重置手势密码，显示passwordview，隐藏两个按钮
- (void)reset{
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
//    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [self.view addSubview:gesturePasswordView];//这时才刚显示了界面，此界面没有两个按钮，所以只能输入手势
}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist{
    password = [self getDecryptedPassword];
    if ([password isEqualToString:@""])
        return NO;
    return YES;
}

#pragma mark - 清空记录
- (void)clear{
    [[NSUserDefaults
                 standardUserDefaults] removeObjectForKey:@"GesturePassword"];

}

#pragma mark - 按钮事件改变手势密码
- (void)change{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此功能未实现" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];}

#pragma mark - 按钮事件忘记手势密码
- (void)forget{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此功能未实现" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - tentacle触角是否正确
- (BOOL)verification:(NSString *)result{
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
        //自己加的
        [self.delegate GesturePasswordController:self verifyOK:nil];
        //[self presentViewController:(UIViewController) animated:YES completion:nil];
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    [gesturePasswordView.state setText:@"手势密码错误"];
    return NO;
}
#pragma mark - tentacle中定义协议resetPassword
//TouchEnd时、切tentacle.style为2时 调用此函数，用来重设密码
- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) { //previousString为空，第一次输入手势
        previousString=result;//将第一次手势保存到一个previousString 它与password完全不是一个东西
        [gesturePasswordView.tentacleView enterArgin];//再让用户输入一次手势密码，然后就到下面的else部分了
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请验证输入密码"];
        return YES;
    }
    else { //第二次输入手势
        if ([result isEqualToString:previousString]) {
            //第二次与第一次相同，可以保存了
            [self saveUnEncryptedPassword:result];
            BLog(@"保存密码OK!");
            [self.delegate GesturePasswordController:self resetOK:nil];
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码"];
            //reset成功，关闭这个弹出窗
            [self dismissViewControllerAnimated:YES completion:nil];
            return YES;
        }
        else{
            //两次输入不相同
            previousString =@"";
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            return NO;
        }
    }
}

-(NSString *)getDecryptedPassword{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * encrypedPass=[defaults stringForKey:@"key_GuesturePassword"]; //可能返回nil
    NSString * decryptedPass=[AESCrypt decrypt:encrypedPass password:AESKEY];//不可能返回nil
    return decryptedPass;
}
-(void)saveUnEncryptedPassword:(NSString *)pass{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * encryptedPass=[AESCrypt encrypt:pass password:AESKEY];
    [defaults setObject:encryptedPass forKey:@"key_GuesturePassword"];
    [defaults synchronize];
}



@end
