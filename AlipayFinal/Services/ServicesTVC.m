//
//  ServicesVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-13.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "ServicesTVC.h"

@interface ServicesTVC ()
@property (nonatomic,strong) NSArray * servicesPlistArray;

@end

@implementation ServicesTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载plist
    NSString * s=[[NSBundle mainBundle] pathForResource:@"Services.bundle/Services" ofType:@"plist"];
    if (s) {
        self.servicesPlistArray=[NSArray arrayWithContentsOfFile:s];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark tableview protocol
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //有两个id ，一个 id_subTitle, 一个 id_basic. Diction的key有iconFileName title detail
    //设置cellid
    NSDictionary * d=self.servicesPlistArray[indexPath.row];
    NSString * detail=d[@"detail"];
    NSString * cellid;
    if([detail compare:@""]==NSOrderedSame){
        cellid=@"id_basic";
    }else{
        cellid=@"id_subTitle";
    }
    //获取cellid
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    //设置图片
    NSString * imagePath=[NSString stringWithFormat:@"Services.bundle/%@",d[@"iconFileName"]];
    cell.imageView.image=[UIImage imageNamed:imagePath];
    //设置title
    [cell.textLabel setText:d[@"title"]];
    //设置detail
    [cell.detailTextLabel setText:d[@"detail"]];
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.servicesPlistArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53.;
}



@end
