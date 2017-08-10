//
//  UIViewController+DeallocLog.m
//  COCRouter
//
//  Created by bin on 2017/7/14.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "UIViewController+DeallocLog.h"
#import <objc/runtime.h>

@implementation UIViewController (DeallocLog)

+ (void)load{
    
    [self swizzleInstanceSelector:NSSelectorFromString(@"dealloc") withNewSelector:@selector(log_dealloc)];
    
}


- (void)log_dealloc{
    
    NSLog(@"%@~~~~dealloc",self);
    
    [self log_dealloc];
}



+ (void) swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}


@end
