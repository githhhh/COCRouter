//
//  COCResponderWare.m
//  COCRouter
//
//  Created by bin on 2017/6/26.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCResponderWare.h"
#import <objc/runtime.h>
#import "NSString+HandleUrl.h"

static void PerformSetControllerContext(id controller,NSDictionary* context){
    if (!controller || !context) {
        return;
    }
    //查找继承链
    Class currentClass = [controller class];
    
    BOOL isFinde = NO;
    while (currentClass && !isFinde) {
        //只查找业务类,如果deep到NSObject原生类,跳出。
        if ([NSStringFromClass(currentClass) isEqualToString:@"NSObject"]) {
            break;
        }
        
        uint32_t ivarCount;
        Ivar *ivars = class_copyIvarList(currentClass, &ivarCount);
        
        if (ivars) {
            for (uint32_t i = 0; i < ivarCount; i++) {
                Ivar ivar = ivars[i];
                const char *ivarType = ivar_getTypeEncoding(ivar);
                NSString *ivarTypeStr = [NSString stringWithCString:ivarType encoding:NSUTF8StringEncoding];
                //成员变量不是object 调用object_getIvar 会crash
                if (![ivarTypeStr hasPrefix:@"@"]) {
                    continue;
                }
                id pointer = object_getIvar(controller, ivar);
                
                // @"@\"NSDictionary\""
                NSRange range = [ivarTypeStr rangeOfString:@"\""];
                ivarTypeStr = [ivarTypeStr substringFromIndex:range.location + range.length];
                // NSDictionary\"";
                range = [ivarTypeStr rangeOfString:@"\""];
                ivarTypeStr = [ivarTypeStr substringToIndex:range.location];
                
                Class modelClass =  NSClassFromString(ivarTypeStr);
                
                if (!pointer && [modelClass isSubclassOfClass:[NSDictionary class]]) {
                    isFinde = YES;
                    object_setIvar(controller, ivar, context);
                    break;
                }
            }
            free(ivars);
        }
        currentClass = [currentClass superclass];
    }
}

@implementation COCResponderWare

-(void)startWithSuccess:(COCRoutingSuccess)success failure:(COCRoutingFailed)failure{
    
    [COCResponderWare respondeRouting:self.context args:nil success:^{
        
        success(self.context);
        
    } failure:failure];
    
}


+ (BOOL)checkRoutingContext:(COCRoutingContext *)context{
    
    NSString *classStr = [NSString stringWithFormat:@"%@Controller",[context.scheme capitalizedFirstLetter]];
    Class controllerClass = NSClassFromString(classStr);
    
    id controller = [[controllerClass alloc] init];
    SEL action = NSSelectorFromString(context.routeData.allValues.firstObject);
    
    if (!controller || ![controller respondsToSelector:action]) {
        return NO;
    }
    
    return  YES;
}

+ (void)respondeRouting:(COCRoutingContext *)context args:(NSArray *)args success:(void(^)(void))success failure:(COCRoutingFailed)failure{
    
    //check
    if (![COCResponderWare checkRoutingContext:context]) {
        if (failure) {
            failure(COCRouterModeHandlerNotFound);
        }
        return;
    }
    
    @try {
        NSString *classStr = [NSString stringWithFormat:@"%@Controller",[context.scheme capitalizedFirstLetter]];
        
        Class controllerClass = NSClassFromString(classStr);
        
        id controller = [[controllerClass alloc] init];
        
        PerformSetControllerContext(controller,[context toDictionary]);
        
        SEL action = NSSelectorFromString(context.routeData.allValues.firstObject);
        
        NSMethodSignature * signature = [controller methodSignatureForSelector:action];
        NSInvocation *invocation =  [NSInvocation  invocationWithMethodSignature:signature];
        [invocation setTarget:controller];
        [invocation setSelector:action];
        
        //没有参数直接调用
        if (signature.numberOfArguments == 2) {
            [invocation invokeWithTarget:controller];
            return;
        }
        //校验参数顺序和个数。。
        
        for (int i = 0; i< args.count; i++) {
            
            id arg = args[i];
            
            if ([self isBlock:arg]) {
                arg = [arg copy];
            }
            
            [invocation setArgument: &arg atIndex:(i+2)];
        }
        
        [invocation retainArguments]; // does not retain blocks
        [invocation invokeWithTarget:controller];
        
        if (success) {
            success();
        }
    } @catch (NSException *exception) {
        if (failure) {
            failure(COCRouterModeInvocationModuleError);
        }
    }
}

+ (BOOL)isBlock:(id)item {
    id block = ^{};
    Class blockClass = [block class];
    while ([blockClass superclass] != [NSObject class]) {
        blockClass = [blockClass superclass];
    }
    return [item isKindOfClass:blockClass];
}


@end
