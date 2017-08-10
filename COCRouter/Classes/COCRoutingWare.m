//
//  COCRoutingWare.m
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingWare.h"
#import "COCRoutingWare+Module.h"
#import "COCRoutingWare+Navigation.h"
#import "COCParserWare.h"
#import "RegExCategories.h"

@implementation COCRoutingWare

-(void)startWithSuccess:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure{

    //TODO: 转发模块
    if (self.routingType == COCForwardModule) {
        
        //匹配
        [self routingModuleWithSuccess:^{
            
            //提取路径参数
            [COCParserWare parseUrlPath:self.context];
            
            //进入拦截器
            [super startWithSuccess:success failure:failure];
            
        } failure:failure];

        return;
    }
    
    //TODO: 匹配viewController
    [self matchViewControllerWithSuccess:^{
        
        //提取路径参数
        [COCParserWare parseUrlPath:self.context];
        
        if (success) {
            success(self.context);
        }
        
    } failure:failure];
}

#pragma mark - Private

- (NSString *)hitUrlPatternOn:(NSArray *)urlPatterns{
    
    __block NSString *hitPattern = nil;
    
    [urlPatterns enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //转换成正则表达式
        NSString*pureUrlPattern = [NSString foramteUrlPattern:obj scheme:self.context.scheme];

        NSString *regularExpr = [NSString regularExpressionWith:pureUrlPattern];
        
        //url 的匹配 忽略大小写
        NSRegularExpression *rx = [NSRegularExpression rx:regularExpr ignoreCase:YES];
        if ([self.context.urlPath isMatch:rx]) {
            hitPattern = obj;
            *stop = YES;
            return;
        }
    }];
    
    return hitPattern;
}

@end
