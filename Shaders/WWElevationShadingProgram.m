/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.
 
 @version $Id: WWElevationShadingProgram.m 1603 2013-09-16 17:16:07Z tgaskins $
 */

#import "WWElevationShadingProgram.h"
#import "WWUtil.h"

#define STRINGIFY(A) #A
#import "WorldWind/Shaders/ElevationShader.vert"
#import "WorldWind/Shaders/ElevationShader.frag"

@implementation WWElevationShadingProgram

- (WWElevationShadingProgram*) init
{
    self = [super initWithShaderSource:ElevationShadingVertexShader fragmentShader:ElevationShadingFragmentShader];

    yellowThresholdLocation = (GLuint) [self uniformLocation:@"yellowThreshold"];
    redThresholdLocation = (GLuint) [self uniformLocation:@"redThreshold"];
    opacityLocation = (GLuint) [self uniformLocation:@"opacity"];

    return self;
}

+ (NSString*) programKey
{
    static NSString* key = nil;
    if (key == nil)
    {
        key = [WWUtil generateUUID];
    }

    return key;
}

- (void) loadYellowThreshold:(float)yellowThreshold
{
    [WWGpuProgram loadUniformFloat:yellowThreshold location:yellowThresholdLocation];
}

- (void) loadRedThreshold:(float)redThreshold
{
    [WWGpuProgram loadUniformFloat:redThreshold location:redThresholdLocation];
}

- (void) loadOpacity:(float)opacity
{
    [WWGpuProgram loadUniformFloat:opacity location:opacityLocation];
}

@end