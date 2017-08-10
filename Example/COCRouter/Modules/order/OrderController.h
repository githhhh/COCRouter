//
//  OrderController.h
//  COCRouter
//
//  Created by bin on 2017/6/16.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderController : NSObject

@property (strong, nonatomic) NSDictionary* context;


- (void)orderDetail:(NSString *)discountID
             baseVC:(UIViewController *)vc
         paySuccess:(void (^)(NSString *orderID, NSDictionary *info))successBlock
          payCancel:(void (^)(NSString *orderID, NSDictionary *info))cancelBlock;



- (void)showOrderList:(UIViewController *)baseVC;

@end
