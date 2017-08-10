//
//  ComponentUIController.m
//  COCRouter
//
//  Created by bin on 2017/7/18.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "ComponentUIController.h"
#import "UIViewController+TopViewController.h"

@implementation ComponentUIController

- (void)alertView:(NSString *)title
          message:(NSString *)message
     buttonTitles:(NSArray *)buttonTitles
    buttonClicked:(void(^)(NSNumber *index))block{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (block) {
            block(@0);
        }
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (block) {
            block(@1);
        }
    }];
    
    [alertVc addAction:cancelAction];
    [alertVc addAction:sureAction];
    
    [UIViewController.topMost presentViewController:alertVc animated:YES completion:^{
        
    }];
}

@end
