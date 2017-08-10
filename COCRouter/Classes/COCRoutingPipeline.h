//
//  COCRoutingPipeline.h
//  COCRouter
//
//  Created by bin on 2017/6/27.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COCParserWare.h"

@interface COCRoutingPipeline : COCParserWare

+(instancetype)createPipelineWith:(NSURL *)url;

@end
