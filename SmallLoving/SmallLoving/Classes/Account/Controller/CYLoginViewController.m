//
//  CYLoginViewController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYLoginViewController.h"
#import "CYLoginView.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CYAlertController.h"
#import <MBProgressHUD.h>
#import "CYAccountTool.h"
#import "CYAccount.h"
#import "CYRootTool.h"
@interface CYLoginViewController ()

/**
 *  控制器主 View
 */
@property (nonatomic, weak) CYLoginView * loginView;

/**
 *  小菊花
 */
@property (nonatomic, weak) MBProgressHUD * hud;

@end

@implementation CYLoginViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavigationBar];
    [self.loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.findPasswordBtn addTarget:self action:@selector(findPasswordAction) forControlEvents:(UIControlEventTouchUpInside)];
}

/**
 *  布局 navigationBar
 */
- (void)layoutNavigationBar {
    self.title = @"登录";
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 登录
- (void)loginAction {
    [self.hud show:YES];
    NSError * error = nil;
    AVUser * user = [AVUser logInWithMobilePhoneNumber:self.loginView.userNameTf.text password:self.loginView.passwordTf.text error:&error];
    if (!error && user.mobilePhoneVerified) {
        [self.hud hide:YES];
        // 储存到本地
        CYAccount * account = [CYAccount new];
        account.userName = self.loginView.userNameTf.text;
        account.password = self.loginView.passwordTf.text;
        [CYAccountTool saveAccount:account];
        [CYRootTool setRootViewController];        
    } else {
        [self.hud hide:YES];
        [CYAlertController showAlertControllerWithTitle:@"失败" message:@"登录失败, 请重试" preferredStyle:(UIAlertControllerStyleActionSheet) isSucceed:NO viewController:self];
    }

}

// 找回密码
- (void)findPasswordAction {
    
}

- (CYLoginView *)loginView {
    if (!_loginView) {
        CYLoginView * view = [[CYLoginView alloc]initWithFrame:self.view.bounds];
        _loginView = view;
        [self.view addSubview:view];
    }
    return _loginView;
}

- (MBProgressHUD *)hud {
    if (!_hud) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.loginView animated:YES];
        _hud = hud;
        hud.labelText = @"登录中";
        hud.alpha = 0.5;
    }
    return _hud;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
