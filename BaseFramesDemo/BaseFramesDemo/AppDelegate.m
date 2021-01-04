//  Xcode11前:项目工程中只存在AppDelegate类/不存在SceneDelegate类(只走AppDelegate中)
//  Xcode11后:项目工程中存在AppDelegate类文件/存在SceneDelegate类文件(先走AppDelegate然后走SceneDelegate)
//  AppDelegate.m
//  BaseFramesDemo
//
//  Created by haijunyan on 2020/12/20.
//  Copyright © 2020 haijunyan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+DataCollection.h"
#import "CustomViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Xcode11前生效
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *vC = [[CustomViewController alloc] init];
    self.window.rootViewController = vC;
    //window核心化可见
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
