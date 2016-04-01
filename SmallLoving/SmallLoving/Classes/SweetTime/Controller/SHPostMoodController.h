//
//  SHPostMoodController.h
//  Happiness
//
//  Created by lanou3g on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

//1.定义一个blocK类型
typedef void(^CallValue)(NSString *,NSString *,NSMutableArray *);
@interface SHPostMoodController : UIViewController<UITextViewDelegate>{
    UILabel *_placeholderLabel;
}
@property (nonatomic,copy)CallValue callValue;

@property (nonatomic,strong)NSMutableArray *array ;

@property (nonatomic,strong)UITextField *titleField;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel *textLabel;

@property (nonatomic,strong)NSString *titleString;
@property (nonatomic,strong)NSString *textString;
@end
