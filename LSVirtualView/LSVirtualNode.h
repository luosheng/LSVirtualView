//
//  LSVirtualNode.h
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VNode(Type, Variable, Children) [LSVirtualNode alloc] initWithClass:Type.class children:Children configuration:^(Type * Variable)

typedef void (^LSVirtualNodeConfiguration)(__weak id object);

@interface LSVirtualNode : NSProxy

- (instancetype)initWithClass:(Class)class
                     children:(NSArray<LSVirtualNode *> *)children
                configuration:(LSVirtualNodeConfiguration)configuration;

- (id)create;

- (NSArray *)diff:(LSVirtualNode *)node;

@property (nonatomic, unsafe_unretained, readonly) Class underlyingClass;

@property (nonatomic, strong, readonly) NSArray *invocations;

@end
