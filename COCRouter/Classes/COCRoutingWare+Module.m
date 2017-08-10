//
//  COCRoutingWare+Module.m
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingWare+Module.h"

@implementation COCRoutingWare (Module)

- (void)routingModuleWithSuccess:(void(^)(void))success failure:(COCRoutingFailed)failure{
    
    //TODO 缓存
    self.context.routeData = [COCRoutingCache.shareCache hitCache:self.context.urlPath];
    if (self.context.routeData) {
        success();
        return;
    }
    
    //TODO 从约定中获取路由
    self.context.routeData = [self routDataFromConvention];
    if (self.context.routeData) {
        //更新缓存
        [COCRoutingCache.shareCache.routedCache addEntriesFromDictionary:self.context.routeData];
        success();
        return;
    }
    
    //TODO 从路由配置中获取路由
    self.context.routeData = [self routDataFromConfiguration];
    if (self.context.routeData) {
        //更新缓存
        [COCRoutingCache.shareCache.routedCache addEntriesFromDictionary:self.context.routeData];
        success();
        return;
    }
    
    if (failure){
        failure(COCRouterModeRouteNotFound);
    }
}


#pragma mark - Convention

-(NSDictionary *)routDataFromConvention{
    
    NSString *classStr = [NSString stringWithFormat:@"%@Controller",[self.context.scheme capitalizedFirstLetter]];
    
    Class controllerClass = NSClassFromString(classStr);
    
    id controller = [[controllerClass alloc] init];
    
    if (!controller ||
        self.conventionSelector == NULL ||
        ![controller respondsToSelector:self.conventionSelector]) {
        return nil;
    }
    
    //从路由扩展是否传递了到模块控制器约定的Selector
    NSString* pureUrlPattern = [NSString foramteUrlPattern:self.context.urlPath
                                                    scheme:self.context.scheme];
    
    return  @{pureUrlPattern:NSStringFromSelector(self.conventionSelector)};
}

#pragma mark - Configuration

-(NSDictionary *)routDataFromConfiguration{
    
    NSArray *routeTable = [self readConfigWithScheme];
    if (!routeTable) {
        return nil;
    }
    
    NSDictionary *routData = [self routingDataMatchInConfig:routeTable];
    return routData;
}

-(NSArray *)readConfigWithScheme{
    
    if ([[COCRoutingCache.shareCache.routConfigCache allKeys] containsObject:self.context.scheme]) {
        return COCRoutingCache.shareCache.routConfigCache[self.context.scheme];
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@Config",self.context.scheme] ofType:@"plist"];
    
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    if (config) {
        //更新配置文件缓存
        [COCRoutingCache.shareCache.routConfigCache setObject:[config allValues] forKey:self.context.scheme];
        return [config allValues];
    }
    
    return nil;
}

//返回路由格式: {@"pureUrlPattern":@"sel"}
- (NSDictionary *)routingDataMatchInConfig:(NSArray *)routeTable{
    
    __block NSDictionary *routeData = nil;
    
    [routeTable enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *patterns = nil;
        if ([[obj allValues].firstObject isKindOfClass:[NSArray class]]) {
            patterns = [obj allValues].firstObject;
        }else if ([[obj allValues].firstObject isKindOfClass:[NSString class]]){
            patterns = @[[obj allValues].firstObject];
        }
        
        NSString *hitPattern = [self hitUrlPatternOn:patterns];
        
        if (hitPattern) {
            NSString*pureUrlPattern = [NSString foramteUrlPattern:hitPattern scheme:self.context.scheme];
            NSString*sel = obj.allKeys.firstObject;
            routeData = @{pureUrlPattern:sel};
            *stop = YES;
            return ;
        }
        
    }];
    
    return routeData;
}

@end
