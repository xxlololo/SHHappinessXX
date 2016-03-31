//
//  SHAccountHome.h
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHAccountHome : NSObject
@property(nonatomic, strong)NSDate *sleepTimeDate;//开始睡觉的时间
@property(nonatomic, strong)NSString  *isSleep;//是否正在睡觉
@property(nonatomic, strong)UIImage *coverImage;//封面图片
@property (nonatomic, strong)NSString *sex;//男女性别
@property (nonatomic, strong)NSDate *lastAuntDate;//上一次姨妈时间
@property (nonatomic, strong)NSString *interval;//姨妈时间间隔
@property (nonatomic, strong) NSString * isMenstruation;//是否正在姨妈期
@property (nonatomic, strong) NSMutableArray *photoArray;//相册数组
@end
