//
//  VectorDouble.h
//  grt
//
//  Created by M J on 09/12/15.
//  Copyright © 2015 jahnen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VectorDouble : NSObject

- (instancetype)initWithSize:(NSInteger) size;

- (void)pushBack:(double)value;
- (void)clear;

#ifdef __cplusplus
- (GRT::VectorDouble *)cppInstance;
#endif

@end
