//
//  NSString+HandleUrl.m
//  COCRouter
//
//  Created by bin on 2017/6/28.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "NSString+HandleUrl.h"
#import "RegExCategories.h"

//匹配url 路径内参数
#define ParamMatchExpr @"(.+?)"

//替换通配符 *
//#define matchSildcard  @"(.*)"

@implementation NSString (HandleUrl)

#pragma mark - convert pattern to regularExpression

/*! 转换为正则表达式*/
+ (NSString *)regularExpressionWith:(NSString *)pattern{
    //替换参数占位符
    pattern = [RX(@"<\\w+>") replace:pattern with:ParamMatchExpr];
    
    if (![pattern hasPrefix:@"^"]) {
        pattern = [NSString stringWithFormat:@"^%@",pattern];
    }
    
    if (![pattern hasSuffix:@"$"]) {
        pattern = [pattern stringByAppendingString:@"$"];
    }
    
    return pattern;
}

/*! 检查格式*/
+ (NSString *)foramteUrlPattern:(NSString *)pattern scheme:(NSString *)scheme{
    pattern = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pattern = [pattern stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![pattern hasSuffix:@"/"]) {
        pattern = [pattern stringByAppendingString:@"/"];
    }
    
    //检查dsl 是否包含scheme
    NSString *schemeStr = [NSString stringWithFormat:@"%@://",scheme];
    if (![pattern hasPrefix:schemeStr]) {
        pattern = [NSString stringWithFormat:@"%@%@",schemeStr,pattern];
    }
    
    return pattern;
}

- (NSString *) capitalizedFirstLetter {
    NSString *retVal;
    if (self.length < 2) {
        retVal = self.capitalizedString;
    } else {
        retVal = [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]];
    }
    return retVal;
}

#pragma mark - 编码/解码

- (NSString*)URLEncodingString{
    
    // NSURL's stringByAddingPercentEscapesUsingEncoding: does not escape
    // some characters that should be escaped in URL parameters, like / and ?;
    // we'll use CFURL to force the encoding of those
    //
    // We'll explicitly leave spaces unescaped now, and replace them with +'s
    //
    // Reference: <a href="%5C%22http://www.ietf.org/rfc/rfc3986.txt%5C%22" target="\"_blank\"" onclick='\"return' checkurl(this)\"="" id="\"url_2\"">http://www.ietf.org/rfc/rfc3986.txt</a>
    
    NSString *resultStr = self;
    
    CFStringRef originalString = (__bridge CFStringRef) self;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    
    if( escapedStr )
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@"%20"
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    return resultStr;
}

- (NSString *)URLDecodingString
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}
@end
