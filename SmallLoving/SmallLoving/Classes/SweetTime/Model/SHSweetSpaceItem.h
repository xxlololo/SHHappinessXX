//
//  SHSweetSpaceItem.h
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHSweetSpaceItem : NSObject
//状态内容
@property (nonatomic,strong)NSString *text;
//用户头像
@property (nonatomic,strong)NSString *icon;
//用户昵称
@property (nonatomic,strong)NSString *name;
//正文标题
@property (nonatomic,strong)NSString *titleText;
//图文
@property (nonatomic,strong)NSString *picture;
//是否是vip
@property (nonatomic,assign)BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)spaceWithDic:(NSDictionary *)dict;
- (instancetype)spaceWithTitel:(NSString *)titleText icon:(NSString *)icon name:(NSString *)name text:(NSString *)text;
@end
