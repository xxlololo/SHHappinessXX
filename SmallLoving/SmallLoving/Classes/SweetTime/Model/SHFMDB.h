//
//  SHFMDB.h
//  SmallLoving
//
//  Created by lanou3g on 16/3/25.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHSweetSpaceItem ,FMDatabase;
@interface SHFMDB : NSObject
@property (nonatomic, strong) FMDatabase *queue;
@property (nonatomic,strong)FMDatabase *db;
#pragma mark ----------单例实例方法----------
+ (SHFMDB *)sharedSHFMDB;

#pragma mark ----------打开数据库------------
- (void)openFMDB;

#pragma mark ----------添加数据-------------
- (void)insertSpaceItem:(SHSweetSpaceItem *)spaceItem titleText:(NSString *)titleText icon:(NSString *)icon name:(NSString *)name contentText:(NSString*)contentText;

#pragma mark ----------查询数据-------------
- (NSArray *)selectAllSpaceItem;

#pragma  mark ---------删除数据
- (void)delete;
- (void)deleteWithTitle:(NSString *)titleStr context:(NSString *)contextStr;

@end
