//
//  COCRouter.h
//  COCRouter
//
//  Created by bin on 2017/6/14.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COCRoutingContext.h"

//响应类型
typedef NS_ENUM(NSInteger, COCRouterMode) {
    
    COCRouterModeSuccess = 200,
    
    /**
     *  NSURL 解析失败
     */
    COCRouterModeUrlParseFailed = 400,
    
    /**
     *  无法获取路由数据
     */
    COCRouterModeRouteNotFound,
    
    /**
     *  找不到响应实现
     */
    COCRouterModeHandlerNotFound,
    
    /**
     *  调用错误
     */
    COCRouterModeInvocationModuleError,
};


typedef void(^COCRoutingSuccess)(COCRoutingContext* context);
typedef void(^COCRoutingFailed)(COCRouterMode mode);


@interface COCRouter : NSObject

/*! 注册过滤器需要符合COCRoutingFilterProtocol 协议*/
+(void)registerFilterClass:(Class)filterHandler;

/*! 转发模块*/
+ (void)forwardModule:(NSURL *)url  complete:(void(^)(COCRouterMode))complete;

/*! 转发模块: 传递自定义参数 必须要和模块控制器Action参数一致*/
+ (void)forwardModule:(NSURL *)url args:(NSArray *)args complete:(void(^)(COCRouterMode))complete;

/*! 从路由扩展 传入约定Selector 到模块控制器,无需配置文件*/
+ (void)forwardModule:(NSURL *)url convention:(SEL)aSelector args:(NSArray *)args complete:(void(^)(COCRouterMode))complete;

@end


