//
//  SHAlbumViewController.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAlbumViewController.h"
#import "SHPhotoCollectionViewCell.h"
#import "SHAccountTool.h"
#import "SHAlbumToolBarView.h"

#define kWAndH ([UIScreen mainScreen].bounds.size.width - 25) / 4

@interface SHAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * photoArr;
@property (nonatomic, assign) CellState cellState;
@property (nonatomic, strong) SHAlbumToolBarView * toolBarView;
@property (nonatomic, strong) NSMutableArray * selectPhotoArr;

@end

@implementation SHAlbumViewController

- (NSMutableArray *)selectPhotoArr{
    if (!_selectPhotoArr) {
        _selectPhotoArr = [NSMutableArray array];
    }
    return _selectPhotoArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigationBar];
    //设置内容视图
    [self setupContentView];
}

//设置视图
- (void)setupContentView{
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    //添加图片到photoArray中
    self.photoArr = [NSMutableArray arrayWithArray:accountHome.photoArray];
    
    //1.创建对象
    //1.1先创建UICollectionViewFlowLayout对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //1.2配置UICollectionViewFlowLayout的相关属性
    //行间距
    flowLayout.minimumLineSpacing = 5;
    
    //列间距
    flowLayout.minimumInteritemSpacing = 5;
    //每个item的大小
    flowLayout.itemSize = CGSizeMake(kWAndH, kWAndH);
    //设置距屏幕边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
    //滚动方向(默认上下滚动)
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //1.3实例化UICollectionViewFlowLayout并设置flowLayout
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //2.配置属性
    
    //3.添加到父视图
    [self.view addSubview:self.collectionView];
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[SHPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.tabBarController.tabBar.hidden = YES;
    
    //设置工具条
    self.toolBarView = [[SHAlbumToolBarView alloc] initWithFrame:CGRectMake(0, kScreenH-108, kScreenW, 44)];
    [self.view addSubview:self.toolBarView];
    [self.toolBarView.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.toolBarView.hidden = YES;
}

//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"私密相册";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"小幸福"];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//左键返回
- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

//右键管理
- (void)rightItemAction:(UIBarButtonItem *)rightItem{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"管理"]) {
        CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:[NSString stringWithFormat:@"已存储%lu张",(unsigned long)self.photoArr.count] message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
        // 添加事件
        //上传照片
        CYAlertAction *actionPhoto = [CYAlertAction actionWithTitle:@"上传照片" handler:^(UIAlertAction *action) {
            CYAlertController *alertPhotoVC = [CYAlertController showAlertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
            // 添加事件
            //拍照
            CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"拍照" handler:^(UIAlertAction *action) {
                [self openCamera];
            }];
            
            //从相册上传
            CYAlertAction *actionAlbum = [CYAlertAction actionWithTitle:@"从相册上传" handler:^(UIAlertAction *action) {
                [self openAlbum];
            }];
            alertPhotoVC.allActions = @[actionCamera,actionAlbum];
        }];
        
        //编辑
        CYAlertAction *actionEdit = [CYAlertAction actionWithTitle:@"编辑" handler:^(UIAlertAction *action) {
            self.toolBarView.hidden = NO;
            [self.toolBarView.deleteBtn setEnabled:NO];
            
            self.cellState = DeleteState;
            self.navigationItem.rightBarButtonItem.title = @"完成";
            [self.collectionView reloadData];
        }];
        alertVC.allActions = @[actionPhoto,actionEdit];
    } else {
        [self cancelBtnAction:self.toolBarView.cancelBtn];
    }
}

//工具条取消按钮
- (void)cancelBtnAction:(UIButton *)sender{
    [self.selectPhotoArr removeAllObjects];
    self.cellState = NormalState;
    self.toolBarView.hidden = YES;
    [self.collectionView reloadData];
    self.navigationItem.rightBarButtonItem.title = @"管理";
}

//工具条删除按钮
- (void)deleteBtnAction:(UIButton *)sender{
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:@"提示" message:@"确定删除" preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    CYAlertAction *actionYes = [CYAlertAction actionWithTitle:@"确定" handler:^(UIAlertAction *action) {
        for (UIImage *image in self.selectPhotoArr) {
            [self.photoArr removeObject:image];
        }
        [self.selectPhotoArr removeAllObjects];
        [self.toolBarView.deleteBtn setEnabled:NO];
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        accountHome.photoArray = self.photoArr;
        //存入沙盒
        [SHAccountTool saveAccount:accountHome];
        [self.collectionView reloadData];
        if (self.photoArr.count == 0) {
            [self.toolBarView.deleteBtn setEnabled:NO];
        }
        
    }];
    alertVC.allActions = @[actionYes];
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
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    //添加图片到photoArray中
    [self.photoArr addObject:image];
    accountHome.photoArray = self.photoArr;
    [self.collectionView reloadData];
    //存储到沙盒
    [SHAccountTool saveAccount:accountHome];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.photoImageView.image = self.photoArr[indexPath.row];
    if (self.cellState == NormalState) {
        cell.selectBtn.hidden = YES;
    }else{
        cell.selectBtn.hidden = NO;
        [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectBtn.selected = NO;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SHPhotoCollectionViewCell *cell = (SHPhotoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell.selectBtn.hidden) {
        [self selectBtnAction:cell.selectBtn];
    }
    return;
}

- (void)selectBtnAction:(UIButton *)button{
    button.selected = !button.selected;
    UICollectionViewCell *cell = (UICollectionViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    UIImage *image = self.photoArr[indexPath.row];

    if (button.selected) {
        [self.selectPhotoArr addObject:image];
    }else{
        [self.selectPhotoArr removeObject:image];
    }

    if (self.selectPhotoArr.count) {
        [self.toolBarView.deleteBtn setEnabled:YES];
        [self.toolBarView.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",self.selectPhotoArr.count] forState:UIControlStateNormal];
    }else{
        [self.toolBarView.deleteBtn setEnabled:NO];
    }
}

#pragma mark <UICollectionViewDelegate>



@end
