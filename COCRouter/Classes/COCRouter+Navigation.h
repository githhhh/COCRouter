//
//  COCRouter+Navigation.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRouter.h"
#import <UIKit/UIKit.h>

/*! 添加映射url -> viewControll*/
void _RouteMap(NSString* url,Class viewController);

@interface COCRouter (Navigation)

/*!【导航ViewController】*/
+ (void)push:(NSURL *)url animated:(BOOL)animated;
+ (void)present:(NSURL *)url animated:(BOOL)animated;

+ (void)push:(NSURL *)url navController:(UINavigationController *)navigation animated:(BOOL)animated;
+ (void)present:(NSURL *)url baseViewController:(UIViewController *)baseVC animated:(BOOL)animated;

@end

@interface UIViewController (COCRouterNavigation)

@property (strong, nonatomic) COCRoutingContext* routeContext;

@end
