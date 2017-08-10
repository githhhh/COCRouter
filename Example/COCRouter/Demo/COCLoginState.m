//
//  COCLoginState.m
//  COCRouter
//
//  Created by bin on 2017/7/11.
//  Template From COCXcodePlugin
//  Copyright © 2017年 githhhh. All rights reserved.
//


#import "COCLoginState.h"
#import "LoginViewController.h"
#import "UIViewController+TopViewController.h"
@interface COCLoginState()


@end

@implementation COCLoginState

+ (instancetype)sharedSingleton
{
    static COCLoginState *_sharedSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}


- (id)init
{
    self = [super init];
    if (self) {
        
        _isLogin = NO;
    }
    return self;
}


+(void)needLogin:(void(^)(void))block{
    
    if (![COCLoginState sharedSingleton].isLogin) {
        //登录界面
        LoginViewController*loginVC = [[LoginViewController alloc] init];
        loginVC.logined = block;
        [UIViewController.topMost presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    if (block) {
        block();
    }
}


@end
