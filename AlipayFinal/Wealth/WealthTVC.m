//
//  WealthTVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-14.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "WealthTVC.h"

@interface WealthTVC ()

@end

@implementation WealthTVC

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
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark tableview protocol
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //有两个id id_subTitle id_rightDetail
    
    //判断在哪个section，设置不同cellid
    NSString *cellid;;
    if (indexPath.section==0) {
        cellid = @"id_subTitle";
    }else{
        cellid=@"id_rightDetail";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (indexPath.section==0) {//第0个区块，设置用户头像等
        cell.imageView.image=[UIImage imageNamed:@"Wea_avatar"];
        [cell.textLabel setText:@"用户姓名"];
        [cell.detailTextLabel setText:@"username@domain.com"];
    }else if(indexPath.section==1 && indexPath.row==0){
        //1.0
    cell.imageView.image=[UIImage imageNamed:@"Wea_zhanghuyue"];
    [cell.textLabel setText:@"账户余额"];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%.2f",0.0]];
    }else if(indexPath.section==1 && indexPath.row==1){
        //1.1
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodeyinhangka"];
        [cell.textLabel setText:@"我的银行卡"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d张",0]];
    }else if (indexPath.section==2){
        //2.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_yuebao"];
        [cell.textLabel setText:@"余额宝"];
        [cell.detailTextLabel setText:@""];
    }else if (indexPath.section==3){
        //3.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"我的保障"];
        [cell.detailTextLabel setText:@""];
    }else{
        //4.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_aixinjuanzeng"];
        [cell.textLabel setText:@"爱心捐赠"];
        [cell.detailTextLabel setText:@""];
    }
    return  cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        return 77.;
    }else{
        return 49.;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}




@end
