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
@interface SHSweetSpaceController ()
//@property (nonatomic,strong)NSArray *space;
/**
 
 *  存放所有cell的frame
 */
@property (nonatomic,strong)NSArray *frameArr;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (nonatomic,strong)THEditPhotoView *editPhotoView;
@property (nonatomic,strong)SHImageFrame *imageFrame ;
@property (nonatomic,strong)SHSingleArray *singleArray;
@end

@implementation SHSweetSpaceController
- (NSMutableArray *)pictureArr{
    if (!_pictureArr) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    self.singleArray = [SHSingleArray shareSHSingArray];
    //雪花效果
    //    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleAction:)];
    //
    //    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.tableView reloadData];
}
- (void)layoutViews{
    
    self.navigationItem.title = @"情侣空间";
    self.tabBarController.tabBar.hidden = YES ;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lover.png"]];
    [self.tableView setBackgroundView:imageView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    [self.tableView reloadData];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布心情" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem ;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem ;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES ;
    self.imageFrame.arr = self.pictureArr;
    NSLog(@"*********%@",self.singleArray.singleArr);
    [self frameArr];
    [self.tableView reloadData];
}
- (void)rightItemAction{
    //获取数据
    SHPostMoodController *postMood = [[SHPostMoodController alloc]init];
    __weak typeof(self) weakSelf = self ;
    //给block属性 赋值
    postMood.callValue = ^(NSString *titleCopy, NSString *textCopy,NSMutableArray *array){
        weakSelf.titleCopy =titleCopy;
        weakSelf.textCopy = textCopy;
        weakSelf.pictureArr = array ;
        self.singleArray.singleArr = array;
        
    };
    [self.navigationController pushViewController:postMood animated:YES];
    
}
- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
        
    }
    return self;
    
}
//获取数据
- (NSArray *)frameArr{
    NSLog(@"%@----%@",self.titleCopy,self.textCopy);
    NSLog(@"self.pictureArr--->%@",self.pictureArr);
    
    if (_frameArr == nil) {
        //初始化
        //1.获得plist的全路径
        NSString *path = [[NSBundle mainBundle]pathForResource:@"space.plist" ofType:nil];
        //2.加载数组
        NSMutableArray *dictArray = [NSMutableArray arrayWithContentsOfFile:path];
        NSArray *arrayKey = @[@"titleText",@"text",@"icon",@"name",@"vip",@"picture"];
        NSArray *arrayValue = @[@"猩猿崛起2",@"猩球崛起是一部很值得看的大片,建议大家有时间的话都去看看,好电影值得欣赏!",@"bier",@"我是流氓我怕谁",@"0",self.pictureArr];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:arrayValue forKeys:arrayKey];
        [dictArray addObject:dic];
        //3.将dictArray 里面的所有字典转换成模型,加到新的数组中
        NSMutableArray *arr = [NSMutableArray array ];
        for (NSDictionary *dict in dictArray) {
            //3.1创建模型对象
            NSLog(@"%@",dict);
            SHSweetSpaceItem *spaceItem = [SHSweetSpaceItem spaceWithDic:dict];
            //创建SHCellframe模型
            SHCellFrameItem *cellFrame = [[SHCellFrameItem alloc]init];
            cellFrame.spaceItem = spaceItem;
            //3.2添加模型对象到数组
            [arr addObject:cellFrame];
        }
        //4.赋值
        _frameArr = arr;
    }
    return _frameArr;
    
    
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
                                           green:(255)  blue:(255) alpha:.7];
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
    return 200;
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
 
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */

@end
