//
//  COCRoutingFilter.m
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingFilter.h"
#import "COCRoutingCache.h"

@implementation COCRoutingFilter

-(void)startWithSuccess:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure{
    
    if (self.isInvocationResponder) {
        [super startWithSuccess:success failure:failure];
        return ;
    }
    
    if(success){
        success(self.context);
    }
}


#pragma mark - Filter Message Forwading

+(void)forwardRoutingExceptionSource:(NSURL *)url state:(COCRouterMode)state{
    if (!COCRoutingCache.shareCache.exceptionHandlerClass) {
        return;
    }
    
    [[COCRoutingFilter alloc] routingExceptionSource:url state:state];
}


#pragma mark - NSProxy Override

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    id handler = [[COCRoutingCache.shareCache.exceptionHandlerClass alloc] init];
    
    if ([handler respondsToSelector:aSelector]) {
        return [handler methodSignatureForSelector:aSelector];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    
    id handler = [[COCRoutingCache.shareCache.exceptionHandlerClass alloc] init];
    
    if ([handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
        return;
    }
    
    [super forwardInvocation:invocation];
}

@end
