//
//  COCRouter+Order.m
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRouter+Order.h"

/**
 *  url alias
 */
static NSString *const OrderDetailRoute = @"order://detail/";
static NSString *const OrderListRoute = @"order://list/";

@implementation COCRouter (Order)

+ (void)orderDetail:(NSString *)discountID
             baseVC:(UIViewController *)vc
         paySuccess:(void (^)(NSString *orderID, NSDictionary *info))successBlock
          payCancel:(void (^)(NSString *orderID, NSDictionary *info))cancelBlock{
    
    [COCRouter forwardModule:[NSURL URLWithString:OrderDetailRoute]
                 convention:_cmd
                       args:@[discountID,vc,successBlock,cancelBlock]
                   complete:nil];
}

+ (void)showOrderList:(UIViewController *)baseVC{
    
    [COCRouter forwardModule:[NSURL URLWithString:OrderListRoute]
                 convention:_cmd
                       args:@[baseVC]
                   complete:nil];
}
@end
