//
//  SHImageFrame.m
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHImageFrame.h"
#import "SHSingleArray.h"
@implementation SHImageFrame

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)loadViews{
    int totalloc=3;
    CGFloat appvieww=120;
    CGFloat appviewh=120;
    
    CGFloat margin=(self.frame.size.width-totalloc*appvieww)/(totalloc+1);
    int count=(int)self.arr.count;
    for (int i=0; i<count; i++) {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row+70;
        
        
        //创建uiview控件
        UIView *appview=[[UIView alloc]initWithFrame:CGRectMake(appviewx, appviewy, appvieww, appviewh)];
        appview.backgroundColor = [UIColor greenColor];
        [self addSubview:appview];
        //创建uiview控件中的子视图
        UIImageView *appimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appvieww, appviewh)];
        self.singleArray = [SHSingleArray shareSHSingArray];
        UIImage *appimage = self.singleArray.singleArr[i];
        appimageview.image=appimage;
        [appview addSubview:appimageview];
        
    }
    
}
@end
