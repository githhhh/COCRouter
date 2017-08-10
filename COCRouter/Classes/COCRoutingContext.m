//
//  COCRoutingContext.m
//  COCRouter
//
//  Created by bin on 2017/6/14.
//  Copyright © 2017年 githhhh. All rights reserved.
//  Template From COCXcodePlugin
//

#import "COCRoutingContext.h"
#import <objc/runtime.h>

@implementation COCRoutingContext

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if (dic) {
            [self setValuesForKeysWithDictionary:dic];
        }
    }
    return self;
}

-(NSDictionary *)toDictionary{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setValue:[self valueForKey:key] forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}



@end
