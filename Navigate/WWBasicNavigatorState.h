/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

 @version $Id: WWBasicNavigatorState.h 1494 2013-07-08 21:07:27Z tgaskins $
 */

#import <Foundation/Foundation.h>
#import "WorldWind/Navigate/WWNavigatorState.h"

@class WorldWindView;
@class WWMatrix;
@class WWVec4;
@class WWFrustum;

/**
* Provides an implementation of the WWNavigatorState protocol.
*/
@interface WWBasicNavigatorState : NSObject<WWNavigatorState>
{
@protected
    // The inverses of the modelview, projection, and concatenated modelview-projection matrices.
    WWMatrix* modelviewInv;
    WWMatrix* projectionInv;
    WWMatrix* modelviewProjectionInv;
    // The bounds for the view associated with the navigator.
    CGRect viewBounds;
    // Constants computed during initialization and used in pixelSizeAtDistance.
    double pixelSizeScale;
    double pixelSizeOffset;
}

/// @name Navigator State Attributes

/// The navigator's modelview matrix.
@property (nonatomic, readonly) WWMatrix* modelview;

/// The navigator's projection matrix.
@property (nonatomic, readonly) WWMatrix* projection;

/// The navigator's combined modelview - projection matrix.
@property (nonatomic, readonly) WWMatrix* modelviewProjection;

/// The navigator's viewport rectangle in OpenGL screen coordinates.
///
/// The viewport is in the OpenGL screen coordinate system of the WorldWindView, with its origin in the bottom-left
/// corner and axes that extend up and to the right from the origin point.
@property (nonatomic, readonly) CGRect viewport;

/// The navigator's eye point in model coordinates.
@property (nonatomic, readonly) WWVec4* eyePoint;

/// The navigator's forward vector in model coordinates.
@property (nonatomic, readonly) WWVec4* forward;

/// The navigator's forward-ray in model coordinates.
@property (nonatomic, readonly) WWLine* forwardRay;

/// The navigator's frustum in model coordinates.
@property (nonatomic, readonly) WWFrustum* frustumInModelCoordinates;

/// The number of degrees of heading clockwise relative to north.
@property (nonatomic, readonly) double heading;

/// The number of degrees the globe is tilted relative to its surface being parallel to the screen.
@property (nonatomic, readonly) double tilt;

/// @name Initializing Navigator State

/**
* Initializes this navigator state.
*
* @param modelviewMatrix The navigator's modelview matrix.
* @param projectionMatrix The navigator's projection matrix.
* @param view The World Wind view associated with the navigator. This view defines the navigator's viewport.
* @param heading The number of degrees clockwise from north to which the view is directed.
* @param tilt The number of degrees the globe is tilted relative to its surface being parallel to the screen.
*
* @return The initialized instance.
*
* @exception NSInvalidArgumentException If any argument is nil.
*/
- (WWBasicNavigatorState*) initWithModelview:(WWMatrix*)modelviewMatrix
                                  projection:(WWMatrix*)projectionMatrix
                                        view:(WorldWindView*)view
                                     heading:(double)heading
                                        tilt:(double)tilt;

@end