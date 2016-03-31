//
//  SHSweetSpaceController.m
//  Happiness
//
//  Created by lanou3g on 16/3/17.
//  Copyright © 2016年 Cheney. All rights reserved.


#import "SHSweetSpaceController.h"
#import "SHSweetSpaceItem.h"
#import "SHSpaceCell.h"
#import "SHCellFrameItem.h"
#import "THEditPhotoView.h"
#import "SHPostMoodController.h"
#import "SHImageFrame.h"
#import "SHSingleArray.h"
#import "SHFMDB.h"
#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SHSweetSpaceController ()<UITableViewDelegate, UITableViewDataSource>

/**
 
 *  存放所有cell的frame
 */
@property (nonatomic,strong)NSMutableArray *frameArr;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (nonatomic,strong)THEditPhotoView *editPhotoView;
@property (nonatomic,strong)SHImageFrame *imageFrame ;
@property (nonatomic,strong)SHSingleArray *singleArray;
@property (nonatomic,strong)SHSweetSpaceItem *spaceItem;
@end

@implementation SHSweetSpaceController
- (NSMutableArray *)pictureArr{
    if (!_pictureArr) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr ;
}
- (NSMutableArray *)frameArr{
    if (!_frameArr) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    self.singleArray = [SHSingleArray shareSHSingArray];
    [[SHFMDB sharedSHFMDB]openFMDB];
    UIView *llview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    //背景图片
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 220)];
    self.headerImageView.image = [UIImage imageNamed:@"image1.png"];
    
    //去掉背景图片
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIView *contentView = [[UIView alloc]initWithFrame:self.headerImageView.bounds];
    self.headerImageView.center = contentView.center ;
    contentView.layer.masksToBounds = YES ;
    self.headerContentView = contentView;
    //添加背景view
    //    CGRect backView_frame = CGRectMake(0, -20, kScreenWith, 64);
    //    UIView *backView = [[UIView alloc] initWithFrame:backView_frame];
    //    UIColor *backColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.4 alpha:0];
    //    backView.backgroundColor = [backColor colorWithAlphaComponent:0.3];
    //    [self.navigationController.navigationBar addSubview:backView];
    //    self.backView = backView;
    //    self.backColor = backColor;
    
    //信息内容
    CGRect icon_frame = CGRectMake([UIScreen mainScreen].bounds.size.width-72, self.headerContentView.bounds.size.height-30, 60, 60);

    UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
    icon.backgroundColor = [UIColor clearColor];
    icon.image = [UIImage imageNamed:@"game.png"];
   // icon.layer.cornerRadius = 80/2.0f;
    icon.layer.masksToBounds = YES;
    icon.layer.borderWidth = 1.0f;
    icon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.headerContentView addSubview:self.headerImageView];
   // [self.headerContentView addSubview:icon];
    self.icon = icon;
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(108, self.headerContentView.bounds.size.height-60-12, kScreenWith-108-12, 50)];
//    label.text = @"真羡慕你们这些人, 年纪轻轻的就认识了才华横溢的我!";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:15];
//    label.numberOfLines = 0;
//    self.label = label;
//    [self.headerContentView addSubview:self.label];
    [llview addSubview:self.headerContentView];
    self.tableView.tableHeaderView = llview;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.navigationController.navigationBar.translucent = NO;
    //雪花效果
    //    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleAction:)];
    //
    //    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 40)/300.0f;
    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    
    if (offset_Y <0) {
        //放大比例
        CGFloat add_topHeight = -offset_Y;
        self.scale = (220+add_topHeight)/220;
        //改变 frame
        CGRect contentView_frame = CGRectMake(0, -add_topHeight, kScreenWith, 220+add_topHeight);
        self.headerContentView.frame = contentView_frame;
        CGRect imageView_frame = CGRectMake(0,
                                            0,
                                            kScreenWith,
                                            220+add_topHeight);
        self.headerImageView.frame = imageView_frame;
        
        CGRect icon_frame = CGRectMake(12, self.headerContentView.bounds.size.height-30, 60, 60);
        self.icon.frame = icon_frame;
        
        
    }
    
}

- (void)layoutViews{
    
    self.navigationItem.title = @"情侣空间";
    self.tabBarController.tabBar.hidden = YES ;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    [self.tableView reloadData];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布心情" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem ;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem ;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
    self.imageFrame.arr = self.pictureArr;
    [self.tableView reloadData];
    
}
//删除说说的方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//改变删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除说说";
}
//删除用到的函数
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.frameArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //        [[SHFMDB sharedSHFMDB]deleteWithTitle:self.frameArr[indexPath].cellFrame.cellItem.titleCopy context:self.frameArr[indexPath].cellFrame.cellItem.textCopy];
        //
    }
}

- (void)rightItemAction{
    //获取数据
    SHPostMoodController *postMood = [[SHPostMoodController alloc]init];
    
    __weak typeof(self) weakSelf = self;
    //给block属性 赋值
    postMood.callValue = ^(NSString *titleCopy, NSString *textCopy,NSMutableArray *array){
        weakSelf.titleCopy =titleCopy;
        weakSelf.textCopy = textCopy;
        weakSelf.pictureArr = array ;
        self.singleArray.singleArr = array;
        //创建SHCellframe模型
        SHCellFrameItem *cellFrame = [[SHCellFrameItem alloc]init];
        cellFrame.spaceItem = self.spaceItem;
        [self.frameArr addObject:cellFrame];
        //3.2添加模型对象到数组
    };
    [self.navigationController pushViewController:postMood animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //初始化
    NSArray *array =[[SHFMDB sharedSHFMDB]selectAllSpaceItem];
    NSLog(@"第一次获取数据%@",array);
    //3.将dictArray 里面的所有字典转换成模型,加到新的数组中
    NSMutableArray *arr = [NSMutableArray array];
    for (SHSweetSpaceItem *spaceItem in array) {
        //3.1创建模型对象
        //创建SHCellframe模型
        SHCellFrameItem *cellFrame = [[SHCellFrameItem alloc]init];
        cellFrame.spaceItem = spaceItem;
        //3.2添加模型对象到数组
        [arr addObject:cellFrame];
    }
    //4.赋值
    self.frameArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}
- (void)leftItemAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.frameArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    SHSpaceCell *cell = [SHSpaceCell cellWithTableView:tableView];
    //2.在这个方法中算出cell的高度
    //必须的
    cell.backgroundColor = [UIColor colorWithRed:(255)
                                           green:(255)  blue:(255) alpha:.4];
    
    cell.cellItem  = self.frameArr[indexPath.row];
    cell.selected = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //3.返回cell
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算高度
    //取出这行对应的frame模型
    SHCellFrameItem *cellFrame = self.frameArr[indexPath.row];
    return cellFrame.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
/**
 *  获取雪花特效
 */
/**
 *
 *- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 [self.displayLink invalidate];
 self.displayLink = nil;
 }
 - (void)handleAction:(CADisplayLink *)displayLink{
 
 UIImage *image = [UIImage imageNamed:@"heart"];
 UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
 CGFloat scale = arc4random_uniform(60) / 100.0;
 imageView.transform = CGAffineTransformMakeScale(scale, scale);
 CGSize winSize = self.view.bounds.size;
 CGFloat x = arc4random_uniform(winSize.width);
 CGFloat y = - imageView.frame.size.height;
 imageView.center = CGPointMake(x, y);
 
 [self.view addSubview:imageView];
 [UIView animateWithDuration:arc4random_uniform(10) animations:^{
 CGFloat toX = arc4random_uniform(winSize.width);
 CGFloat toY = imageView.frame.size.height * 0.5 + winSize.height;
 
 imageView.center = CGPointMake(toX, toY);
 imageView.transform = CGAffineTransformRotate(imageView.transform, arc4random_uniform(M_PI * 2));
 
 imageView.alpha = 0.5;
 } completion:^(BOOL finished) {
 [imageView removeFromSuperview];
 }];
 
 
 }
 
 */
@end
