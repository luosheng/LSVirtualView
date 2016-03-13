//
//  LSVirtualNode.m
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import "LSVirtualNode.h"

@interface LSVirtualNode ()

@property (nonatomic, unsafe_unretained) Class underlyingClass;
@property (nonatomic, strong) NSMutableArray *invocations;

@end

@implementation LSVirtualNode

+ (NSMutableDictionary *)_mapping {
    static NSMutableDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = [NSMutableDictionary dictionary];
    });
    return mapping;
}

- (instancetype)initWithClass:(Class)class configuration:(LSVirtualNodeConfiguration)configuration {
    NSString *className = NSStringFromClass(class);
    if (self.class._mapping[className] == nil) {
        self.class._mapping[className] = [[class alloc] init];
    }
    
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
    for (id object in self.class._mapping.allValues) {
        if ([object respondsToSelector:sel]) {
            return [object methodSignatureForSelector:sel];
        }
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [self.invocations addObject:invocation];
}

@end
