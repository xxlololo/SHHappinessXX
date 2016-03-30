//
//  SHProfileViewController.m
//  Happiness
//
//  Created by Cheney on 16/3/16.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHProfileViewController.h"
#import "SHAboutusViewController.h"
#import "SHMyViewController.h"
#import "SHSheViewController.h"
#import "LCUserFeedbackAgent.h"
#import "CYAccountTool.h"
#import "CYRootTool.h"

@interface SHProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UILabel * labelmy;
@property(nonatomic,strong)UILabel * labelnumber;
@property(nonatomic,strong)UILabel * labelshe;
@property(nonatomic,strong)UIImageView *imagemy;
@property(nonatomic,strong)UIImageView *imageshe;    //获取用户头像后赋值
@end

@implementation SHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.bounces=NO;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
    self.arr=@[@"指纹解锁",@"清理缓存",@"意见反馈",@"关于小幸福"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分组数 也就是section数
    return 4;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1) {
        return 1;
    }else if (section==2){
        return self.arr.count;
    }else{
        return 1;
    }
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else if (section==1) {
        return 15;
    }else{
        return 30;
    }
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 40;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section==0) {
        //后续加入判断男女,加载不同的默认头像
        UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menses-gender-man"]];
        image1.frame = CGRectMake(10, 5, 70, 70);
        _imagemy = image1;
        [cell addSubview:image1];
        
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 7, kScreenW-120, 40)];
        nameLabel.text= @"测试Label";
        nameLabel.font = [UIFont boldSystemFontOfSize:22.0];
        _labelmy = nameLabel;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        [cell.contentView addSubview:nameLabel];
        
        UILabel *happinessnumber = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 50, 30)];
        happinessnumber.text = @"恩爱号:";
        happinessnumber.font = [UIFont boldSystemFontOfSize:14.0];
        [cell.contentView addSubview:happinessnumber];
        
        UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(150, 45, kScreenW-170, 30)];
        number.text = @"1234567";
        number.font = [UIFont boldSystemFontOfSize:14.0];
        _labelnumber = nameLabel;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        [cell.contentView addSubview:number];

    }else if (indexPath.section==1){
        UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menses-gender-woman"]];
        image2.frame = CGRectMake(10, 2, 36, 36);
        _imageshe = image2;
        [cell addSubview:image2];
        UILabel *sheLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 40)];
        sheLabel.text= @"另一半账户";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        [cell.contentView addSubview:sheLabel];
    }else if (indexPath.section==2) {
        if (indexPath.row==0) {
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenW-60, 5, 50, 20)];
            [switchButton setOn:YES];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            switchButton.on = NO;
            [cell.contentView addSubview:switchButton];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        
        cell.textLabel.text=[self.arr objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text=@"退出登陆";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    
//    if (indexPath.section == 2 && indexPath.row == 0) {
//        cell.accessoryType = UITableViewCellAccessoryNone; //神马都不要显示了
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
//    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell  松开后颜色恢复点击前的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SHMyViewController *my = [SHMyViewController new];
        [self.navigationController pushViewController:my animated:YES];
    }
    
    if (indexPath.section == 1) {
        SHSheViewController *she = [SHSheViewController new];
        [self.navigationController pushViewController:she animated:YES];
    }
    
        if (indexPath.section == 2 && indexPath.row == 1){
        //弹出框
        UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定清除缓存?" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self setDelete];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alerVC addAction:action1];
        [alerVC addAction:action2];
        [self presentViewController:alerVC animated:YES completion:nil];
    } else if (indexPath.section == 2 && indexPath.row == 2){
        //反馈(默认页面)
        LCUserFeedbackAgent *agent = [LCUserFeedbackAgent sharedInstance];
        [agent showConversations:self title:nil contact:nil];

    } else if (indexPath.section == 2 && indexPath.row == 3){
        SHAboutusViewController *aboutus = [SHAboutusViewController new];
        [self.navigationController pushViewController:aboutus animated:YES];
    }
    
    if (indexPath.section == 3) {
        [CYAccountTool removeAccount];
        [UIApplication sharedApplication].keyWindow.rootViewController = nil;
        [CYRootTool setRootViewController];
    }
    
    
}
//指纹解锁方法
-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        //指纹解锁开
        NSLog(@"芝麻开门");
    }else {
        //指纹解锁关
        NSLog(@"芝麻关门");
    }
}

//清除缓存方法
-(void)setDelete{
    NSLog(@"点我干嘛,没写完呢");
}
@end
