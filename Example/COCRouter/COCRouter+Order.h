//
//  COCRouter+Order.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRouter.h"

@interface COCRouter (Order)

#pragma mark  - OrderDetail

+ (void)orderDetail:(NSString *)discountID
             baseVC:(UIViewController *)vc
         paySuccess:(void (^)(NSString *orderID, NSDictionary *info))successBlock
          payCancel:(void (^)(NSString *orderID, NSDictionary *info))cancelBlock;


#pragma mark  - OrderList

+ (void)showOrderList:(UIViewController *)baseVC;

@end
