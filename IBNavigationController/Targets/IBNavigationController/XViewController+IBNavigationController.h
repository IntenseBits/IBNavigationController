//
//  NSViewController+IBNavigationController.h
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBCrossPlatformHelpers.h"


@class IBNavigationController;
@class IBNavigationItem;

/**
 * Adds a navigation controller property along with a navigation item
 */
@interface X_VIEWCONTROLLER (IBNavigationController)

/**
 * Returns our navigation controller
 */
@property (nonatomic, weak) IBNavigationController *navController;

#ifdef IB_TARGET_PLATFORM_MAC
/**
 * Returns our navigation controller, allows our iOS code to run on mac
 */
@property (nonatomic, weak) IBNavigationController *navigationController;

#endif

/**
 * Represents the title and buttons that should be displayed when this view controller is top most
 */
@property (nonatomic, readonly) IBNavigationItem *navItem;

@end
