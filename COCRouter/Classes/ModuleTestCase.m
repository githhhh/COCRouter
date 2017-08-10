//
//  ModuleTestCase.m
//  COCRouter
//
//  Created by bin on 2017/6/28.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "ModuleTestCase.h"
#import "COCRouter.h"
#import "RegExCategories.h"
#import "NSString+HandleUrl.h"

#define pathParamt  @"a_2_b"

@interface ModuleTestCase ()

@property (copy, nonatomic) NSString* scheme;

@property (strong, nonatomic) NSURL *randomUrl;

@property (strong, nonatomic) NSArray *urlArr;

@property (assign, nonatomic) BOOL notConfig;

@end

@implementation ModuleTestCase

-(instancetype)initModuleTestWithScheme:(NSString *)scheme{
    
    self = [super init];
    if (self) {
        _scheme = scheme;
    }
    return self;
}


- (NSString *)checkConfigPromise{
    //检查是否存在响应者
    NSString *classStr = [NSString stringWithFormat:@"%@Controller",[self.scheme capitalizedFirstLetter]];
    Class cs = NSClassFromString(classStr);
    if (!cs) {
        return [NSString stringWithFormat:@"不存在模块控制器: %@",classStr];
    }
    
    //配置文件
    NSString *fileName = [NSString stringWithFormat:@"%@Config",self.scheme];
    NSString* configPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    //可以没有  表示遵守urlPath ->  action 的默认约定
    if (!configPath) {
        self.notConfig = YES;
        return nil;
    }
    
    //如果有,检查格式
    NSDictionary* routConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
    NSString *desc = nil;
    for (id dic in [routConfig allValues]) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            desc = [NSString stringWithFormat:@"%@ 格式不匹配",fileName];
            break;
        }
        NSDictionary *routDic = dic;
        //该条路由对应的 urlPattern 数组
        if (![[routDic allValues].firstObject isKindOfClass:[NSArray class]] && ![[routDic allValues].firstObject isKindOfClass:[NSString class]]) {
            desc = [NSString stringWithFormat:@"%@ 格式不匹配",fileName];
            break;
        }
    }
    
    return desc;
}

- (NSString *)testFakeUrlsForward{
    if (self.notConfig) {
        return nil;
    }
    
    __block BOOL isFaile = NO;
    
    __block NSString *desc = nil;
    
    for (NSString*url in self.urlArr) {
        NSLog(@"!开始转发:%@\n",[url URLDecodingString]);
        
        [COCRouter forwardModule:[NSURL URLWithString:[url copy]]  complete:^(COCRouterMode mode) {
            if (mode == COCRouterModeSuccess) {
                return ;
            }
            
            isFaile = YES;
            desc = [NSString stringWithFormat:@"!转发url->%@ 发生错误,路由错误码->%ld",[url URLDecodingString],mode];
        }];
        
        if (isFaile) {
            break;
        }
    }
    
    return desc;
}

- (void)testRandomOneTimeForwardPerformance{
    if (self.notConfig) {
        return;
    }
    [COCRouter forwardModule:self.randomUrl  complete:nil];
}

#pragma mark - 生成伪url 数组

- (void)makeFakeUrlsByConfig{
    if (self.notConfig) {
        return;
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@Config",self.scheme];
    NSString* configPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    //TODO 遍历方法
    NSAssert(configPath,@"不存在配置文件~~~~~~%@",fileName);
    
    NSDictionary* routConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
    NSMutableArray *tempUrlArr = [NSMutableArray arrayWithCapacity:0];
    
    //遍历每条路由
    for (NSDictionary *routDic in [routConfig allValues]) {
        
        //遍历路由对应的urlPattern 数组
        NSArray *urlPatterns = nil;
        if ([[routDic allValues].firstObject isKindOfClass:[NSArray class]]) {
            urlPatterns = [routDic allValues].firstObject;
        }else if ([[routDic allValues].firstObject isKindOfClass:[NSString class]]){
            urlPatterns = @[[routDic allValues].firstObject];
        }

        for (NSString* pattern in urlPatterns) {
            NSString *url  = [RX(@"<\\w+>") replace:pattern with:pathParamt];
            url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (![url hasSuffix:@"/"]) {
                url = [pattern stringByAppendingString:@"/"];
            }
            
            url = [url stringByAppendingString:@"?参数a=1&参数b=2"];
            
            NSString* prefix = [NSString stringWithFormat:@"%@://",self.scheme];
            if (![url hasPrefix:prefix]) {
                url = [prefix stringByAppendingString:url];
            }
            
            url = [url URLEncodingString];
            [tempUrlArr addObject:url];
        }
        
    }
    
    self.urlArr = tempUrlArr;
}

#pragma mark -  AutoGetter

- (NSURL *)randomUrl {
    NSInteger count = self.urlArr.count;
    NSInteger x = arc4random() % count;
    NSString *urlStr = self.urlArr[x];
    _randomUrl = [NSURL URLWithString:urlStr];
    NSAssert(_randomUrl,@"~~~~~~伪url数组为nil");
    
    return _randomUrl;
}

@end
