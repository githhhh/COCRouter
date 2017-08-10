//
//  COCRouter+Navigation.m
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRouter+Navigation.h"
#import "COCRoutingPipeline.h"
#import "UIViewController+TopViewController.h"
#import "COCRoutingCache.h"
#import <objc/runtime.h>
#import "COCRoutingFilter.h"

void _RouteMap(NSString* url,Class viewController){
    [COCRoutingCache.shareCache.navigateTable setValue:NSStringFromClass(viewController) forKey:url];
}

@implementation COCRouter (Navigation)

#pragma mark - 导航ViewController

+ (void)push:(NSURL *)url animated:(BOOL)animated{
    [self push:url navController:UIViewController.topMost.navigationController animated:YES];
}

+ (void)present:(NSURL *)url animated:(BOOL)animated{
    [self present:url baseViewController:UIViewController.topMost animated:YES];
}

+ (void)push:(NSURL *)url navController:(UINavigationController *)navigation animated:(BOOL)animated{
    NSParameterAssert(url&&navigation);
    
    COCRoutingPipeline *pipeline = [COCRoutingPipeline createPipelineWith:url];
    
    pipeline.routingType = COCNavigateViewController;
    
    [pipeline startWithSuccess:^(COCRoutingContext *context) {
        
        Class vcClass = NSClassFromString(context.routeData.allValues.firstObject);
        
        UIViewController* viewController = [[vcClass alloc] init];
        
        viewController.routeContext = context;
        
        [navigation pushViewController:viewController animated:animated];
        
    } failure:^(COCRouterMode mode) {
        
        //转发错误
        [COCRoutingFilter forwardRoutingExceptionSource:url state:mode];
        
    }];
}

+ (void)present:(NSURL *)url baseViewController:(UIViewController *)baseVC animated:(BOOL)animated{
    NSParameterAssert(url&&baseVC);
    
    COCRoutingPipeline *pipeline = [COCRoutingPipeline createPipelineWith:url];
    
    pipeline.routingType = COCNavigateViewController;
    
    [pipeline startWithSuccess:^(COCRoutingContext *context) {
        
        Class vcClass = NSClassFromString(context.routeData.allValues.firstObject);
        
        UIViewController* viewController = [[vcClass alloc] init];
        
        viewController.routeContext = context;
        
        [baseVC presentViewController:viewController animated:animated completion:nil];
        
    } failure:^(COCRouterMode mode) {
        
        //转发错误
        [COCRoutingFilter forwardRoutingExceptionSource:url state:mode];
        
    }];
}

@end


@implementation UIViewController (COCRouterNavigation)

static char const * const kCOCRouterNavigationContext  = "COCRouterNavigationContext";

- (COCRoutingContext *)routeContext
{
    return objc_getAssociatedObject(self, &kCOCRouterNavigationContext);
}

- (void)setRouteContext:(COCRoutingContext *)routeContext{
    
    objc_setAssociatedObject(self, &kCOCRouterNavigationContext, routeContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
