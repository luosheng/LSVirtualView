//
//  LSVirtualNode.h
//  LSVirtualView
//
//  Created by Luo Sheng on 16/3/13.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LSVirtualNodeConfiguration)(__weak id object);

@interface LSVirtualNode : NSProxy

- (instancetype)initWithClass:(Class)class configuration:(LSVirtualNodeConfiguration)configuration;

- (id)create;

@end
