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
#import "SHMemorialModel.h"
#import <UIImageView+WebCache.h>
#import "SHImageTool.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import <MJExtension.h>

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
    SHImageModel *imageModel = [SHImageTool imageModel];
    if (imageModel.coverImage) {
        self.homeScrollView.coverImageView.image = imageModel.coverImage;
    }else{
        if (accountHome.coverImageUrl) {
            [self.homeScrollView.coverImageView sd_setImageWithURL:[NSURL URLWithString:accountHome.coverImageUrl] placeholderImage:[UIImage imageNamed:@"9302B515F05E3A5492878E82F5D69EEA"]];
            imageModel.coverImage = self.homeScrollView.coverImageView.image;
            [SHImageTool saveImageModel:imageModel];
        }else{
            self.homeScrollView.coverImageView.image = [UIImage imageNamed:@"9302B515F05E3A5492878E82F5D69EEA"];
        }
    }

    self.accountHome = accountHome;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    self.accountHome = accountHome;
    long day = 0;
    if (accountHome.memorialArray) {
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";

        SHMemorialModel *memorialModel = accountHome.memorialArray[0];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[formatter dateFromString:memorialModel.memorialDate]];
        day = (int)(timeInterval/86400);
    }
    [self.homeScrollView.coverImageView.loveTimeBtn setTitle:[NSString stringWithFormat:@"我们已相爱%ld天",day] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)loveTimeBtnClick:(UIButton *)loveTimeBtn{
    
}

- (void)cameraBtnClick:(UIButton *)cameraBtn{
    __weak typeof(self) weakSelf = self;
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:@"上传合影" message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    // 添加事件
    //拍照
    CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"拍照" handler:^(UIAlertAction *action) {
        [weakSelf openCamera];
    }];
    
    //从相册上传
    CYAlertAction *actionAlbum = [CYAlertAction actionWithTitle:@"从相册上传" handler:^(UIAlertAction *action) {
        [weakSelf openAlbum];
    }];
    
    //恢复默认
    CYAlertAction *actionDefault = [CYAlertAction actionWithTitle:@"恢复默认" handler:^(UIAlertAction *action) {
        weakSelf.homeScrollView.coverImageView.image = [UIImage imageNamed:@"9302B515F05E3A5492878E82F5D69EEA"];
        weakSelf.accountHome.coverImageUrl = nil;
        SHImageModel *imageMode = [SHImageTool imageModel];
        imageMode.coverImage = nil;
        [SHImageTool saveImageModel:imageMode];
        
        //存储到沙盒
        CYAccount *cyAccount = [CYAccountTool account];
        //上传到云端
        if (cyAccount.accountHomeObjID) {
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
            [accountAV setObject:weakSelf.accountHome.mj_keyValues forKey:@"accountHome"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储封面成功");
                    //存储到沙盒
                    [SHAccountTool saveAccount:weakSelf.accountHome];
                }
            }];
        }
        [SHAccountTool saveAccount:weakSelf.accountHome];
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
    
    //存储图片在本地沙盒中
    SHImageModel *imageModel = [SHImageTool imageModel];
    imageModel.coverImage = image;
    CYAccount *cyAccount = [CYAccountTool account];
    __weak typeof(self) weakSelf = self;
    //保存到沙盒上传到云端
    if (cyAccount.accountHomeObjID) {
        NSData *imageData = UIImagePNGRepresentation(image);
        AVFile *file = [AVFile fileWithName:@"coverImage.png" data:imageData];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                weakSelf.accountHome.coverImageUrl = file.url;
            //上传到云端
                AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
                [accountAV setObject:weakSelf.accountHome.mj_keyValues forKey:@"accountHome"];
                [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        //存储到本地
                        CYLog(@"存储封面图片成功");
                        [SHImageTool saveImageModel:imageModel];
                        [SHAccountTool saveAccount:weakSelf.accountHome];
                    }
                }];
        }
    }];
    }
    [SHImageTool saveImageModel:imageModel];
    [SHAccountTool saveAccount:weakSelf.accountHome];
}








@end
