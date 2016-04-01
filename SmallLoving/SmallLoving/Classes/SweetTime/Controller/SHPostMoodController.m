//
//  SHPostMoodController.m
//  Happiness
//
//  Created by lanou3g on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#define CWScreenW  [UIScreen mainScreen].bounds.size.width
#define kY self.view.frame.size.width-40
#import "SHPostMoodController.h"
#import "THEditPhotoView.h"
#import "SHSweetSpaceController.h"
#import "SHPostMood.h"
#import "SHFMDB.h"
#import "SHSweetSpaceItem.h"
#import "SHPostMoodController.h"
@interface SHPostMoodController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,THEditPhotoViewDelegate,UITextViewDelegate>
@property (nonatomic,weak)THEditPhotoView *editPhotoView;
@property (nonatomic,strong)SHPostMood *postMood;
@property (nonatomic,strong)SHSweetSpaceItem *spaceItem;


@end
@interface SHPostMoodController ()


@end

@implementation SHPostMoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postMood = [[SHPostMood alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.postMood ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"书写心情";
    [self layoutView];
    self.postMood.headButton.userInteractionEnabled =YES ;
    self.postMood.textV.delegate = self ;
//    [self layoutViews];
    
    
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array ;
}
- (THEditPhotoView *)editPhotoView{
    if (!_editPhotoView) {
        _editPhotoView = [THEditPhotoView editPhotoView];
        
    }
    return _editPhotoView ;
}
- (void)viewDidAppear:(BOOL)animated{
    [self.postMood.titleField becomeFirstResponder];
}

- (void)layoutView{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:  @selector(cancleBtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:  @selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.postMood.promptTitle.hidden = YES;

    
}




//- (void)layoutViews{
//    THEditPhotoView *editPhotoView = [THEditPhotoView editPhotoView];
//    editPhotoView.frame = CGRectMake(10, 230, CWScreenW, 120);
//    editPhotoView.delegate = self ;
//    self.editPhotoView = editPhotoView ;
//    [self.view addSubview:editPhotoView];
//    //修复文本框是否偏移
//    self.automaticallyAdjustsScrollViewInsets = NO;
//}

- (void)rightBtnClick{
    if(self.postMood.titleField.text.length ==0 &&self.postMood.textV.text.length == 0){
        //弹框显示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"请先输入心情内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            
            [self.postMood.titleField becomeFirstResponder];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"稍后发布" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
            [self.postMood.titleField resignFirstResponder];
            [self.postMood.textV resignFirstResponder];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self showDetailViewController:alert sender:nil];
    }else{
        SHSweetSpaceController *sweetSpace = [[SHSweetSpaceController alloc]init];
        sweetSpace.pictureArr = self.array;
        //block传值
        self.callValue(self.postMood.titleField.text,self.postMood.textV.text,self.array);
        
        NSString *icon = @"hero";
        NSString *name = @"小幸福";
        NSString *vip = @"1";
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        if ([self.postMood.titleField.text isEqualToString:@""]) {
            self.titleString = @"(没有标题)";
            
        }else{
         self.titleString = self.postMood.titleField.text;

        }
        if ([self.postMood.textV.text isEqualToString:@""]) {
            self.textString = @"(没有内容)";
        }else{
            self.textString = self.postMood.textV.text;
        }
        NSString *timestamp = [formatter stringFromDate:date];
        [[SHFMDB sharedSHFMDB]insertSpaceItem:self.spaceItem titleText:self.titleString icon:[NSString stringWithFormat:@"%@",icon] name:[NSString stringWithFormat:@"%@",name] contentText:self.textString dateText:timestamp];
        self.spaceItem.titleText = self.titleString;
        self.spaceItem.text = self.textString ;
        self.spaceItem.icon = icon ;
        self.spaceItem.name = name;
        self.spaceItem.vip = vip;
        [sweetSpace.tableView reloadData];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)cancleBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view resignFirstResponder];
    return YES;
}
/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
#pragma mark - 各种代理方法
//-(void)editPhotoViewToOpenAblum:(THEditPhotoView *)editView{
//    UIImagePickerController *pickView = [[UIImagePickerController alloc]init];
//    pickView.delegate = self;
//    pickView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:pickView animated:YES completion:nil];
//}

//点击图片成功
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
//    
//    [self.editPhotoView addOneImage:image];
//    [self.array addObject:image];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
//点击pickerview的取消，不加图片了
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    
//}

@end
