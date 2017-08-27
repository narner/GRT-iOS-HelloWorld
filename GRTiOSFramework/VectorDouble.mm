//
//  VectorDouble.m
//  grt
//
//  Created by M J on 09/12/15.
//  Copyright © 2015 jahnen. All rights reserved.
//

#ifdef __cplusplus
#include "grt.h"
#endif

#import "VectorDouble.h"

@interface VectorDouble()
@property GRT::VectorDouble *instance;
@end

@implementation VectorDouble

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.instance = new GRT::VectorDouble;
    }
    return self;
}

- (instancetype)initWithSize:(NSInteger) size
{
    self = [super init];
    if (self) {
        self.instance = new GRT::VectorDouble(size);
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

- (GRT::VectorDouble *)cppInstance
{
    return self.instance;
}

@end
