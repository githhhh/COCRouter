//
//  COCRoutingWare.h
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+HandleUrl.h"
#import "COCRoutingCache.h"
#import "COCRoutingFilter.h"

//路由类型
typedef NS_ENUM(NSInteger, COCRoutingType) {
    
    COCForwardModule = 0,
    
    COCNavigateViewController ,
    
};

@interface COCRoutingWare : COCRoutingFilter

@property (assign, nonatomic) COCRoutingType routingType;

/*! 路由扩展和模块控制器 约定Selector*/
@property (assign, nonatomic) SEL conventionSelector;

- (NSString *)hitUrlPatternOn:(NSArray *)urlPatterns;

@end
