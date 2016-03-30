//
//  SHSweetSpaceController.h
//  Happiness
//
//  Created by lanou3g on 16/3/17.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSweetSpaceController : UITableViewController
@property (nonatomic,assign) CGFloat num;
@property (nonatomic,assign)CGFloat cellHeigh;
@property (nonatomic,strong)NSString  *titleCopy;
@property (nonatomic,strong)NSString *textCopy;
@property (nonatomic,strong)NSMutableArray *pictureArr;
@end
