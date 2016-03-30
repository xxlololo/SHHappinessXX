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
- (instancetype)spaceWithTitel:(NSString *)titleText icon:(NSString *)icon name:(NSString *)name text:(NSString *)text{
    
    if (self == [super init]) {
        self.titleText = titleText;
        self.icon = icon ;
        self.name = name ;
        self.text =text ;
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
