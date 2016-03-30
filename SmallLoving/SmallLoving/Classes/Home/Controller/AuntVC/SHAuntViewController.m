//
//  SHAuntViewController.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAuntViewController.h"
#import "SHSexViewController.h"
#import "SHMenstruationTableViewController.h"
#import "SHAuntIsComing.h"
#import "SHAccountTool.h"

@interface SHAuntViewController ()
@property (nonatomic, strong) SHAuntIsComing * auntIsComingView;
@end

@implementation SHAuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigationBar];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChangeAction) userInfo:nil repeats:YES];
    //设置性别视图
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    if (accountHome.sex == nil) {
        SHSexViewController *sexVC = [[SHSexViewController alloc] init];
        [self.navigationController pushViewController:sexVC animated:YES];
    }
    SHAuntIsComing *auntIsComingView = [[SHAuntIsComing alloc] initWithFrame:self.view.bounds];
    self.auntIsComingView = auntIsComingView;
    [auntIsComingView.womanBtn addTarget:self action:@selector(womanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:auntIsComingView];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    if (accountHome.sex) {
        //设置界面内容
        [self.auntIsComingView setupViewWithAccountHome:accountHome];
    }
}



//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"小姨妈";
    //右键设置
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"小幸福"];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//女性按钮点击事件
- (void)womanBtnAction:(UIButton *)sender{
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"确认发送" handler:^(UIAlertAction *action) {
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        if ([accountHome.isMenstruation isEqualToString:@"YES"]) {
            accountHome.isMenstruation = @"NO";
        }else{
            accountHome.isMenstruation = @"YES";
            accountHome.lastAuntDate = [NSDate date];
        }
        //存储到沙盒
        [SHAccountTool saveAccount:accountHome];
        SHAuntIsComing *auntIsComingView = [[SHAuntIsComing alloc] initWithFrame:self.view.bounds];
        [auntIsComingView.womanBtn addTarget:self action:@selector(womanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.auntIsComingView removeFromSuperview];
        self.auntIsComingView = auntIsComingView;
        [self.view addSubview:auntIsComingView];
        //设置界面内容
        [self.auntIsComingView setupViewWithAccountHome:accountHome];
    }];
    alertVC.allActions = @[actionCamera];
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction:(UIBarButtonItem *)rightItem{
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    if ([accountHome.sex isEqualToString:@"m"]) {
        SHSexViewController *sexVC = [[SHSexViewController alloc] init];
        [self.navigationController pushViewController:sexVC animated:YES];
    }else if ([accountHome.sex isEqualToString:@"f"]) {
        SHMenstruationTableViewController *menstruationTVC = [[SHMenstruationTableViewController alloc] init];
        [self.navigationController pushViewController:menstruationTVC animated:YES];
    }
}

- (void)timeChangeAction{
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    if ([accountHome.isMenstruation isEqualToString:@"NO"]) {
        [self.auntIsComingView setupAuntTowelSecondLabelWithAccountHome:accountHome];
    }
}
@end
