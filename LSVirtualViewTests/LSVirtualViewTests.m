//
//  LSVirtualViewTests.m
//  LSVirtualViewTests
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSVirtualNode.h"

@interface LSVirtualViewTests : XCTestCase

@end

@implementation LSVirtualViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    LSVirtualNode *node = [[LSVirtualNode alloc] initWithClass:UIButton.class configuration:^(UIButton * object) {
        [object setTitle:@"123" forState:UIControlStateNormal];
        object.tintColor = [UIColor redColor];
    }];
    
    UIButton *button = [node create];
    NSString *title = [button titleForState:UIControlStateNormal];
    XCTAssertEqual(title, @"123");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
