//
//  LSVirtualNode.m
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import "LSVirtualNode.h"

@interface LSVirtualNode ()

@property (nonatomic, unsafe_unretained, readwrite) Class underlyingClass;

@property (nonatomic, weak) id underlyingObject;

@property (nonatomic, strong, readwrite) NSMutableArray *invocations;

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

- (instancetype)initWithClass:(Class)class configuration:(LSVirtualNodeConfiguration)configuration {
    NSString *className = NSStringFromClass(class);
    if (self.class._objectPool[className] == nil) {
        self.class._objectPool[className] = [[class alloc] init];
    }
    
    _underlyingObject = self.class._objectPool[className];
    _underlyingClass = class;
    _invocations = [NSMutableArray array];
    
    configuration(self);
    
    return self;
}

- (id)create {
    id object = [[self.underlyingClass alloc] init];
    for (NSInvocation *invocation in self.invocations) {
        [invocation invokeWithTarget:object];
    }
    return object;
}

#pragma mark - Method forwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.underlyingObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [(NSMutableArray *)self.invocations addObject:invocation];
}

@end
