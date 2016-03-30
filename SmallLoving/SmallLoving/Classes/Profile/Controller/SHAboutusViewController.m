//
//  SHAboutusViewController.m
//  Happiness
//
//  Created by 云志强 on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAboutusViewController.h"
#import "SHLeftBackButton.h"

@interface SHAboutusViewController ()
@property(nonatomic,strong)UILabel *labeltitle;
@property(nonatomic,strong)UILabel *label;
@end

@implementation SHAboutusViewController


- (UILabel *)labeltitle{
    if (!_labeltitle) {
        UILabel * label = [UILabel new];
        _labeltitle = label;
        label.text = @"关于我们";
        label.font = [UIFont systemFontOfSize:30];
        [self.view addSubview:label];
    }
    return _labeltitle;
}

- (UILabel *)label{
    if (!_label) {
        UILabel * label = [UILabel new];
        _label = label;
        label.text = @"     没什么可说的!";
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.labeltitle.frame = CGRectMake(kScreenW/2-70, 70, 140, 40);
    self.label.frame = CGRectMake(20,130 , kScreenW-40, 240);
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@" 我      "];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
