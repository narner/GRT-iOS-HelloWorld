//
//  GestureRecognitionPipeline.h
//  grt
//
//  Created by mjahnen on 25/11/15.
//  Copyright © 2015 jahnen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VectorDouble.h"

@interface GestureRecognitionPipeline : NSObject

@property (readonly, getter=predictedClassLabel) NSUInteger predictedClassLabel;
@property (readonly, getter=maximumLikelihood) double maximumLikelihood;

- (BOOL)load:(NSString *) path;
- (BOOL)predict:(VectorDouble *) inputVector;

@end
