//
//  COCRoutingCache.h
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COCRoutingCache : NSObject

@property (strong, nonatomic) Class exceptionHandlerClass;

/*! 路由缓存 键值对{regularExpr:target}*/
@property (strong, nonatomic) NSMutableDictionary *routedCache;

/*! plist文件的缓存、可回收*/
@property (strong, nonatomic) NSMutableDictionary *routConfigCache;

/*! url、viewController 映射表*/
@property (strong, nonatomic) NSMutableDictionary *navigateTable;

+ (instancetype)shareCache;

-(NSDictionary *)hitCache:(NSString *)urlPath;

@end
