//
//  LSVirtualNodeDiffHelper.h
//  LSVirtualView
//
//  Created by Luo Sheng on 3/14/16.
//  Copyright © 2016 Luo Sheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSVirtualNode.h"
#import "LSVirtualPatch.h"

@interface LSVirtualNodeDiffHelper : NSObject

+ (NSArray<LSVirtualPatch *> *)diff:(LSVirtualNode *)a withAnotherNode:(LSVirtualNode *)b;

+ (NSArray<LSVirtualPatch *> *)diffProperties:(LSVirtualNode *)a withAnotherNode:(LSVirtualNode *)b;

+ (NSArray<LSVirtualPatch *> *)diffChildren:(LSVirtualNode *)a withAnotherNode:(LSVirtualNode *)b;

@end
