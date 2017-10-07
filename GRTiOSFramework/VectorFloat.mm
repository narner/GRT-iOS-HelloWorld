//
//  VectorFloat.m
//  GRTiOS
//
//  Created by Nicholas Arner on 8/22/17.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "grt.h"
#endif

#import "VectorFloat.h"

@interface VectorFloat()
@property GRT::VectorFloat *instance;
@end

@implementation VectorFloat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.instance = new GRT::VectorFloat;
    }
    return self;
}

- (instancetype)initWithSize:(NSInteger) size
{
    self = [super init];
    if (self) {
        self.instance = new GRT::VectorFloat(size);
    }
    return self;
}

- (void)dealloc
{
    delete self.instance;
}

- (void)pushBack:(double) value
{
    self.instance->push_back(value);
}

- (void)clear
{
    self.instance->clear();
}

- (GRT::VectorFloat *)cppInstance
{
    return self.instance;
}

@end
