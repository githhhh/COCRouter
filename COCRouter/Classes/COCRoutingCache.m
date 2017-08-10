//
//  COCRoutingCache.m
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingCache.h"
#import "RegExCategories.h"
#import "NSString+HandleUrl.h"

static COCRoutingCache *_sharedSingleton;

@implementation COCRoutingCache

+ (instancetype)shareCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
        
        //TODO 内存警告清除配置缓存
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearRouteCaches)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    });
    return _sharedSingleton;
}

+ (void)clearRouteCaches{
    [[COCRoutingCache shareCache].routConfigCache removeAllObjects];
}

#pragma mark - Hit RoutingCache

-(NSDictionary *)hitCache:(NSString *)urlPath{
    
    __block NSDictionary *routeData = nil;
    
    [self.routedCache enumerateKeysAndObjectsUsingBlock:^(NSString* pattern, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *regularExpr = [NSString regularExpressionWith:pattern];
        
        BOOL isMatch =  [urlPath isMatch:RX(regularExpr)];
        
        if (isMatch) {
            routeData = @{pattern:obj};
            *stop = YES;
            return;
        }
    }];
    
    return routeData;
}


#pragma mark -  AutoGetter

- (NSMutableDictionary *)routedCache {
    if (!_routedCache) {
        _routedCache = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return _routedCache;
}

- (NSMutableDictionary *)routConfigCache {
    if (!_routConfigCache) {
        _routConfigCache = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return _routConfigCache;
}

- (NSMutableDictionary *)navigateTable {
    if (!_navigateTable) {
        _navigateTable = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return _navigateTable;
}

@end
