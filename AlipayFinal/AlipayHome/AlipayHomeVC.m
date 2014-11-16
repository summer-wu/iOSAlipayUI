//
//  AlipayHomeVC.m
//  AlipayFinal
//
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import "AlipayHomeVC.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>


@interface AlipayHomeVC ()
@property (weak, nonatomic) IBOutlet UIButton *topleftImageButton;
@property (weak, nonatomic) IBOutlet UIButton *toprightImageButton;
@property (strong,nonatomic) NSDictionary * plistRootDictionary;
@property (strong,nonatomic) NSMutableArray * titles,*iconPaths;
@property (strong,nonatomic) UIViewController * billVC;
-(void)logSubviews:(NSArray *)subviews tabnum:(int)tabnum;
@end

@implementation AlipayHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置分割线,上面有一个分割线，下面的tabbar还要是白色的
    UIView * spliter=[[UIView alloc]init];
    spliter.backgroundColor=[UIColor blackColor];
    spliter.frame=CGRectMake(0, 0, 320, 100);
    [self.view insertSubview:spliter atIndex:0];
    // 设置左上角和右上角的按钮图片
    NSString * imagePath=@"AlipayHome.bundle/ap_home_top_icon_scan_new";
    NSString * highlightImagePath=[NSString stringWithFormat:@"%@_highlight",imagePath];
    [self.topleftImageButton setImage:[UIImage imageNamed:imagePath]  forState:UIControlStateNormal];
    [self.topleftImageButton setImage:[UIImage imageNamed:highlightImagePath]  forState:UIControlStateHighlighted];

    imagePath=@"AlipayHome.bundle/ap_home_top_icon_pay_new";
    highlightImagePath=[NSString stringWithFormat:@"%@_highlight",imagePath];
    [self.toprightImageButton setImage:[UIImage imageNamed:imagePath]  forState:UIControlStateNormal];
    [self.toprightImageButton setImage:[UIImage imageNamed:highlightImagePath]  forState:UIControlStateHighlighted];
    
    
    //加载plist文件
    NSString * s=[[NSBundle mainBundle] pathForResource:@"AlipayHomeIcons.bundle/AlipayHomeIcons" ofType:@"plist"];
    if (s) {
        self.plistRootDictionary=[NSDictionary dictionaryWithContentsOfFile:s];
    }
    id key;
    self.titles= [[NSMutableArray alloc]init];
    self.iconPaths= [[NSMutableArray alloc]init];

    for (key in self.plistRootDictionary) {
        [self.titles addObject:key];
        [self.iconPaths addObject: [self.plistRootDictionary objectForKey:key]];
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

-(void)logSubviews:(NSArray *)subviews tabnum:(int)tabnum{
    UIView * i;
    //设置tabstring
    NSMutableString * tabstring=[NSMutableString stringWithString:@""];
    for(int j=1;j<=tabnum;j++){
        [tabstring appendFormat:@"+"];
    }
    //递归遍历
    for (i in subviews) {
        if (i.subviews.count>0) {//还有subviews
            NSLog(@"%@Have %d subvies.%@ ",tabstring,i.subviews.count,i);
            [self logSubviews:i.subviews tabnum:(tabnum+1)];
        }else{//当前是终端view
            NSLog(@"%@ %@",tabstring,i);
        }
    }
    
}
#pragma mark tableview protocol
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"id_fourbuttons";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //设置右边的竖线边框
    for (int i=1; i<=3; i++) {
        UILabel * tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(80*i+1, 0, 1, cell.frame.size.height)];
        tempLabel.backgroundColor=[UIColor colorWithRed:235./255 green:235./255 blue:235./255 alpha:1];
        [cell addSubview:tempLabel];
    }
    //设置下面的边框
    UILabel * tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height, cell.frame.size.width, 1)];
    tempLabel.backgroundColor=[UIColor colorWithRed:235./255 green:235./255 blue:235./255 alpha:1];
    [cell addSubview:tempLabel];
    
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}


#pragma mark AlipayHomeIconDataSource
-(UIImage *)setIcon{
    static int  i=0;
    i++;
    NSString * s=[NSString stringWithFormat:@"AlipayHomeIcons.bundle/%@",self.iconPaths[i]];
    UIImage * img= [UIImage imageNamed:s];
    UIImage * scaledimg=[UIImage imageWithCGImage:img.CGImage scale:img.scale*2.0 orientation:img.imageOrientation];
    return  scaledimg;
}
-(NSString *)setIconTitle{
    static int i=0;
    i++;
    return self.titles[i];
}
#pragma mark Bill
- (IBAction)bill_click:(UIBarButtonItem *)sender {
    self.billVC=[[UIViewController alloc]init];
    self.billVC.view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.billVC.view.backgroundColor=[UIColor whiteColor];//前面的页面设置背景为黑色了，到这也是黑色？
    UILabel * label=[[UILabel alloc]initWithFrame:self.billVC.view.bounds];
    label.text=@"账单页面是用代码生成的，详见biil_click";
    [self.billVC.view addSubview:label];
    
    //维护UINavigationItem
    //左
    self.billVC.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.billVC.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    //中，高23pt，白色
    //self.billVC.title=@"账单"; //字体较小
    UIButton * but=[[UIButton alloc]init];
    but.tintColor=[UIColor whiteColor];
    [but setTitle:@"账单" forState:UIControlStateNormal];
    but.titleLabel.font= [UIFont systemFontOfSize: 23];
    
    self.billVC.navigationItem.titleView=but;
    //右
    self.billVC.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"AlipayHomeIcons.bundle/bill_history.png"] style:UIBarButtonItemStylePlain target:self action:@selector(noDefinitionPopup:)];
    self.billVC.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.navigationController pushViewController:self.billVC animated:YES];
    
}

-(void)noDefinitionPopup:(id)sender{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此功能未实现" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alert show];
}

-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
