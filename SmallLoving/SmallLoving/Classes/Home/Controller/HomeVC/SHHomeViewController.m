//
//  SHHomeViewController.m
//  Happiness
//
//  Created by Cheney on 16/3/16.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHHomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SHHomeScrollView.h"
#import "SHCoverImageView.h"
#import "SHExtensionViewController.h"
#import "SHAccountTool.h"
#import "SHAccountHome.h"

@interface SHHomeViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, strong)SHHomeScrollView *homeScrollView;
@property(nonatomic, assign)CGFloat picHeight;
@property(nonatomic, strong)SHAccountHome *accountHome;
@end

@implementation SHHomeViewController

const CGFloat kNavigationBarHeight = 44;
const CGFloat kStatusBarHeight = 20;

- (CGFloat)picHeight{
    if (!_picHeight) {
        _picHeight = self.view.height/2.5;
    }
    return _picHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.homeScrollView = [[SHHomeScrollView alloc] init];
    

    [self.view addSubview:self.homeScrollView];
    
    [self.homeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    [self.homeScrollView.coverImageView.loveTimeBtn addTarget:self action:@selector(loveTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.homeScrollView.coverImageView.cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    SHExtensionViewController *extensionVC = [[SHExtensionViewController alloc] init];
    
    [self addChildViewController:extensionVC];
    [self.homeScrollView.extensionView addSubview:extensionVC.view];
    
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    if (accountHome.coverImage) {
        self.homeScrollView.coverImageView.image = accountHome.coverImage;
    }else{
        self.homeScrollView.coverImageView.image = [UIImage imageNamed:@"9302B515F05E3A5492878E82F5D69EEA"];
    }

    self.accountHome = accountHome;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    self.accountHome = accountHome;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)loveTimeBtnClick:(UIButton *)loveTimeBtn{
    NSLog(@"11111111");
}

- (void)cameraBtnClick:(UIButton *)cameraBtn{
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:@"上传合影" message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    // 添加事件
    //拍照
    CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"拍照" handler:^(UIAlertAction *action) {
        [self openCamera];
    }];
    
    //从相册上传
    CYAlertAction *actionAlbum = [CYAlertAction actionWithTitle:@"从相册上传" handler:^(UIAlertAction *action) {
        [self openAlbum];
    }];
    
    //恢复默认
    CYAlertAction *actionDefault = [CYAlertAction actionWithTitle:@"恢复默认" handler:^(UIAlertAction *action) {
        self.homeScrollView.coverImageView.image = [UIImage imageNamed:@"9302B515F05E3A5492878E82F5D69EEA"];
        self.accountHome.coverImage = self.homeScrollView.coverImageView.image;
        //存储到沙盒
        [SHAccountTool saveAccount:self.accountHome];
    }];
    alertVC.allActions = @[actionCamera,actionAlbum,actionDefault];
}

- (void)openCamera{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            //提示相机不可用
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机不可用" preferredStyle:(UIAlertControllerStyleAlert)];
            // 添加事件
            //拍照
            UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            [alertVC addAction:actionCamera];
            // 模态显示
            [self presentViewController:alertVC animated:YES completion:nil];
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

- (void)openAlbum{
    //如果想自己写一个图片选择控制器 得利用AssetsLibrary.framework,利用这个框架获得手机上的所有相册图片
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.navigationBar.barStyle = UIBarStyleBlack;

    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

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
    self.homeScrollView.coverImageView.image = image;
    self.accountHome.coverImage = image;
    //存储到沙盒
    [SHAccountTool saveAccount:self.accountHome];
}








@end
