//
//  SHMyViewController.m
//  Happiness
//
//  Created by 云志强 on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHMyViewController.h"
#import "SHLeftBackButton.h"
#import "SHNameController.h"
#import "SHNumController.h"
@interface SHMyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UIImageView *image;

@end

@implementation SHMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"个人信息";
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
    return 1;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
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
        UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menses-gender-man"]];
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
        labelnamenew.text = @"测试";
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头 
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell  松开后颜色恢复点击前的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self cameraBtnClick];
    }else if (indexPath.row == 1){
        SHNameController *nameVC = [SHNameController new];
        [self.navigationController pushViewController:nameVC animated:YES];
    }else if (indexPath.row == 2){
        SHNumController *numVC = [SHNumController new];
        [self.navigationController pushViewController:numVC animated:YES];
    }
}
//上传头像方法
- (void)cameraBtnClick{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    // 添加事件
    //拍照
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self openCamera];
    }];
    [alertVC addAction:actionCamera];
    
    //从相册上传
    UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:@"从相册上传" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self openAlbum];
    }];
    [alertVC addAction:actionAlbum];
    
    //取消
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    [alertVC addAction:actionCancel];
    
    // 模态显示
    [self presentViewController:alertVC animated:YES completion:nil];
}


//打开照相机
- (void)openCamera{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}
//打开系统相册
- (void)openAlbum{
    //如果想自己写一个图片选择控制器 得利用AssetsLibrary.framework,利用这个框架获得手机上的所有相册图片
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.navigationBar.barStyle = UIBarStyleBlack;
    ipc.delegate = self;
    ipc.editing = YES;
    ipc.allowsEditing = YES;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ipc animated:YES completion:nil];
}

// UIImagePickerControllerDelegate
//从控制器选择完图片后就调用(拍照完毕或者选择相册图片完毕)
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //添加图片到photosView中
    self.image.image = image;
    //保存到沙盒上传到云端
    //不会写
}
@end