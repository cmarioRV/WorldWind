/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.
 
 @version $Id: WWBMNGLayer.m 1492 2013-06-29 00:21:29Z tgaskins $
 */

#import "WorldWind/Layer/WWBMNGLayer.h"
#import "WorldWind/Geometry/WWSector.h"
#import "WorldWind/Geometry/WWLocation.h"
#import "WorldWind/Util/WWWMSUrlBuilder.h"
#import "WWWMSLayerExpirationRetriever.h"
#import "WorldWind/WorldWind.h"

@implementation WWBMNGLayer

- (WWBMNGLayer*) init
{
    NSString* layerName = @"BlueMarble-200405";
    NSString* serviceAddress = @"http://worldwind25.arc.nasa.gov/wms";

    NSString* cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* cachePath = [cacheDir stringByAppendingPathComponent:@"BMNG"];

    self = [super initWithSector:[[WWSector alloc] initWithFullSphere]
                  levelZeroDelta:[[WWLocation alloc] initWithDegreesLatitude:45 longitude:45]
                       numLevels:5
            retrievalImageFormat:@"image/jpeg"
                       cachePath:cachePath];
    [self setDisplayName:@"Blue Marble"];
    [self setImageFile:@"BlueMarble"];

    WWWMSUrlBuilder* urlBuilder = [[WWWMSUrlBuilder alloc] initWithServiceAddress:serviceAddress
                                                                       layerNames:layerName
                                                                       styleNames:@""
                                                                       wmsVersion:@"1.3.0"];
    [self setUrlBuilder:urlBuilder];

    NSArray* layerNames = [[NSArray alloc] initWithObjects:layerName, nil];
    WWWMSLayerExpirationRetriever* expirationChecker =
            [[WWWMSLayerExpirationRetriever alloc] initWithLayer:self
                                                      layerNames:layerNames
                                                  serviceAddress:serviceAddress];
    [[WorldWind loadQueue] addOperation:expirationChecker];

    return self;
}

@end