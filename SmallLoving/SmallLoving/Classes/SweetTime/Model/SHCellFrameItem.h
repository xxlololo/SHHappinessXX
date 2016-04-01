//
//  SHCellFrameItem.h
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//一个cell拥有一个frame模型

#import <Foundation/Foundation.h>
@class SHSweetSpaceItem,SHImageFrame;
@interface SHCellFrameItem : NSObject
/**
 *  头像的frame
 */
@property (nonatomic,assign,readonly)CGRect iconF;
/**
 *  昵称的frame
 */
@property (nonatomic,assign,readonly)CGRect nameF;
/**
 *  会员图标的frame
 */
@property (nonatomic,assign,readonly)CGRect vipF;
/**
 *  心情标题
 */
@property (nonatomic,assign,readonly)CGRect titleF;
/**
 *  正文的frame
 */
@property (nonatomic,assign,readonly)CGRect textF;
/**
 *  配图的frame
 */
@property (nonatomic,assign,readonly)CGRect pictureF;
/**
 *  date显示
 */
@property (nonatomic,assign,readonly)CGRect  dataF;
/**
 *  cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat cellHeight;
/**
 *  cell之间的分割线
 */
@property (nonatomic,assign,readonly)CGRect cellView;
@property (nonatomic,strong)SHSweetSpaceItem *spaceItem;
@property (nonatomic,strong)SHImageFrame *imageFrame;
@end
