/**
 *  StreetScapeLayer.m
 *  StreetScape
 *
 *  Created by Robin Marshall on 8/01/13.
 *  Copyright __MyCompanyName__ 2013. All rights reserved.
 */

#import "StreetScapeLayer.h"
#import "StreetScapeScene.h"
#import "cocos2d.h"


@implementation StreetScapeLayer {
    CGPoint location;
    
}

- (void)dealloc {
    [super dealloc];
}


/**
 * Override to set up your 2D controls and other initial state.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) initializeControls {
 
    NSString *title = @"Bananas";
    CCLabelTTF* label = [CCLabelTTF labelWithString:title fontName:@"MarkerFelt" fontSize:32];
    CCSprite* sprite = [CCSprite spriteWithFile:@"Icon.png"];
    
    
    label.position = ccp(240, 160);
    label.color = ccc3(255, 0, 0);
    
    sprite.position = ccp(240, 160);
    sprite.color = ccc3(255, 0, 0);
    
    [self addChild:label];
    
    self.isTouchEnabled = true;
    
    UIPanGestureRecognizer *swipeGes = [[UIPanGestureRecognizer alloc]autorelease]; //using PanGesture as im going to be "dragging" the objects using touch.
    [swipeGes initWithTarget: self action: @selector(handleDrag:)];
    swipeGes.minimumNumberOfTouches = 1; //activates one CC3Node
    swipeGes.maximumNumberOfTouches = 1; //activates both CC3Nodes - so can be dragged using multiple touch location at the same time
    [self cc3AddGestureRecognizer: swipeGes];
    
}


-(void)handleDrag:(UIPanGestureRecognizer*)gesture{
    switch(gesture.state){
        case UIGestureRecognizerStateBegan:
            NSLog(@"Touch Began");
            location = [gesture locationOfTouch:0 inView:nil]; //first touch saved in location1

            [self.cc3Scene setDragStart: location];
            break;
        case UIGestureRecognizerStatePossible:
            NSLog(@"It's possible");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"It's cancelled");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"It's failed");
            break;
        case UIGestureRecognizerStateChanged: //swiping
            location = [gesture locationOfTouch:0 inView:nil]; //first touch saved in location1
            CGPoint velocity = [gesture velocityInView:gesture.view];

            [self.cc3Scene startDragAt: location velocity:velocity]; //calls the method from the cc3scene class so will move my first object based    on finger location.
                       
            break;
             case UIGestureRecognizerStateEnded:
                             NSLog(@"Touch Ended");
                             break;
                             }
}
#pragma mark Updating layer

/**
 * Override to perform set-up activity prior to the scene being opened
 * on the view, such as adding gesture recognizers.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) onOpenCC3Layer {}

/**
 * Override to perform tear-down activity prior to the scene disappearing.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) onCloseCC3Layer {}

/**
 * The ccTouchMoved:withEvent: method is optional for the <CCTouchDelegateProtocol>.
 * The event dispatcher will not dispatch events for which there is no method
 * implementation. Since the touch-move events are both voluminous and seldom used,
 * the implementation of ccTouchMoved:withEvent: has been left out of the default
 * CC3Layer implementation. To receive and handle touch-move events for object
 * picking, uncomment the following method implementation.
 */
/*
-(void) ccTouchMoved: (UITouch *)touch withEvent: (UIEvent *)event {
	[self handleTouch: touch ofType: kCCTouchMoved];
}
 */

@end
