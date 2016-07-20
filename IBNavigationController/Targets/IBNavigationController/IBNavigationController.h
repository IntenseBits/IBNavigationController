//
//  IBNavigationController.h
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBCrossPlatformHelpers.h"


#import "IBNavigationProxyViewController.h"


#ifdef IB_TARGET_PLATFORM_MAC
#import "BFNavigationController.h"
#define X_NAV_BASE BFNavigationController
//#define X_NAV_PROTOCOLS BFNavigationControllerDelegate
#else
#define X_NAV_BASE UINavigationController
//#define X_NAV_PROTOCOLS UINavigationControllerDelegate
#endif



static const CGFloat kPushPopAnimationDuration = 0.2;

/**
 * If using toolbar buttons defined in the storyboard, you must set the segue ID to this
 */
#define SEGUE_ID_TOOLBAR_BUTTON_1 @"1001"
/**
 * If using toolbar buttons defined in the storyboard, you must set the segue ID to this
 */
#define SEGUE_ID_TOOLBAR_BUTTON_2 @"1002"

/**
 * If using toolbar buttons defined in the storyboard, you must set the tag to this
 */
#define TAG_TOOLBAR_BUTTON_1 1001

/**
 * If using toolbar buttons defined in the storyboard, you must set the tag to this
 */
#define TAG_TOOLBAR_BUTTON_2 1002


@interface IBNavigationController : X_NAV_BASE//<X_NAV_PROTOCOLS>

/**
 * Controls the amount of time taken to push and pop.
 */
@property (assign,nonatomic) CGFloat pushPopAnimationDuration;

/**
 * Fired when user clicks on a bar button
 */
@property (copy,nonatomic) IBButtonPressed barButtonPressed;

/**
 * Inheritors can override in order to provide a custom UI look and feel
 */
-(IBNavigationProxyViewController*)newProxyViewController;



/**
 *  Pushes a view controller onto the receiver’s stack and updates the display.
 */
- (void)pushViewController:(NSViewController *)viewController animated:(BOOL)animated;

/**
 *  Pops the top view controller from the navigation stack and updates the display.
 */
- (NSViewController *)popViewControllerAnimated:(BOOL)animated;

/**
 *  Pops all the view controllers on the stack except the root view controller and updates the display.
 */
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

/**
 *  Pops view controllers until the specified view controller is at the top of the navigation stack.
 */
- (NSArray *)popToViewController:(NSViewController *)viewController animated:(BOOL)animated;


/**
 *  The reciever's delegate or nil.
 */
@property (nonatomic, assign) id<BFNavigationControllerDelegate> delegate;

@end
