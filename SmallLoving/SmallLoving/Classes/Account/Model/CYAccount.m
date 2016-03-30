//
//  CYAccount.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAccount.h"
#import <NSObject+NSCoding.h>

@implementation CYAccount

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        [self autoDecode:coder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self autoEncodeWithCoder:coder];
}


@end
