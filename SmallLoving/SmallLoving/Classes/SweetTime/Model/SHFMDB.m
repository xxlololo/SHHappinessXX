//
//  SHFMDB.m
//  SmallLoving
//
//  Created by lanou3g on 16/3/25.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHFMDB.h"
#import "FMDB.h"
#import "SHSweetSpaceItem.h"
@implementation SHFMDB
#pragma mark ----------单例实例方法----------
+ (SHFMDB *)sharedSHFMDB{
    static SHFMDB *fmdb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdb = [SHFMDB new];
    });
    return fmdb ;
    
}

#pragma mark ----------打开数据库------------
- (void)openFMDB{
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"spacemood.sqlite"];
    NSLog(@"%@",[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"spacemood.sqlite"]);
    // 1.创建数据库队列
    self.queue = [FMDatabase databaseWithPath:filename];
    [self.queue open];
    // 2.创表
    BOOL result = [self.queue executeUpdate:@"create table if not exists t_spacemood(id integer primary key autoincrement,titletext text,icon text,name text,contenttext text);"];
    BOOL result2 = [self.queue executeUpdate:@"create table if not exists t_images (id integer primary key autoincrement , image text)"];
    if (result&&result2) {
        NSLog(@"创表成功");
    } else {
        NSLog(@"创表失败");
    }
}

//#pragma mark ----------添加数据-------------
- (void)insertSpaceItem:(SHSweetSpaceItem *)spaceItem titleText:(NSString *)titleText icon:(NSString *)icon name:(NSString *)name contentText:(NSString *)contentText{
    NSString *titleStr = [NSString stringWithFormat:@"%@",titleText];
    NSString *textStr = [NSString stringWithFormat:@"%@",contentText];
    NSString *iconStr = [NSString stringWithFormat:@"%@",icon];
    NSString *nameStr = [NSString stringWithFormat:@"%@",name];
    [self.queue executeUpdate:@"insert into t_spacemood(titletext,icon,name,contenttext) values (?,?,?,?);",titleStr,iconStr,nameStr,textStr];
    // 根据对应的模型遍历数组内的对象并创建数据
//    for (int i = 0; i < spaceItem.picArr.count; i ++ ) {
//        [_db executeUpdateWithFormat:@"INSERT INTO t_images (image) values (%@)",spaceItem.picArr[i]];
//    }
}

#pragma mark ----------查询数据-------------
- (NSArray *)selectAllSpaceItem{
    NSMutableArray *array = [NSMutableArray array];
  //1.查询数据
    [self openFMDB];
    FMResultSet *rs = [self.queue executeQuery:@"select * from t_spacemood"];
    //2.遍历结果集
    while (rs.next) {
        NSString *titleText = [rs stringForColumn:@"titletext"];
        NSString *text = [rs stringForColumn:@"contenttext"];
        NSString *icon = [rs stringForColumn:@"icon"];
        NSString *name = [rs stringForColumn:@"name"];
   
        SHSweetSpaceItem *spaceItem =[[SHSweetSpaceItem alloc]spaceWithTitel:titleText icon:icon name:name text:text];
        [array addObject:spaceItem];
        NSLog(@"%@",array);
    }
     return array;
}

- (void)delete{
   [self.queue executeQuery:@"delete from t_spacemood"];
}
//删除某一行
- (void)deleteWithTitle:(NSString *)titleStr context:(NSString *)contextStr{
    if ([self.queue open]) {
        [self.queue executeQuery:@"delete from t_spacemood where titletext='%@',contenttext='%@';",titleStr,contextStr];
    }
    
}

@end
