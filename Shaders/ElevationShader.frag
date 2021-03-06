const char* ElevationShadingFragmentShader = STRINGIFY(
/* Copyright (C) 2001, 2012 United States Government as represented by
the Administrator of the National Aeronautics and Space Administration.
All Rights Reserved.
*/

/*
 * version $Id: ElevationShader.frag 1603 2013-09-16 17:16:07Z tgaskins $
 */

precision mediump float;

uniform float yellowThreshold;
uniform float redThreshold;
uniform float opacity;

varying mediump float elevation;

void main()
{
  const vec4 yellow = vec4(1, 1, 0, 1);
  const vec4 red = vec4(1, 0, 0, 1);
  const vec4 transparent = vec4(0, 0, 0, 0);

    if (elevation < yellowThreshold)
        gl_FragColor = transparent;
    else if (elevation < redThreshold)
        gl_FragColor = yellow * opacity;
    else
        gl_FragColor = red * opacity;
}
);