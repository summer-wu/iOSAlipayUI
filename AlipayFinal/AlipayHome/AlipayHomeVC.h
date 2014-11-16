//
//  AlipayHomeVC.h
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlipayHomeIconButton.h"
@interface AlipayHomeVC : UIViewController<UITableViewDataSource,UITableViewDelegate,AlipayHomeIconButtonDataSource>
- (IBAction)bill_click:(UIBarButtonItem *)sender;
-(void)noDefinitionPopup:(id)sender;
@end
