//
//  GesturePasswordController.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "GesturePasswordView.h"

#import "AESCrypt.h"
#define AESKEY @"123456"

@class GesturePasswordController;

@protocol GesturePasswordControllerDelegate <NSObject>
-(void)GesturePasswordController:(GesturePasswordController *)passController verifyOK:(id)nilplaceholder;
-(void)GesturePasswordController:(GesturePasswordController *)passController resetOK:(id)nilplaceholder;
@end

@interface GesturePasswordController : UIViewController <VerificationDelegate,ResetDelegate,GesturePasswordDelegate>

- (void)clear;
- (BOOL)exist;

-(NSString *)getDecryptedPassword;
-(void)saveUnEncryptedPassword:(NSString *)pass;
@property (nonatomic,weak) id<GesturePasswordControllerDelegate> delegate;
@end
