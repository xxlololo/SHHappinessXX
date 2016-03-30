//
//  SHSingleArray.m
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSingleArray.h"

@implementation SHSingleArray
+(SHSingleArray *)shareSHSingArray{
    static SHSingleArray *singleArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleArray = [SHSingleArray new];
    });
    return singleArray;
}


@end
