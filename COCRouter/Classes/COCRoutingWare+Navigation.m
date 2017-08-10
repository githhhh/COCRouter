//
//  COCRoutingWare+Navigation.m
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingWare+Navigation.h"

@implementation COCRoutingWare (Navigation)

-(void)matchViewControllerWithSuccess:(void(^)(void))success failure:(COCRoutingFailed)failure{
    
    NSString *hitPattern = [self hitUrlPatternOn:COCRoutingCache.shareCache.navigateTable.allKeys];
    
    if (hitPattern) {
        NSString*target = COCRoutingCache.shareCache.navigateTable[hitPattern];
        self.context.routeData = @{hitPattern:target};
        success();
        return;
    }
    
    if (failure) {
        failure(COCRouterModeRouteNotFound);
    }
}


@end
