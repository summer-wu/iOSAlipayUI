//
//  AlipayHomeIconButton.h
//  test
//
//  Created by wushuyu on 14-11-13.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlipayHomeIconButtonDataSource <NSObject>
-(NSString *)setIconTitle;
-(UIImage * )setIcon;

@end

@interface AlipayHomeIconButton : UIButton
@property (nonatomic,strong) NSString * titleBelowIcon;
@property (nonatomic, assign) IBOutlet id <AlipayHomeIconButtonDataSource> dataSource;
@property (nonatomic,assign) BOOL initialized;
@end
