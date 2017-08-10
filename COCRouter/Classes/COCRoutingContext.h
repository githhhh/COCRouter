//
//  COCRoutingContext.h
//  COCRouter
//
//  Created by bin on 2017/6/14.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COCRoutingContext : NSObject

@property (strong, nonatomic) NSURL* originUrl;

@property (copy, nonatomic) NSString* absoluteString;

@property (copy, nonatomic) NSString* scheme;

/*!   sheme://a/b/c/    */
@property (copy, nonatomic) NSString* urlPath;

/*! @{@"urlPattern":sel/vc} */
@property (copy, nonatomic) NSDictionary* routeData;

@property (strong, nonatomic) NSDictionary* urlQuery;

@property (copy, nonatomic) NSDictionary* pathInnerParams;


// convert
-(instancetype)initWithDictionary:(NSDictionary *)dic;

-(NSDictionary *)toDictionary;

@end
