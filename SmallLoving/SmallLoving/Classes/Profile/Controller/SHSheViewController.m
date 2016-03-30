//
//  SHSheViewController.m
//  Happiness
//
//  Created by 云志强 on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSheViewController.h"
#import "SHLeftBackButton.h"


@interface SHSheViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@end

@implementation SHSheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"另一半";
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableview];
    
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.bounces=NO;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
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

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分组数 也就是section数
    return 2;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
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
        return 60;
    }else{
        return 10;
    }
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 40;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section==0 && indexPath.row==0) {
        UILabel *labelpic = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 30)];
        labelpic.text = @"头像";
        [cell addSubview:labelpic];
        //自己的头像
        UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menses-gender-woman"]];
        image1.frame = CGRectMake(kScreenW-100, 5, 70, 70);
        _image = image1;
        [cell addSubview:image1];
    }
    if(indexPath.section == 0 && indexPath.row == 1){
        UILabel *labelname = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        labelname.text = @"昵称";
        [cell addSubview:labelname];
        //自己的昵称
        UILabel *labelnamenew = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW-230, 5, 200, 30)];
        labelnamenew.text = @"她";
        labelnamenew.textAlignment = NSTextAlignmentRight;
        _label1 = labelnamenew;
        [cell addSubview:labelnamenew];
    }
    if(indexPath.section == 0 && indexPath.row == 2){
        UILabel *labelnum = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        labelnum.text = @"恩爱号";
        [cell addSubview:labelnum];
        //自己的昵称
        UILabel *labelnumnew = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW-230, 5, 200, 30)];
        labelnumnew.text = @"123456";
        labelnumnew.textAlignment = NSTextAlignmentRight;
        _label2 = labelnumnew;
        [cell addSubview:labelnumnew];
    }
    if(indexPath.section == 0 && indexPath.row == 3){
        UILabel *labelnum = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        labelnum.text = @"手机号";
        [cell addSubview:labelnum];
        //自己的昵称
        UILabel *labelnumnew = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW-230, 5, 200, 30)];
        labelnumnew.text = @"123456";
        labelnumnew.textAlignment = NSTextAlignmentRight;
        _label2 = labelnumnew;
        [cell addSubview:labelnumnew];
    }
    if(indexPath.section == 0 && indexPath.row == 4){
        UILabel *labelnum = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        labelnum.text = @"邮箱";
        [cell addSubview:labelnum];
        //自己的昵称
        UILabel *labelmail = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW-230, 5, 200, 30)];
        labelmail.text = @"123@gmail.com";
        labelmail.textAlignment = NSTextAlignmentRight;
        _label3 = labelmail;
        [cell addSubview:labelmail];
    }
    if(indexPath.section == 1){
        cell.textLabel.text=@"解除关系";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
        
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell  松开后颜色恢复点击前的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"十年修得同船渡,百年修得共枕眠.除非不爱了,否则我们不建议您轻易迈出这一步,请珍惜,请三思." preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"解除关系" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self unchain];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"手滑,点错了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alerVC addAction:action1];
        [alerVC addAction:action2];
        [self presentViewController:alerVC animated:YES completion:nil];
    }
}

-(void)unchain{
    NSLog(@"谁不分手谁小狗,汪汪汪!!");
}
@end
