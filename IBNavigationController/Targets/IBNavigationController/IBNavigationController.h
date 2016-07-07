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
#define X_NAV_PROTOCOLS BFNavigationControllerDelegate
#else
#define X_NAV_BASE UINavigationController
#define X_NAV_PROTOCOLS UINavigationControllerDelegate
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


@interface IBNavigationController : X_NAV_BASE<X_NAV_PROTOCOLS>

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

@end
