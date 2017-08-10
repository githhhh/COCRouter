//
//  BaseComponentUIController.h
//  COCRouter
//
//  Created by bin on 2017/7/18.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseComponentUIController : NSObject

- (void)alertView:(NSString *)title
          message:(NSString *)message
     buttonTitles:(NSArray *)buttonTitles
    buttonClicked:(void(^)(NSNumber *index))block;


- (void)toastView;

@end
