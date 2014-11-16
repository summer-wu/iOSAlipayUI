//
//  GesturePasswordView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import "GesturePasswordView.h"
#import "GesturePasswordButton.h"
#import "TentacleView.h"

@implementation GesturePasswordView {
//私有实例变量
    NSMutableArray * buttonArray;
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
}
@synthesize imgView;
@synthesize forgetButton;
@synthesize changeButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;

//只能编程调用initWithFrame:方法。IB调用的时用的是initWithCoder
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
        //⬇️ 创建一个view，内部只有9个button，并且把这个view添加到当前PasswordView上（subviews[0]）
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-160, frame.size.height/2-80, 320, 320)];
        for (int i=0; i<9; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            // Button Frame
            
            NSInteger distance = 320/3;
            NSInteger size = distance/1.5;
            NSInteger margin = size/4;
            GesturePasswordButton * gesturePasswordButton = [[GesturePasswordButton alloc]initWithFrame:CGRectMake(col*distance+margin, row*distance, size, size)];
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
        }
        frame.origin.y=0;
        view.center=CGPointMake(view.center.x, view.center.y-20);  //view向上移动20pt
        [self addSubview:view];
        //⬇️触手,内部只有9个button，并且把这个tentacleview添加到当前PasswordView上（subviews[1]）,覆盖了上面的九宫格view
        tentacleView = [[TentacleView alloc]initWithFrame:view.frame];
        [tentacleView setButtonArray:buttonArray];
        [tentacleView setTouchBeginDelegate:self];
        [self addSubview:tentacleView];
        //⬇️ state是一个宽280高30的标签，居中对齐，字体14pt。一个方块的左边点坐标=方块中心点坐标-0.5宽，所以state的center为(屏幕中心x，屏幕中心y-105)。y不如直接改为60。或者直接先创建然后设置center位置
        //state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, frame.size.height/2-105-15, 280, 30)];//作者代码
        //state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, 60, 280, 30)];//第二种
        state=[[UILabel alloc]init];//第三种
        state.center=CGPointMake(frame.size.width/2, 125);//第三种
        state.bounds=CGRectMake(0, 0, 280, 30);//第三种
        [state setTextAlignment:NSTextAlignmentCenter];
        [state setFont:[UIFont systemFontOfSize:14.f]];
        [self addSubview:state];
        
        //⬇️imgView是头像
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-35, frame.size.width/2-80-35, 70, 70)];
        imgView.image=[UIImage imageNamed:@"GesturePassword.bundle/avatar.png"];
        imgView.layer.masksToBounds = YES;
        [imgView setBackgroundColor:[UIColor whiteColor]];
        [imgView.layer setCornerRadius:35];
        [imgView.layer setBorderColor:[UIColor grayColor].CGColor];
        [imgView.layer setBorderWidth:3];
        [self addSubview:imgView];
        //⬇️设置forgetButton
        //forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-150, frame.size.height/2+220, 120, 30)];
        forgetButton=[[UIButton alloc]init];
        forgetButton.center=CGPointMake(frame.size.width/2-90, frame.size.height-25);
        forgetButton.bounds=CGRectMake(0, 0, 120, 30);
        [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchDown];
        [self addSubview:forgetButton];
        //⬇️设置changeButton
        //changeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, frame.size.height/2+220, 120, 30)];
        changeButton=[[UIButton alloc]init];
        changeButton.center=CGPointMake(frame.size.width/2+90, frame.size.height-25);
        changeButton.bounds=CGRectMake(0, 0, 120, 30);
        [changeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changeButton setTitle:@"修改手势密码" forState:UIControlStateNormal];
        [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
        [self addSubview:changeButton];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        134 / 255.0, 157 / 255.0, 147 / 255.0, 1.00,
        3 / 255.0,  3 / 255.0, 37 / 255.0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation);
}

- (void)gestureTouchBegin {
    [self.state setText:@""];
}

-(void)forget{
    [gesturePasswordDelegate forget];
}

-(void)change{
    [gesturePasswordDelegate change];
}


@end
