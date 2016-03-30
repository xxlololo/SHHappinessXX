//
//  SHSweetTimeViewController.m
//  Happiness
//
//  Created by Cheney on 16/3/16.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSweetTimeViewController.h"
@interface SHSweetTimeViewController ()
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)UIView *headerView;
@end

@implementation SHSweetTimeViewController
- (NSArray *)data{
    if (_data ==nil) {
        _data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sweetTime.plist" ofType:nil]];
        NSLog(@"%@",_data);
    }
    return  _data;
}
- (id)init{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.data[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    NSDictionary *dict = self.data[indexPath.section][indexPath.row];
    NSLog(@"%@",dict);
    //  cell.imageView.image = dict[@"icon"];
    cell.textLabel.text = dict[@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryView =self.beginBtn;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.data[indexPath.section][indexPath.row];
    NSString *classStr = dict[@"vcClass"];
    Class c = NSClassFromString(classStr);
    UIViewController *vc = [[c alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
