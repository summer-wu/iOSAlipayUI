//
//  ServicesButton.h
//  AlipayFinal
//
//  Created by wushuyu on 14-11-13.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiscoveryButtonDataSource <NSObject>
@required
-(NSString *)setIconTitle:(id)button;
//-(UIImage * )setIcon; 

@end

@interface DiscoveryButton : UIButton
@property (nonatomic,strong) NSString * titleBelowIcon;
@property (nonatomic, assign) IBOutlet id <DiscoveryButtonDataSource> dataSource;
@property (nonatomic,assign) BOOL initialized;
@end

