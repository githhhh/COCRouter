//
//  COCParserWare.m
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCParserWare.h"
#import "RegExCategories.h"
#import "NSString+HandleUrl.h"

@implementation COCParserWare

-(void)startWithSuccess:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure{
    
    self.context = [COCParserWare contextFromUrl:self.url];
    
    if (self.context) {//继续传递
        [super startWithSuccess:success failure:failure];
        return;
    }
    
    if (failure) {
        failure(COCRouterModeUrlParseFailed);
    }
}

#pragma mark - Private

+ (COCRoutingContext *)contextFromUrl:(NSURL *)url{
    
    COCRoutingContext *context = nil;

    @try {
        context = [[COCRoutingContext alloc] init];
        
        context.originUrl = url;
        
        NSString *decodingUrlStr = [[url absoluteString] URLDecodingString];//解码
        
        //替换scheme
        if ([decodingUrlStr hasPrefix:@"http://"]) {
            decodingUrlStr = [decodingUrlStr stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@"https"];
            context.scheme = @"https";
        }
        
        context.absoluteString = decodingUrlStr;
        
        if (!context.scheme) {
            context.scheme = url.scheme?url.scheme:nil;
        }
        
        context = [self parseUrl:context];
        
    } @catch (NSException *exception) {
        context = nil;
    }
    
    return context;
}


#pragma mark - url 解析

+(id)parseUrl:(COCRoutingContext *)context{
    //原Url被编码 所以取不出scheme
    if (!context.scheme) {
        
        if ([context.absoluteString containsString:@"://"] ) {
            NSArray *spliteArr = [context.absoluteString componentsSeparatedByString:@"://"];
            context.scheme = spliteArr.firstObject;
        }
        
        NSArray *strURLParse = [context.absoluteString componentsSeparatedByString:@"?"];
        if (strURLParse.count != 2) {
            return nil;
        }
        
        NSString *paramsString = strURLParse.lastObject;
        NSMutableDictionary *urlParams = [NSMutableDictionary dictionaryWithCapacity:0];
        for (NSString *param in [paramsString componentsSeparatedByString:@"&"]) {
            NSArray *elts = [param componentsSeparatedByString:@"="];
            if([elts count] < 2) continue;
            [urlParams setObject:[elts lastObject] forKey:[elts firstObject]];
        }
        
        context.urlQuery = (urlParams.count > 0) ? urlParams : nil;
        context.urlPath = strURLParse.firstObject;
        
        //必须以 "/" 结尾
        if (![context.urlPath hasSuffix:@"/"]) {
            context.urlPath = [context.urlPath stringByAppendingString:@"/"];
        }
        
        return context;
    }
    
    //解析
    NSString *paramsString = [context.originUrl query];
    NSMutableDictionary *urlParams = [[NSMutableDictionary alloc] init];
    for (NSString *param in [paramsString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [urlParams setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    NSString *urlPath = context.absoluteString;
    if (paramsString) {
        urlPath = [urlPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"?%@",paramsString] withString:@""];
    }
    //必须以 "/" 结尾
    if (![urlPath hasSuffix:@"/"]) {
        urlPath = [urlPath stringByAppendingString:@"/"];
    }
    
    context.urlQuery = (urlParams.count > 0) ? urlParams : nil;
    context.urlPath = urlPath;
    
    return context;
}


#pragma mark - url路径参数解析

+(void)parseUrlPath:(COCRoutingContext *)context{
    
    NSString*urlPattern = context.routeData.allKeys.firstObject;
    NSArray *keyMatchs = [urlPattern matchesWithDetails:RX(@"<\\w+>")];
    
    NSString *regularExpr =  [NSString regularExpressionWith:urlPattern];
    NSArray *valueMatchs = [context.urlPath matchesWithDetails:RX(regularExpr)];
    
    if (keyMatchs.count == 0 || valueMatchs.count == 0) {
        return;
    }
    
    //解析keys
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:0];
    [keyMatchs enumerateObjectsUsingBlock:^(RxMatch* keyObj, NSUInteger keyIdx, BOOL * _Nonnull keyStop) {
        [keyObj.groups enumerateObjectsUsingBlock:^(RxMatchGroup *group, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString*clearKey = [group.value stringByReplacingOccurrencesOfString:@"<" withString:@""];
            clearKey = [clearKey stringByReplacingOccurrencesOfString:@">" withString:@""];
            
            [keys addObject:clearKey];
        }];
    }];
    
    //解析values
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
    [valueMatchs enumerateObjectsUsingBlock:^(RxMatch* valueObj, NSUInteger valueIdx, BOOL * _Nonnull valueStop) {
        [valueObj.groups enumerateObjectsUsingBlock:^(RxMatchGroup *group, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![group.value isEqualToString:context.urlPath]) {
                [values addObject:group.value];
            }
        }];
    }];
    
    if (values.count != keys.count) {
        return;
    }
    context.pathInnerParams = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
}

@end
