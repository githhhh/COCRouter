//
//  COCLoginState.h
//  COCRouter
//
//  Created by bin on 2017/7/11.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COCLoginState : NSObject

+ (instancetype)sharedSingleton;

@property (assign, nonatomic) BOOL isLogin;

+(void)needLogin:(void(^)(void))block;

@end
