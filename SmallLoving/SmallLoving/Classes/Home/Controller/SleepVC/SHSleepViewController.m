//
//  SHSleepViewController.m
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSleepViewController.h"
#import "SHSleepView.h"
#import "SHAccountHome.h"
#import "SHAccountTool.h"

@interface SHSleepViewController ()

@property (nonatomic, strong) SHSleepView * sleepView;

@end

@implementation SHSleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //取出账号信息
    SHAccountHome *accountHome = [SHAccountTool account];
    
    SHSleepView *sleepView = [[SHSleepView alloc] initWithFrame:self.view.bounds];
    _sleepView = sleepView;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dataChangeAction) userInfo:nil repeats:YES];
    
    sleepView.sleepTimeLabel.text = [sleepView createdSinceNowWithDate:accountHome.sleepTimeDate];

    [self.view addSubview:sleepView];
    
    //设置返回按钮
    [sleepView.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //设置我醒了按钮
    [sleepView.wakeBtn addTarget:self action:@selector(wakeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dataChangeAction {
    SHAccountHome *accountHome = [SHAccountTool account];
    _sleepView.sleepTimeLabel.text = [_sleepView createdSinceNowWithDate:accountHome.sleepTimeDate];

}

- (void)wakeBtnAction:(UIButton *)button{
    //取出账号信息
    SHAccountHome *accountHome = [SHAccountTool account];
    accountHome.isSleep = @"NO";
    accountHome.sleepTimeDate = nil;
    //存进沙盒
    [SHAccountTool saveAccount:accountHome];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backBtnAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
