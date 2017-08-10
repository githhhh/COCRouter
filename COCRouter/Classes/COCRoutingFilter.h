//
//  COCRoutingFilter.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCResponderWare.h"
#import "COCRoutingFilterProtocol.h"

@interface COCRoutingFilter : COCResponderWare<COCRoutingFilterProtocol>

@property (assign, nonatomic) BOOL isInvocationResponder;

/*! 转发异常消息*/
+(void)forwardRoutingExceptionSource:(NSURL *)url state:(COCRouterMode)state;


@end
