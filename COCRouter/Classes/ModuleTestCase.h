//
//  ModuleTestCase.h
//  COCRouter
//
//  Created by bin on 2017/6/28.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleTestCase : NSObject

-(instancetype)initModuleTestWithScheme:(NSString *)scheme;

/*! 检查配置文件是否符合约定 格式*/
- (NSString *)checkConfigPromise;

/*！构造伪url数组 */
- (void)makeFakeUrlsByConfig;

/*！测试转发所有伪url是否成功*/
- (NSString *)testFakeUrlsForward;

/*！随机转发一条伪url 的性能测试 */
- (void)testRandomOneTimeForwardPerformance;

@end
