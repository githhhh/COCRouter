//
//  COCNavigatorMap.m
//  COCRouter
//
//  Created by bin on 2017/6/21.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCNavigatorMap.h"
#import "COCRouter+Navigation.h"
#import "UserInfoViewController.h"

@implementation COCNavigatorMap

+(void)initialize{
    
    _RouteMap(@"navigator://user/<_id>/", [UserInfoViewController class]);
    
    
    
    
}


@end
