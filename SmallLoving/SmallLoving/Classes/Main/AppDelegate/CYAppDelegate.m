//
//  CYAppDelegate.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CYRootTool.h"
#import "AVOSCloudSNS.h"

@implementation CYAppDelegate

/**
 *  程序准备就绪即将运行
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AVOSCloud setApplicationId:@"Ew9cDwywySOU9LJDUGPYBdja-gzGzoHsz"
                      clientKey:@"OI5RnPPOR7HcJyNQEALVj7aO"];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    [CYRootTool setRootViewController];

    //不要删我,我是特别牛逼的3D Touch
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"Title1" localizedTitle:@"强" localizedSubtitle:@"测试中" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"Title2" localizedTitle:@"哥" localizedSubtitle:@"不能点" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
    
    UIApplicationShortcutItem *shortItem3 = [[UIApplicationShortcutItem alloc] initWithType:@"Title3" localizedTitle:@"最" localizedSubtitle:@"别点" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    
    UIApplicationShortcutItem *shortItem4 = [[UIApplicationShortcutItem alloc] initWithType:@"Title4" localizedTitle:@"帅" localizedSubtitle:@"点了啥也没有" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    
    NSArray *shortItems = [[NSArray alloc] initWithObjects:shortItem1, shortItem2,shortItem3,shortItem4, nil];
    NSLog(@"%@", shortItems);
    [[UIApplication sharedApplication] setShortcutItems:shortItems];

    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}

// When Build with IOS 9 SDK
// For application on system below ios 9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}
// For application on system equals or larger ios 9
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [AVOSCloudSNS handleOpenURL:url];
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //3D Touch跳转预留
}
@end
