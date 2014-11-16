//
//  DiscoveryTVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-13.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "DiscoveryTVC.h"

@interface DiscoveryTVC ()

@end

@implementation DiscoveryTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //其实这个完全可以做成static tableview。

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview protocol
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //有两个id id_fourbuttons id_rightDetail
    
    //判断在哪个section，设置不同cellid
    NSString *cellid;;
    if (indexPath.section==0) {
        cellid = @"id_fourbuttons";
    }else{
        cellid=@"id_rightDetail";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    //section==0时就不修改了（创建DiscoveryButton时内部维护），section==1时需要设置title和detail
    if(indexPath.section==1){
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_movie"];
            [cell.textLabel setText:@"电影票"];
            [cell.detailTextLabel setText:@"看电影 学撒娇"];
        } else {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"快的打车"];
            [cell.detailTextLabel setText:@""];
        }
        
    }
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 94.;
    }else if(indexPath.section==1){
        return 50.;
    }else{
        return 0.;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 16;
    }else{
        return 21;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


#pragma mark AlipayHomeIconDataSource
-(NSString *)setIconTitle:(id)button{
    UIButton * but=button;
    switch (but.tag) {
        case 1:
            return @"红包";
            break;
        case 2:
            return @"电子券";
            break;
        case 3:
            return @"行程单";
            break;
        case 4:
            return @"会员卡";
            break;
        default:
            return @"";
            break;
    }
}

@end
