//
//  COCRoutingPipeline.m
//  COCRouter
//
//  Created by bin on 2017/6/27.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRoutingPipeline.h"

@implementation COCRoutingPipeline

+(instancetype)createPipelineWith:(NSURL *)url{

    COCRoutingPipeline *pipeLine = [COCRoutingPipeline alloc];
    
    pipeLine.url = url;
    
    return pipeLine;
}

- (void)startWithSuccess:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure{
    
    [super startWithSuccess:success failure:failure];
}


@end
