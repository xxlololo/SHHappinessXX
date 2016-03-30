//
//  SHSweetSpaceItem.m
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSweetSpaceItem.h"

@implementation SHSweetSpaceItem

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
   }
    return self;
}
+ (instancetype)spaceWithDic:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
    
}
@end
