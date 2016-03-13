//
//  LSVirtualPatch.h
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/14.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LSVirtualPatchTypeNone,
    LSVirtualPatchTypeNode,
    LSVirtualPatchTypeProperty,
    LSVirtualPatchTypeOrder,
    LSVirtualPatchTypeInsert,
    LSVirtualPatchTypeRemove,
} LSVirtualPatchType;

@interface LSVirtualPatch : NSObject

@property (nonatomic, assign) LSVirtualPatchType type;

@end
