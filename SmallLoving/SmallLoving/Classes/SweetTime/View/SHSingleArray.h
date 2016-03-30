//
//  SHSingleArray.h
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHSingleArray : NSObject
@property (nonatomic,strong)NSMutableArray *singleArr;

+ (SHSingleArray *)shareSHSingArray;

@end
