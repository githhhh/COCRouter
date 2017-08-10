//
//  GlobalRouterHandler.m
//  COCRouter
//
//  Created by bin on 2017/6/27.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "RouteFilterHandler.h"
#import "COCLoginState.h"

@implementation RouteFilterHandler

-(void)routingExceptionSource:(NSURL *)url  state:(COCRouterMode)mode{

    
    NSLog(@"RouteFilterHandler~~~异常处理~\nurl===%@\nstate===%ld\n",url,mode);
    
}

-(void)routingLoginFilterFor:(NSURL *)url loginComplete:(void(^)())loginComplete{
    

    if ([url.absoluteString containsString:@"/index/"]) {
        
        
        [COCLoginState needLogin:loginComplete];
        
        return;
    }
    
    
    loginComplete();
}

@end
