//
//  COCRoutingWare+Module.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingWare.h"

@interface COCRoutingWare (Module)

- (void)routingModuleWithSuccess:(void(^)(void))success failure:(COCRoutingFailed)failure;


@end
