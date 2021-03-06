/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

 @version $Id: WWBasicProgram.m 1476 2013-06-22 00:33:22Z dcollins $
 */

#import "WorldWind/Shaders/WWBasicProgram.h"
#import "WorldWind/Util/WWUtil.h"
#import "WorldWind/WWLog.h"

#define STRINGIFY(A) #A
#import "WorldWind/Shaders/BasicShader.vert"
#import "WorldWind/Shaders/BasicShader.frag"

@implementation WWBasicProgram

- (WWBasicProgram*) init
{
    self = [super initWithShaderSource:BasicVertexShader fragmentShader:BasicFragmentShader];

    vertexPointLocation = (GLuint) [self attributeLocation:@"vertexPoint"];
    mvpMatrixLocation = (GLuint) [self uniformLocation:@"mvpMatrix"];
    colorLocation = (GLuint) [self uniformLocation:@"color"];

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

- (GLuint) vertexPointLocation
{
    return vertexPointLocation;
}

- (void) loadModelviewProjection:(WWMatrix* __unsafe_unretained)matrix
{
    if (matrix == nil)
    {
        WWLOG_AND_THROW(NSInvalidArgumentException, @"Matrix is nil")
    }

    [WWGpuProgram loadUniformMatrix:matrix location:mvpMatrixLocation];
}

- (void) loadColor:(WWColor* __unsafe_unretained)color
{
    if (color == nil)
    {
        WWLOG_AND_THROW(NSInvalidArgumentException, @"Color is nil")
    }

    [WWGpuProgram loadUniformColor:color location:colorLocation];
}

- (void) loadPickColor:(unsigned int)color
{
    [WWGpuProgram loadUniformPickColor:color location:colorLocation];
}

@end