//
//  SHSpaceCell.h
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHCellFrameItem;
@interface SHSpaceCell : UITableViewCell
@property (nonatomic,strong)SHCellFrameItem *cellItem;
+ (instancetype)cellWithTableView:(UITableView*)tableView;
@end
