//
//  COCRoutingMiddleWareProtocol.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COCRouter.h"

@protocol COCRoutingMiddleWareProtocol <NSObject>

@property (strong, nonatomic) COCRoutingContext* context;

-(void)startWithSuccess:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure;

@end
