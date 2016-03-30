//
//  SHAccountHome.m
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAccountHome.h"
#import "NSObject+NSCoding.h"

@implementation SHAccountHome

//归档 序列化 压缩
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self autoEncodeWithCoder:aCoder];
}

//反归档 反序列化 解压
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    //如果父类实现了initWithCoder方法,此时执行父类的initWithCoder的方法
    self = [super init];
    if (self) {
        [self autoDecode:aDecoder];
    }
    return self;
}

@end
