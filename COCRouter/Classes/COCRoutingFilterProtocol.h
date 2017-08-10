//
//  COCRoutingFilterProtocol.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COCRouter.h"

@protocol COCRoutingFilterProtocol <NSObject>
/**
 *  处理异常
 */
-(void)routingExceptionSource:(NSURL *)url  state:(COCRouterMode)mode;

@end
