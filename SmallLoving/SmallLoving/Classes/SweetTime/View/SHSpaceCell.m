//
//  SHSpaceCell.m
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//
#define kNameFont [UIFont boldSystemFontOfSize:15]
#define kTextFont [UIFont systemFontOfSize:14]
#import "SHSpaceCell.h"
#import "SHSweetSpaceItem.h"
#import "SHCellFrameItem.h"
#import "SHSingleArray.h"
@interface SHSpaceCell()
//1.头像
@property (nonatomic,weak)UIImageView *iconView;
//2.昵称
@property (nonatomic,weak)UILabel *nameView;
//3.会员图标
@property (nonatomic,weak)UIImageView *vipView;
//4.标题
@property (nonatomic,weak)UILabel *titleView;
//5.正文
@property (nonatomic,weak)UILabel *textView;
//6.配图
@property (nonatomic,strong)UIView *pictureView;
@property (nonatomic,strong)SHImageFrame *imageFrame;
@property (nonatomic,strong)SHSingleArray *singleArray;

@end
@implementation SHSpaceCell

//构造方法(在初始化对象的时候被调用)
//一般在这里添加子控件 ,只添加控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.头像
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        //2.昵称
        UILabel *nameView = [[UILabel alloc]init];
        nameView.font = kNameFont;
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        //3.会员图标
        UIImageView *vipView = [[UIImageView alloc]init];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        //4.标题
        UILabel *titleView = [[UILabel alloc]init];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        //5.正文
        UILabel *textView = [[UILabel alloc]init];
        textView.numberOfLines =0;
        textView.font = kTextFont;
        [self.contentView addSubview:textView];
        self.textView = textView ;
        //6.配图
        UIView *imageV = [[UIView alloc]init];
        [self.contentView addSubview:imageV];
        self.pictureView = imageV;
    }
    return self;
}
/**
 *  拿到模型数据,设置子控件的frame和显示数据
 *  重写模型属性的set方法
 */

-(void)setCellItem:(SHCellFrameItem *)cellItem{
    _cellItem = cellItem;
    //1.设置数据
    [self settingData];
    //2.设置frame
    [self settingFrame];
}
+ (instancetype)cellWithTableView:(UITableView*)tableView{
    static NSString *cell_id = @"cell_id";
    SHSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[SHSpaceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    return cell;
}
//设置数据
- (void)settingData{
    SHSweetSpaceItem *spaceItem = self.cellItem.spaceItem;
    //1.头像
    self.iconView.image = [UIImage imageNamed:spaceItem.icon];
    //2.昵称
    self.nameView.text = spaceItem.name;
    //3.会员图标
    if (spaceItem.vip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"vip-icon"];
        self.nameView.textColor = [UIColor redColor];
    }else{
        self.nameView.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    //4.title
    self.titleView.text = spaceItem.titleText;
    //4.正文
    self.textView.text = spaceItem.text;
    //5.配图
    if (spaceItem.picture) {//有配图
        self.pictureView.hidden = NO;
        int totalloc=3;
        CGFloat appvieww=110;
        CGFloat appviewh=120;
        
        CGFloat margin=([UIScreen mainScreen].bounds.size.width-totalloc*appvieww-20)/(totalloc+1);
        self.singleArray = [SHSingleArray shareSHSingArray];
        int count=(int)self.singleArray.singleArr.count;
        for (int i=0; i<count; i++) {
            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row+70;
            
            
            //创建uiview控件
            UIView *appview=[[UIView alloc]initWithFrame:CGRectMake(appviewx, appviewy, appvieww, appviewh)];
            appview.backgroundColor = [UIColor greenColor];
            [self.pictureView addSubview:appview];
            //创建uiview控件中的子视图
            UIImageView *appimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appvieww, appviewh)];
            //  UIImage *appimage=[UIImage imageNamed:self.arr[i]];
            UIImage *appimage = self.singleArray.singleArr[i];
            appimageview.image=appimage;
            [appview addSubview:appimageview];
        }
    }else{
        
        self.pictureView.hidden = YES;
    }
    
}

- (void)settingFrame{
    //1.头像
    self.iconView.frame = self.cellItem.iconF;
    //2.昵称
    self.nameView.frame = self.cellItem.nameF;
    //3.会员图标
    self.vipView.frame =self.cellItem.vipF;
    //4.title
    self.titleView.frame = self.cellItem.titleF;
    //4.正文
    self.textView.frame = self.cellItem.textF;
    //5.配图
    if (self.cellItem.spaceItem.picture) {
        //有配图
        self.pictureView.frame = self.cellItem.pictureF;
        
    }}
@end
