//
//  UIViewController+TopViewController.m
//  COCRouter
//
//  Created by bin on 2017/6/22.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "UIViewController+TopViewController.h"

@implementation UIViewController (TopViewController)

+ (UIViewController *)topMost{
    UIViewController* rootViewController = nil;
    NSArray* currentWindows = UIApplication.sharedApplication.windows;

    for (UIWindow *window in currentWindows) {
        if (window.rootViewController) {
            rootViewController = window.rootViewController;
            break;
        }
    }
    return [self iterationVC:rootViewController];
}


+ (UIViewController *)iterationVC:(UIViewController *)viewController{
    
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        
        UIViewController *seletedVC = [(UITabBarController *)viewController selectedViewController];
        
        return [self iterationVC:seletedVC];
    }
    
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        UIViewController *visibleVC = [(UINavigationController *)viewController visibleViewController];
        
        return [self iterationVC:visibleVC];
    }

    if (viewController.presentedViewController) {
        
        return [self iterationVC:viewController.presentedViewController];
    }

    for (UIView *subView in [viewController.view subviews]) {
        if ([subView.nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *childVC = (UIViewController *)subView.nextResponder;
            return [self iterationVC:childVC];
        }
    }
    
    return viewController;
}


@end
