/**
 *  StreetScapeScene.h
 *  StreetScape
 *
 *  Created by Robin Marshall on 8/01/13.
 *  Copyright __MyCompanyName__ 2013. All rights reserved.
 */


#import "CC3Scene.h"

/** A sample application-specific CC3Scene subclass.*/
@interface StreetScapeScene : CC3Scene {
    CC3Camera* cam;
    CGPoint dragStart;
    CC3Vector camStart, camDirStart;
}

@end
