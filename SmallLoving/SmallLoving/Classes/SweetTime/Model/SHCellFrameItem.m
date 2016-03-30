//
//  SHCellFrameItem.m
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//
#define kNameFont [UIFont boldSystemFontOfSize:15]
#define kTextFont [UIFont systemFontOfSize:17]
#define kWith  [UIScreen mainScreen].bounds.size.width
#import "SHCellFrameItem.h"
#import "SHSweetSpaceItem.h"
#import "SHImageFrame.h"
@implementation SHCellFrameItem
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    //文字的字体
    NSDictionary *attrs = @{NSFontAttributeName :font};
    // CGSize nameMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    return  [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (void)setSpaceItem:(SHSweetSpaceItem *)spaceItem{
    _spaceItem = spaceItem ;
    //子控件之间的间距
    CGFloat padding = 10 ;
    //1.头像
    CGFloat iconX = padding ;
    CGFloat iconY = padding ;
    CGFloat iconW = 35;
    CGFloat iconH = 35 ;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    //2.昵称
    CGSize nameSize = [self sizeWithText:self.spaceItem.name font:kNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameX = CGRectGetMaxX(_iconF)+padding;
    CGFloat nameY = iconY +(iconH-nameSize.height)*0.5;
    _nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //3.会员图标
    CGFloat vipX = CGRectGetMaxX(_nameF)+padding;
    CGFloat vipY = nameY;
    CGFloat vipW = 20;
    CGFloat vipH =10;
    _vipF =CGRectMake(vipX, vipY, vipW, vipH);
    //4.标题
    CGFloat titleX = iconX;
    CGFloat titleY = CGRectGetMaxY(_iconF)+padding;
    CGSize titleSize = [self sizeWithText:self.spaceItem.titleText font:kNameFont maxSize:CGSizeMake(kWith, 30)];
    _titleF =      CGRectMake(titleX, titleY, kWith, titleSize.height);
    //5.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_titleF)+padding;
    CGSize textSize = [self sizeWithText:self.spaceItem.text font:kTextFont maxSize:CGSizeMake(kWith, MAXFLOAT)];
    _textF = CGRectMake(textX, textY, textSize.width, textSize.height);
    NSLog(@"%f,111%f",textSize.height,textSize.width-100);
    
    //6.配图
    
    if (self.spaceItem.picture) {
        //有配图
        CGFloat pictureX =iconX;
        CGFloat pictureY = CGRectGetMaxY(_textF);
        CGFloat pictureW = [UIScreen mainScreen].bounds.size.width-2*textX ;
        CGFloat pictureH = self.imageFrame.frame.size.height;
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        //7.cell的高度
        // _cellHeight = CGRectGetMaxY(_pictureF)+padding;
        _cellHeight = CGRectGetMaxY(_textF)+self.imageFrame.frame.size.height;
    }else{
        _cellHeight = CGRectGetMaxY(_textF)+padding;
    }
}
@end
