//
//  SHPostMood.m
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//
#define CWScreenW  [UIScreen mainScreen].bounds.size.width
#define kY self.frame.size.width-40
#import "SHPostMood.h"

@implementation SHPostMood
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
    }
    return self;
}

- (void)loadViews{
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, kY, 20)];
    self.titleLabel.text = @"心情标题:";
    [self addSubview:self.titleLabel];
    self.backgroundColor = [UIColor whiteColor];
    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(20, 40, kY, 40)];
    self.titleField.font = [UIFont boldSystemFontOfSize:14];
    self.titleField.placeholder = @"标题内容(不超过20个字)";
    self.titleField.textAlignment = NSTextAlignmentLeft;
    self.titleField.layer.cornerRadius = 6.0f;
    self.titleField.layer.borderWidth = 2;
    self.titleField.tintColor = [UIColor blackColor];
    self.titleField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.titleField.layer.borderColor = [[UIColor colorWithRed:100.0/255 green:200/255 blue:10/255 alpha:1] CGColor];
    [self addSubview:self.titleField];
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, kY, 20)];
    self.textLabel.text = @"心情内容:";
    [self addSubview:self.textLabel];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 120, kY, 100)];
    [self addSubview:self.textView];
    
    //设置字体对齐方式
    self.textView.textAlignment = NSTextAlignmentLeft ;
    self.textView.textColor = [UIColor purpleColor];
    self.textView.font = [UIFont systemFontOfSize:12.0f];
    //设置编辑使能属性,是否允许编辑（=NO时，只用来显示，依然可以使用选择和拷贝功能）
    self.textView.editable = YES;
    //设置背景颜色属性
    self.textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //设置圆角、边框属性
    self.textView.layer.cornerRadius = 6.0f;
    self.textView.layer.borderWidth = 2;
    self.textView.layer.borderColor = [[UIColor colorWithRed:100.0/255 green:200/255 blue:10/255 alpha:1] CGColor];
    
    
}
@end
