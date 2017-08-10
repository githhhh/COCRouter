//
//  COCRouter+ComponentUI.m
//  COCRouter
//
//  Created by bin on 2017/8/10.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "COCRouter+ComponentUI.h"

@implementation COCRouter (ComponentUI)

static NSString*const FoundationUI_AlertView = @"componentUI://alert";

+ (void)alertView:(NSString *)title
          message:(NSString *)message
     buttonTitles:(NSArray *)buttonTitles
    buttonClicked:(void(^)(NSNumber *index))block{
    
    [COCRouter forwardModule:[NSURL URLWithString:FoundationUI_AlertView]
                 convention:_cmd
                       args:@[title,message,buttonTitles,block]
                   complete:nil];
    
}

@end
