//
//  COCRouterTests.m
//  COCRouterTests
//
//  Created by githhhh on 08/10/2017.
//  Copyright (c) 2017 githhhh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ModuleTestCase.h"

@interface COCRouterTest : XCTestCase

@property (strong, nonatomic) ModuleTestCase* test;

@end

@implementation COCRouterTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.test = [[ModuleTestCase alloc] initModuleTestWithScheme:@"https"];
    
    NSString *expectate = [self.test checkConfigPromise];
    
    XCTAssertNil(expectate);
    
    [self.test makeFakeUrlsByConfig];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.test = nil;
}

- (void)testForward {
    
    NSString *expectate = [self.test testFakeUrlsForward];
    
    XCTAssertNil(expectate);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        [self.test testRandomOneTimeForwardPerformance];
        
    }];
}

@end


