//
//  LSVirtualPatch.h
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/14.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSVirtualNode;

typedef enum : NSUInteger {
    LSVirtualPatchTypeNone,
    LSVirtualPatchTypeNode,
    LSVirtualPatchTypeProperty,
    LSVirtualPatchTypeOrder,
    LSVirtualPatchTypeInsert,
    LSVirtualPatchTypeRemove,
} LSVirtualPatchType;

@interface LSVirtualPatch : NSObject

- (instancetype)initWithType:(LSVirtualPatchType)type node:(LSVirtualNode *)node patch:(id)patch;

@property (nonatomic, assign) LSVirtualPatchType type;

@property (nonatomic, strong) LSVirtualNode *node;

@property (nonatomic, strong) id patch;

@end
