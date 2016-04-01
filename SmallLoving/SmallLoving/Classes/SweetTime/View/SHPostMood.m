//
//  SHPostMood.m
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeigh [UIScreen mainScreen].bounds.size.height
#define rectLeftArm CGRectMake(1, 90, 40, 65)
#define rectRightArm CGRectMake(header.frame.size.width / 2 + 60, 90, 40, 65)
#define rectLeftHand CGRectMake(kWidth/ 2 - 100, loginview.frame.origin.y - 22, 40, 40)
#define rectRightHand CGRectMake(kWidth/ 2 + 62, loginview.frame.origin.y - 22, 40, 40)


#define kY self.frame.size.width-40

#import "SHPostMood.h"
@interface SHPostMood()<UITextFieldDelegate,UITextViewDelegate>

@property (assign,nonatomic) ClickType clicktype;

@end

@implementation SHPostMood
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
            }
    return self;
}


- (void)loadViews{
    
    UIImageView* header = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/ 2 - 211 / 2, 40, 211, 109)];
    
    header.image=[UIImage imageNamed:@"header"];
    [self addSubview:header];
    
    //添加button 点击触发动画
    self.headButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 211, 109)];
    self.headButton.backgroundColor = [UIColor clearColor];
  

    
    _lefthArm=[[UIImageView alloc]initWithFrame:rectLeftArm];
    _lefthArm.image=[UIImage imageNamed:@"left"];
    [header addSubview:_lefthArm];
    
    
    _rightArm=[[UIImageView alloc]initWithFrame:rectRightArm];
    _rightArm.image=[UIImage imageNamed:@"right"];
    [header addSubview:_rightArm];
    [header addSubview:self.headButton];
    [header bringSubviewToFront:self.headButton];
    header.userInteractionEnabled = YES ;
    UIView *loginview=[[UIView alloc]initWithFrame:CGRectMake(15, 140, kWidth-30, 260)];
    loginview.layer.borderWidth=1;
    loginview.layer.borderColor=[UIColor lightGrayColor].CGColor;
    loginview.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:loginview];
    
    _lefthand = [[UIImageView alloc]initWithFrame:rectLeftHand];
    _lefthand.image = [UIImage imageNamed:@"hand"];
    [self addSubview:_lefthand];
    
    _righthand = [[UIImageView alloc]initWithFrame:rectRightHand];
    _righthand.image = [UIImage imageNamed:@"hand"];
    [self addSubview:_righthand];
    self.titleField=[[UITextField alloc]initWithFrame:CGRectMake(30, 30, kWidth-90, 44)];
    self.titleField.layer.cornerRadius = 5;
    self.titleField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.titleField.layer.borderWidth=0.7;
    self.titleField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.titleField.leftViewMode = UITextFieldViewModeAlways;
    self.titleField.delegate = self ;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    titleLabel.text = @"标题:";
    [self.titleField.leftView addSubview:titleLabel];
    
    [loginview addSubview:self.titleField];
    
    UIImageView* pssimag = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    pssimag.image = [UIImage imageNamed:@"pass"];
    self.textV.delegate = self ;
    self.textV = [[UITextView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.titleField.frame)+30, self.frame.size.width-90, 120)];
    self.textV.textAlignment = NSTextAlignmentLeft ;
    self.textV.backgroundColor =[UIColor colorWithWhite:0.9 alpha:1];
    self.textV.font = [UIFont systemFontOfSize:15.0f];
    self.textV.editable = YES ;
    self.textV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textV.layer.cornerRadius = 6.0f;
    self.textV.layer.borderWidth = 2;
    self.textV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textV.userInteractionEnabled = YES ;
    [loginview addSubview:self.textV];
    //创建Label 加提示语
    self.promptTitle = [[UILabel alloc]initWithFrame:CGRectMake(5,5,100,20)];
    self.promptTitle.text = @"最多可输入140字";
    self.promptTitle.font = [UIFont systemFontOfSize:12.0];
    [self.promptTitle setTextColor:[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:0.8]];
    
    self.promptTitle.hidden=NO;
    [self.textV addSubview:self.promptTitle];

}
//点击屏幕任意一处取消键盘的第一响应项
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
//判断是否超出最大限额 140
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    }
    else {
        if (self.textV.text.length - range.length + text.length > 140) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出最大可输入长度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];            [alert show];
            return NO;
        }
        else {
            return YES;
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_titleField]) {
        if (_clicktype != clicktypePass) {
            _clicktype =clicktypeUser;
            return;
        }
        _clicktype=clicktypeUser;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.lefthArm.frame = CGRectMake(self.lefthArm.frame.origin.x - 60, self.lefthArm.frame.origin.y + 30, self.lefthArm.frame.size.width, self.lefthArm.frame.size.height);
            
            self.rightArm.frame = CGRectMake(self.rightArm.frame.origin.x+48, self.rightArm.frame.origin.y + 30, self.rightArm.frame.size.width, self.rightArm.frame.size.height);
            
            self.lefthand.frame = CGRectMake(self.lefthand.frame.origin.x-70, self.lefthand.frame.origin.y, 40, 40);
            self.righthand.frame = CGRectMake(self.righthand.frame.origin.x +30, self.righthand.frame.origin.y, 40, 40);
        } completion:^(BOOL finished) {
            
        }];
    }else if ([textField isEqual:_titleField]){
        if (_clicktype == clicktypePass)
        {
            return;
        }
        _clicktype = clicktypePass;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.lefthArm.frame = CGRectMake(self.lefthArm.frame.origin.x + 60, self.lefthArm.frame.origin.y - 30, self.lefthArm.frame.size.width, self.lefthArm.frame.size.height);
            
            self.rightArm.frame = CGRectMake(self.rightArm.frame.origin.x - 48, self.rightArm.frame.origin.y - 30, self.rightArm.frame.size.width, self.rightArm.frame.size.height);
            
            self.lefthand.frame = CGRectMake(self.lefthand.frame.origin.x + 70, self.lefthand.frame.origin.y, 0, 0);
            self.righthand.frame = CGRectMake(self.righthand.frame.origin.x - 30, self.righthand.frame.origin.y, 0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
