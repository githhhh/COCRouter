//
//  NSString+HandleUrl.h
//  COCRouter
//
//  Created by bin on 2017/6/28.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HandleUrl)

/*! urlPattern 转换正则表达式*/
+ (NSString *)regularExpressionWith:(NSString *)pureUrlPattern;
+ (NSString *)foramteUrlPattern:(NSString *)pattern scheme:(NSString *)scheme;


- (NSString *) capitalizedFirstLetter;

/*! url 编码解码*/
- (NSString*)URLEncodingString;
- (NSString *)URLDecodingString;

@end
