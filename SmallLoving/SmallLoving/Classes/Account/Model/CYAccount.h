//
//  CYAccount.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYAccount : NSObject <NSCoding>

/**
 *  账号
 */
@property (nonatomic, strong) NSString * userName;

/**
 *  手机号
 */
@property (nonatomic, strong) NSString * number;

/**
 *  密码
 */
 @property (nonatomic, strong) NSString * password;

/**
 *  邮箱
 */
@property (nonatomic, strong) NSString * mail;

@end
