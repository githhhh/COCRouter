//
//  COCParserWare.h
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COCRoutingWare.h"

@interface COCParserWare : COCRoutingWare

@property (strong, nonatomic) NSURL* url;

+(void)parseUrlPath:(COCRoutingContext *)context;

@end
