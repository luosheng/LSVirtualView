//
//  LSVirtualNode.m
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import "LSVirtualNode.h"
#import "LSVirtualPatch.h"

@interface LSVirtualNode ()

@property (nonatomic, unsafe_unretained, readwrite) Class underlyingClass;

@property (nonatomic, weak) id underlyingObject;

@property (nonatomic, strong, readwrite) NSMutableArray *invocations;

@property (nonatomic, strong) NSArray<LSVirtualNode *> *children;

@end

@implementation LSVirtualNode

+ (NSMutableDictionary *)_objectPool {
    static NSMutableDictionary *pool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pool = [NSMutableDictionary dictionary];
    });
    return pool;
}

- (instancetype)initWithClass:(Class)class
                     children:(NSArray<LSVirtualNode *> *)children
                configuration:(LSVirtualNodeConfiguration)configuration {
    NSString *className = NSStringFromClass(class);
    if (self.class._objectPool[className] == nil) {
        id object = [[class alloc] init];
        if (![object isKindOfClass:[UIView class]]) {
            return nil;
        }
        self.class._objectPool[className] = object;
    }
    
    _underlyingObject = self.class._objectPool[className];
    _underlyingClass = class;
    _invocations = [NSMutableArray array];
    _children = children;
    
    if (configuration != nil) {
        configuration(self);
    }
    
    return self;
}

- (id)create {
    id object = [[self.underlyingClass alloc] init];
    for (NSInvocation *invocation in self.invocations) {
        [invocation invokeWithTarget:object];
    }
    return object;
}

- (NSArray *)diff:(LSVirtualNode *)node {
    NSMutableArray *array = [NSMutableArray array];
    
    if (self.underlyingClass != node.underlyingClass) {
        LSVirtualPatch *patch = [[LSVirtualPatch alloc] initWithType:LSVirtualPatchTypeNode node:self patch:node];
        [array addObject:patch];
    }
    
    return [array copy];
}

#pragma mark - Method forwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.underlyingObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [(NSMutableArray *)self.invocations addObject:invocation];
}

@end
