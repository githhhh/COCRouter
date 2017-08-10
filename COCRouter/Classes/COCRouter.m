//
//  COCRouter.m
//  COCRouter
//
//  Created by bin on 2017/6/14.
//  Copyright © 2017年 githhhh. All rights reserved.
//  Template From COCXcodePlugin
//

#import "COCRouter.h"
#import "COCRoutingCache.h"
#import "COCRoutingPipeline.h"
#import "COCRoutingFilter.h"
#import "COCRoutingFilterProtocol.h"

@implementation COCRouter

+(void)registerFilterClass:(Class)filterHandler{

    NSAssert([filterHandler conformsToProtocol:@protocol(COCRoutingFilterProtocol)], @"class %@ does not conform to protocol: %@", filterHandler, @protocol(COCRoutingFilterProtocol));

    COCRoutingCache.shareCache.exceptionHandlerClass = filterHandler;
}

#pragma mark -  转发到模块控制器

+ (void)forwardModule:(NSURL *)url args:(NSArray *)args complete:(void(^)(COCRouterMode))complete{
    
    [self forwardModule:url convention:NULL args:args complete:complete];
}

+ (void)forwardModule:(NSURL *)url  complete:(void(^)(COCRouterMode))complete{
    NSParameterAssert(url);
    
    COCRoutingPipeline *pipeline = [COCRoutingPipeline createPipelineWith:url];
    pipeline.routingType = COCForwardModule;
    pipeline.isInvocationResponder = YES;
    [pipeline startWithSuccess:^(COCRoutingContext *context) {
        
        if (complete) {
            complete(COCRouterModeSuccess);
        }
        
    } failure:^(COCRouterMode mode) {
        if (complete) {
            complete(mode);
        }
        
        //转发错误
        [COCRoutingFilter forwardRoutingExceptionSource:url state:mode];
    }];
}

#pragma mark - 从路由扩展 与 模块控制器约定 Selector

+ (void)forwardModule:(NSURL *)url
           convention:(SEL)aSelector
              success:(COCRoutingSuccess)success
              failure:(COCRoutingFailed)failure{
    NSParameterAssert(url);
    
    COCRoutingPipeline *pipeline = [COCRoutingPipeline createPipelineWith:url];
    pipeline.routingType = COCForwardModule;
    pipeline.conventionSelector = aSelector;
    [pipeline startWithSuccess:success failure:failure];
}

+ (void)forwardModule:(NSURL *)url
           convention:(SEL)aSelector
                 args:(NSArray *)args
             complete:(void(^)(COCRouterMode))complete{
    NSParameterAssert(url);

    //转发
    [COCRouter forwardModule:url
                 convention:aSelector success:^(COCRoutingContext *context) {
        
        //响应
        [COCResponderWare respondeRouting:context
                                    args:args
                                 success:^{
                                     if (complete) {
                                         complete(COCRouterModeSuccess);
                                     }
                                 }
                                 failure:^(COCRouterMode mode) {
                                     if (complete) {
                                         complete(mode);
                                     }
                                     //响应错误
                                     [COCRoutingFilter forwardRoutingExceptionSource:url state:mode];
                                 }];
        
    } failure:^(COCRouterMode mode) {
        if (complete) {
            complete(mode);
        }
        //转发错误
        [COCRoutingFilter forwardRoutingExceptionSource:url state:mode];
    }];
}

#pragma mark -

+ (void)forwardModule:(NSURL *)url success:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure{
    
    [self forwardModule:url convention:NULL success:success failure:failure];
}

@end
