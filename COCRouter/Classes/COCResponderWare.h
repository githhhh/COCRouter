//
//  COCResponderWare.h
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COCRoutingMiddleWareProtocol.h"

@interface COCResponderWare : NSProxy<COCRoutingMiddleWareProtocol>

@property (strong, nonatomic) COCRoutingContext* context;

+ (void)respondeRouting:(COCRoutingContext *)context
                   args:(NSArray *)args
                success:(void(^)(void))success
                failure:(COCRoutingFailed)failure;

@end
