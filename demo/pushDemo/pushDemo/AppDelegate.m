//
//  AppDelegate.m
//  pushDemo
//
//  Created by litianqi on 2020/7/10.
//  Copyright © 2020 edu24ol. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 添加自定义的categories
    NSSet *categories = [[self class] categories];
    // 创建UIUserNotificationSettings，并设置消息的显示类类型
 
    
    // 注册推送, 只能在主线程中push
    if (@available(iOS 10.0, *)) {
        NSLog(@"ios10+注册通知:UNUserNotificationCenter");
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center setNotificationCategories:nil];
//         [center setNotificationCategories:categories];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                NSLog(@"注册通知:registerForRemoteNotifications");
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    } else {
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categories, nil]];
        NSLog(@"ios9注册通知:registerUserNotificationSettings");
        // Fallback on earlier versions
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *tokenString = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"received device token:%@", tokenString);
}

//- (NSString *)hq_hexString
//{
//    NSUInteger length =  [self length];
//    char *chars =  (char *)[self bytes];
//    NSMutableString *hexString = [[NSMutableString alloc] init];
//    for (NSUInteger  i = 0; i<length ;i++) {
//        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx",chars[i]]];
//    }
//    return hexString.copy;
//}


+ (NSSet *)categories
{
    
    NSMutableSet *categories = [[NSMutableSet alloc] init];
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"category_identifier";
    
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"backgroundAction.identifier";
    action1.title = @"Reject";
    // 点击的时候不启动程序，在后台处理
    action1.activationMode = UIUserNotificationActivationModeBackground;
    // 需要解锁才能处理
    action1.authenticationRequired = YES;
    //YES 显示为红色，NO显示为蓝色
    action1.destructive = YES;
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"foregroundAction.identifier";
    action2.title = @"Accept";
    // 点击的时候启动程序，在前台处理
    action2.activationMode = UIUserNotificationActivationModeForeground;
    //    action2.authenticationRequired = YES;//被忽略
    //YES 显示为红色，NO显示为蓝色
    action1.destructive = NO;
    
    NSArray *actions = @[action1,action2];
    
    [category setActions:actions forContext:UIUserNotificationActionContextDefault];
    
    [categories addObject:category];
    
    return categories;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    /*
     {"aps":{"alert":"Testing.. (18)","content-available":1,"badge":1,"sound":"default"}}
     说明，ios 10+ 后台监控需要 "content-available":1 表明是支持后台监听，否则后台模式下该方法不会触发
     */
    
    NSLog(@"%s",__func__);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
API_AVAILABLE(ios(10.0)){
    
    NSLog(@"%s",__func__);
}

 
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandle
API_AVAILABLE(ios(10.0)){
     NSLog(@"%s",__func__);
}

@end
