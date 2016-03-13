//
//  LSVirtualPatch.m
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/14.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import "LSVirtualPatch.h"

@implementation LSVirtualPatch

- (instancetype)initWithType:(LSVirtualPatchType)type node:(LSVirtualNode *)node patch:(id)patch {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _type = type;
    _node = node;
    _patch = patch;
    
    return self;
}

@end
