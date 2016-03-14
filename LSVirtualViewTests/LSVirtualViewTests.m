//
//  LSVirtualViewTests.m
//  LSVirtualViewTests
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSVirtualNode.h"
#import "LSVirtualPatch.h"

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

- (void)testVirtualNodeShouldBeBoundToUIView {
    LSVirtualNode *node1 = [VNode(UIButton, _, @[]) {}];
    XCTAssertNotNil(node1);
    
    LSVirtualNode *node2 = [VNode(NSString, _, @[]) {}];
    XCTAssertNil(node2);
}

- (void)testCreation {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    LSVirtualNode *node = [VNode(UIButton, button, @[]) {
        [button setTitle:@"123" forState:UIControlStateNormal];
        button.tintColor = [UIColor redColor];
    }];
    
    UIButton *button = [node create];
    NSString *title = [button titleForState:UIControlStateNormal];
    XCTAssertEqual(title, @"123");
}

- (void)testDiff {
    LSVirtualNode *node1 = [VNode(UIButton, button, @[]) {
        [button setTitle:@"123" forState:UIControlStateNormal];
    }];
    LSVirtualNode *node2 = [VNode(UIButton, button, @[]) {
        [button setTitle:@"123" forState:UIControlStateNormal];
    }];
    
    NSArray *diffs = [node1 diff:node2];
    XCTAssertEqual(diffs.count, 0);
}

- (void)testTwoDifferentNodes {
    LSVirtualNode *node1 = [VNode(UIButton, button, @[]) {
        [button setTitle:@"123" forState:UIControlStateNormal];
    }];
    LSVirtualNode *node2 = [VNode(UIView, view, @[]) {
        view.backgroundColor = [UIColor redColor];
    }];
    
    NSArray *diffs = [node1 diff:node2];
    XCTAssertEqual(diffs.count, 1);
    
    LSVirtualPatch *patch = diffs.firstObject;
    XCTAssertEqual(patch.type, LSVirtualPatchTypeNode);
    XCTAssertEqual(patch.node, node1);
    XCTAssertEqual(patch.patch, node2);
}

- (void)testInvocations {
    LSVirtualNode *node1 = [VNode(UIButton, button, @[]) {
        [button setTitle:@"123" forState:UIControlStateNormal];
    }];
    
    LSVirtualNode *node2 = [VNode(UIButton, button, @[]) {
        [button setTitle:@"123" forState:UIControlStateNormal];
    }];

    NSInvocation *invocation1 = node1.invocations.firstObject;
    NSInvocation *invocation2 = node2.invocations.firstObject;
    
    XCTAssertNotNil(invocation1);
    XCTAssertNotNil(invocation2);

    XCTAssertEqual(invocation1.selector, invocation2.selector);
    NSLog(@"%@", NSStringFromSelector(invocation1.selector));
    NSString *arg1;
    NSString *arg2;
    [invocation1 getArgument:&arg1 atIndex:2];
    [invocation2 getArgument:&arg2 atIndex:2];
    XCTAssertEqualObjects(arg1, arg2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
