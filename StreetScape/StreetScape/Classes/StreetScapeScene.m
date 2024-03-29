/**
 *  StreetScapeScene.m
 *  StreetScape
 *
 *  Created by Robin Marshall on 8/01/13.
 *  Copyright __MyCompanyName__ 2013. All rights reserved.
 */

#import "StreetScapeScene.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "cocos2d.h"

#import "BuildingOverlayViewController.h"
#import "StreetScapeAppDelegate.h"

@implementation StreetScapeScene

-(void) dealloc {
	[super dealloc];
}

/**
 * Constructs the 3D scene.
 *
 * Adds 3D objects to the scene, loading a 3D 'hello, world' message
 * from a POD file, and creating the camera and light programatically.
 *
 * When adapting this template to your application, remove all of the content
 * of this method, and add your own to construct your 3D model scene.
 *
 * NOTE: The POD file used for the 'hello, world' message model is fairly large,
 * because converting a font to a mesh results in a LOT of triangles. When adapting
 * this template project for your own application, REMOVE the POD file 'hello-world.pod'
 * from the Resources folder of your project!!
 */
-(void) initializeScene {
    
	// Create the camera, place it back a bit, and add it to the scene
	cam = [CC3Camera nodeWithName: @"Camera"];
	cam.location = cc3v( 0.0, 0.5, 6.0 );
	[self addChild: cam];
    
	// Create a light, place it back and to the left at a specific
	// position (not just directional lighting), and add it to the scene
	CC3Light* lamp = [CC3Light nodeWithName: @"Lamp"];
	lamp.location = cc3v( -2.0, 0.0, 0.0 );
	lamp.isDirectionalOnly = NO;
	[cam addChild: lamp];
    
	// This is the simplest way to load a POD resource file and add the
	// nodes to the CC3Scene, if no customized resource subclass is needed.
	[self addContentFromPODResourceFile: @"long-street.pod"];
  	[self addContentFromPODResourceFile: @"casa-simple.pod"];
	
	// Create OpenGL ES buffers for the vertex arrays to keep things fast and efficient,
	// and to save memory, release the vertex data in main memory because it is now redundant.
	[self createGLBuffers];
	[self releaseRedundantData];
	
	// That's it! The scene is now constructed and is good to go.
	
	// If you encounter problems displaying your models, you can uncomment one or more of the
	// following lines to help you troubleshoot. You can also use these features on a single node,
	// or a structure of nodes. See the CC3Node notes for more explanation of these properties.
	// Also, the onOpen method below contains additional troubleshooting code you can comment
	// out to move the camera so that it will display the entire scene automatically.
	
	// Displays short descriptive text for each node (including class, node name & tag).
	// The text is displayed centered on the pivot point (origin) of the node.
    //	self.shouldDrawAllDescriptors = YES;
	
	// Displays bounding boxes around those nodes with local content (eg- meshes).
    //	self.shouldDrawAllLocalContentWireframeBoxes = YES;
	
	// Displays bounding boxes around all nodes. The bounding box for each node
	// will encompass its child nodes.
    //	self.shouldDrawAllWireframeBoxes = YES;
	
	// If you encounter issues creating and adding nodes, or loading models from
	// files, the following line is used to log the full structure of the scene.
	LogCleanDebug(@"The structure of this scene is: %@", [self structureDescription]);
	
	// ------------------------------------------
    
	// But to add some dynamism, we'll animate the 'hello, world' message
	// using a couple of cocos2d actions...
	
	// Fetch the 'hello, world' 3D text object that was loaded from the
	// POD file and start it rotating
   	CC3MeshNode* house = (CC3MeshNode*)[self getNodeNamed: @"casa-simple.pod"];
    house.isTouchEnabled = true;
    house.scale=cc3v(0.05, 0.05, 0.05);
    house.rotation=cc3v(0.0,90.0,100.0);
    [house translateBy: cc3v(-0.7, 0.2, 0.0)];
    
    CC3MeshNode* opphouse = [house copyWithName: @"opphouse"];
    [self addChild: opphouse];
    opphouse.rotation = cc3v(0.0,270.0,100.0);
    [opphouse translateBy: cc3v(1.4, 0.0, 0.5)];

    CC3MeshNode* opphouse2 = [opphouse copyWithName: @"opphouse2"];
    [self addChild: opphouse2];
    [opphouse2 translateBy: cc3v(0.0, 0.0, 0.5)];

    CC3MeshNode* opphouse3 = [opphouse copyWithName: @"opphouse3"];
    [self addChild: opphouse3];
    [opphouse3 translateBy: cc3v(0.0, 0.0, -1.5)];

    
    CC3MeshNode* opphouse4 = [opphouse copyWithName: @"opphouse4"];
    [self addChild: opphouse4];
    [opphouse4 translateBy: cc3v(0.0, 0.0, 1.2)];

    
    CC3MeshNode* opphouse5 = [opphouse copyWithName: @"opphouse5"];
    [self addChild: opphouse5];
    [opphouse5 translateBy: cc3v(0.0, 0.0, 2.5)];

    
    
    CC3MeshNode* house2 = [house copyWithName: @"house2"];
    [self addChild: house2];
    [house2 translateBy: cc3v(0.0, 0.0, 0.5)];
    
    CC3MeshNode* house3 = [house copyWithName: @"house3"];
    [self addChild: house3];
    [house3 translateBy: cc3v(0.0, 0.0, 1.5)];
  
    CC3MeshNode* house4 = [house copyWithName: @"house4"];
    [self addChild: house4];
    [house4 translateBy: cc3v(0.0, 0.0, 2.25)];

    CC3MeshNode* house5 = [house copyWithName: @"house5"];
    [self addChild: house5];
    [house5 translateBy: cc3v(0.0, 0.0, -3.5)];
    
    CC3MeshNode* house6 = [house copyWithName: @"house6"];
    [self addChild: house6];
    [house6 translateBy: cc3v(0.0, 0.0, -5.5)];
    
    CC3MeshNode* house7 = [house copyWithName: @"house7"];
    [self addChild: house7];
    [house7 translateBy: cc3v(0.0, 0.0, -1.25)];
    
    CC3MeshNode* houseHolder;
    for(int i=0; i<6; i++) {
        houseHolder = [house copy];
        [houseHolder translateBy: cc3v(0.0, 0.0, i*2)];
        [self addChild: houseHolder];

    }
    
    
	CC3MeshNode* helloTxt = (CC3MeshNode*)[self getNodeNamed: @"Hello"];
	CCActionInterval* partialRot = [CC3RotateBy actionWithDuration: 1.0
														  rotateBy: cc3v(0.0, 0.0, 30.0)];
	//[cam runAction: [CCRepeatForever actionWithAction: partialRot]];
	
	// To make things a bit more appealing, set up a repeating up/down cycle to
	// change the color of the text from the original red to blue, and back again.
	GLfloat tintTime = 8.0f;
	ccColor3B startColor = helloTxt.color;
	ccColor3B endColor = { 50, 0, 200 };
	CCActionInterval* tintDown = [CCTintTo actionWithDuration: tintTime
														  red: endColor.r
														green: endColor.g
														 blue: endColor.b];
	CCActionInterval* tintUp = [CCTintTo actionWithDuration: tintTime
														red: startColor.r
													  green: startColor.g
													   blue: startColor.b];
    CCActionInterval* tintCycle = [CCSequence actionOne: tintDown two: tintUp];
	[helloTxt runAction: [CCRepeatForever actionWithAction: tintCycle]];
    
    NSString *title = @"Bananas";
    //CCLabelTTF* label = [CCLabelTTF labelWithString:title fontName:@"AppleGothic" fontSize:32];
    CCSprite* sprite = [CCSprite spriteWithFile:@"Icon.png"];
    
    
   // label.position = ccp(240, 160);
    //label.color = ccc3(255, 0, 0);
    
    //sprite.position = ccp(240, 160);
    //sprite.color = ccc3(255, 0, 0);
    
    //[self addChild:sprite];
    
}


#pragma mark Updating custom activity

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides your app with an opportunity to perform update activities before
 * any changes are applied to the transformMatrix of the 3D nodes in the scene.
 *
 * For more info, read the notes of this method on CC3Node.
 */
-(void) updateBeforeTransform: (CC3NodeUpdatingVisitor*) visitor {}

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides your app with an opportunity to perform update activities after
 * the transformMatrix of the 3D nodes in the scen have been recalculated.
 *
 * For more info, read the notes of this method on CC3Node.
 */
-(void) updateAfterTransform: (CC3NodeUpdatingVisitor*) visitor {
	// If you have uncommented the moveWithDuration: invocation in the onOpen: method,
	// you can uncomment the following to track how the camera moves, and where it ends up,
	// in order to determine where to position the camera to see the entire scene.
    //	LogDebug(@"Camera location is: %@", NSStringFromCC3Vector(activeCamera.globalLocation));
}


#pragma mark Scene opening and closing

/**
 * Callback template method that is invoked automatically when the CC3Layer that
 * holds this scene is first displayed.
 *
 * This method is a good place to invoke one of CC3Camera moveToShowAllOf:... family
 * of methods, used to cause the camera to automatically focus on and frame a particular
 * node, or the entire scene.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) onOpen {
    
	// Uncomment this line to have the camera move to show the entire scene. This must be done after the
	// CC3Layer has been attached to the view, because this makes use of the camera frustum and projection.
	// If you uncomment this line, you might also want to uncomment the LogDebug line in the updateAfterTransform:
	// method to track how the camera moves, and where it ends up, in order to determine where to position
	// the camera to see the entire scene.
    //	[self.activeCamera moveWithDuration: 3.0 toShowAllOf: self];
    
	// Uncomment this line to draw the bounding box of the scene.
    //	self.shouldDrawWireframeBox = YES;
}

/**
 * Callback template method that is invoked automatically when the CC3Layer that
 * holds this scene has been removed from display.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) onClose {}


#pragma mark Handling touch events

/**
 * This method is invoked from the CC3Layer whenever a touch event occurs, if that layer
 * has indicated that it is interested in receiving touch events, and is handling them.
 *
 * Override this method to handle touch events, or remove this method to make use of
 * the superclass behaviour of selecting 3D nodes on each touch-down event.
 *
 * This method is not invoked when gestures are used for user interaction. Your custom
 * CC3Layer processes gestures and invokes higher-level application-defined behaviour
 * on this customized CC3Scene subclass.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) touchEvent: (uint) touchType at: (CGPoint) touchPoint {
    switch (touchType) {
		case kCCTouchBegan:
			break;
		case kCCTouchMoved:
			break;
		case kCCTouchEnded:
			[touchedNodePicker pickNodeFromTouchEvent: touchType at: touchPoint];
			break;
		default:
			break;
	}
  //  LogCleanDebug(@"Tapped!: %@", touchType);
}

-(void) startDragAt: (CGPoint) touchPoint velocity: (CGPoint) velocity {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    cam.nearClippingDistance = 0.1;
    
    //LogCleanDebug(@"dragging: %@", NSStringFromCGPoint([cam cc3ConvertUIPointToNodeSpace: touchPoint]));
    //LogCleanDebug(@"dragging: %@ %@ %@", NSStringFromCGPoint(touchPoint), NSStringFromCGPoint(velocity), NSStringFromCGPoint
      //            (dragStart));
    LogCleanDebug(@"dur: %@ %f %f", NSStringFromCGPoint(touchPoint), camDirStart.x, cam.forwardDirection.x);

    //LogCleanDebug(@"camera: %f %f %f", cam.nearClippingDistance, cam.farClippingDistance, cam.location.z);
    int deltaY = dragStart.y-touchPoint.y;
    int deltaX = dragStart.x-touchPoint.x;
    
    float xpos = -(touchPoint.x - screenWidth/2) / (screenWidth/2);
    
    //LogCleanDebug(@"campos: %f %f %f", deltaY/200.1, deltaY, cam.location.y);
    
    float minCamera = -4.0;
    float maxCamera = 11.0;
    
    float maxFD = 0.70;
    float minFD = -0.7;
    
    if (camStart.z+deltaY/100.1 > maxCamera) {
        cam.location = cc3v(0.0, 0.5, maxCamera);
    } else if (camStart.z+deltaY/100.1 < minCamera) {
        cam.location = cc3v(0.0, 0.5, minCamera);
    } else {
        cam.location = cc3v(0.0, 0.5, camStart.z+deltaY/100.1);
    }

    if (camDirStart.x+deltaX/600.1 > maxFD) {
        cam.forwardDirection = cc3v(maxFD, 0.0, -1.0);
    } else if (camDirStart.x+deltaX/600.1 < minFD) {
        cam.forwardDirection = cc3v(minFD, 0.0, -1.0);
    } else {
        cam.forwardDirection = cc3v(camDirStart.x+deltaX/600.1, 0.0, -1.0);

    }
//    cam.forwardDirection = cc3v(xpos, 0.0, -1.0);

}

-(void) setDragStart: (CGPoint) touchPoint {

    dragStart = touchPoint;
    camStart =  cam.location;
    camDirStart = cam.forwardDirection;
}

/**
 * This callback template method is invoked automatically when a node has been picked
 * by the invocation of the pickNodeFromTapAt: or pickNodeFromTouchEvent:at: methods,
 * as a result of a touch event or tap gesture.
 *
 * Override this method to perform activities on 3D nodes that have been picked by the user.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) nodeSelected: (CC3Node*) aNode byTouchEvent: (uint) touchType at: (CGPoint) touchPoint {
    LogCleanDebug(@"Tapped!: %@", aNode.name);
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Building selected"
//                                                    message:aNode.name
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
    
    
    BuildingOverlayViewController *vc = [[BuildingOverlayViewController alloc] initWithNibName:nil bundle:nil];
    StreetScapeAppDelegate *appDelegate = (StreetScapeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
    
    
}

@end

