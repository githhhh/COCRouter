//
//  COCRouter+ComponentUI.h
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRouter.h"

@interface COCRouter (ComponentUI)

+ (void)alertView:(NSString *)title
          message:(NSString *)message
     buttonTitles:(NSArray *)buttonTitles
    buttonClicked:(void(^)(NSNumber *index))block;


@end
