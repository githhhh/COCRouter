//
//  OrderDetailViewController.h
//  COCRouter
//
//  Created by bin on 2017/6/16.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController

-(void)request:(NSString *)discountID
    paySuccess:(void (^)(NSString *orderID, NSDictionary *info))successBlock
     payCancel:(void (^)(NSString *orderID, NSDictionary *info))cancelBlock;


@end
