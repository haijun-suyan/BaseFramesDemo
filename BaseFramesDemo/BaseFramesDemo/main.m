//
//  main.m
//  BaseFramesDemo
//
//  Created by haijunyan on 2020/12/20.
//  Copyright © 2020 haijunyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {//自动释放
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil,appDelegateClassName);
}
