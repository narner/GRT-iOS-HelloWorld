//
//  GestureRecognitionPipeline.h
//  grt
//
//  Created by mjahnen on 25/11/15.
//  Copyright © 2015 jahnen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GestureRecognitionPipeline : NSObject

@property (readonly, getter=predictedClassLabel) NSUInteger predictedClassLabel;
@property (readonly, getter=maximumLikelihood) double maximumLikelihood;

- (BOOL)load:(NSURL *) url;
- (BOOL)predict:(VectorDouble *) inputVector;

@end
