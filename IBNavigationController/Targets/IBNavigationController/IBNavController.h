//
//  IBNavigationController.h
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//
#import "IBCrossPlatformHelpers.h"



//! Project version number for IBNavigationController.
FOUNDATION_EXPORT double IBNavigationControllerVersionNumber;

//! Project version string for IBNavigationController.
FOUNDATION_EXPORT const unsigned char IBNavigationControllerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IBNavigationController/PublicHeader.h>



#import "IBNavigationController.h"
#import "IBNavigationItem.h"
#import "XViewController+IBNavigationController.h"
#import "IBNavigationProxyViewController.h"
#import "BFViewController.h"
#import "NSView+Helpers.h"
#import "IBView.h"


#ifdef IB_TARGET_PLATFORM_MAC
#import "IBNavigationPushSegue.h"
#import "IBNavigationPushSegueAnimator.h"

#else

#endif


