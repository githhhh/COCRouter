//
//  OrderController.m
//  COCRouter
//
//  Created by bin on 2017/6/16.
//  Copyright © 2017年 githhhh. All rights reserved.
//  Template From COCXcodePlugin
//

#import "OrderController.h"
#import "OrderDetailViewController.h"

@implementation OrderController

- (void)orderDetail:(NSString *)discountID
             baseVC:(UIViewController *)vc
         paySuccess:(void (^)(NSString *orderID, NSDictionary *info))successBlock
          payCancel:(void (^)(NSString *orderID, NSDictionary *info))cancelBlock{
    
    OrderDetailViewController *orderVC = [[OrderDetailViewController  alloc] init];
    
    [orderVC request:discountID  paySuccess:successBlock payCancel:cancelBlock];
    
    [vc presentViewController:orderVC animated:YES completion:nil];

}


- (void)showOrderList:(UIViewController *)baseVC{

    
    NSLog(@"~~vc~\n~~~~~~~%@",baseVC);

    
    NSLog(@"~~showList~\n~~~~~~~%@",self.context);
    
}


@end
