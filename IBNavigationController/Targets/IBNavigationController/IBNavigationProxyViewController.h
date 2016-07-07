//
//  IBNavigationProxyViewController.h
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//


#import "IBCrossPlatformHelpers.h"

#define BF_BUTTON_TAG_BACK 99999
#define BF_BUTTON_TAG_BUTTON_1 1
#define BF_BUTTON_TAG_BUTTON_2 2

@class IBNavigationItem,IBNavigationController;

typedef void(^IBButtonPressed)(NSInteger tag);


/**
 * The view controller that we use to show the navigation controller bar and container view.
 * The view from this is inserted over the top of the NSTabViewControllers view and its first Tabs view controller
 * is used as the root view controller.
 * In order to provide a custmised UI experience, you can do the one or both of the following:
 * 1) Copy the IBNavigationProxyViewController.nib into your bundle and modify.
 * 2) Subclass this class
 */
@interface IBNavigationProxyViewController : X_VIEWCONTROLLER

/**
 * The length of time we perform our alpha animations on the title and buttons
 */
@property (assign,nonatomic) NSTimeInterval buttonAnimationDuration;

@property (weak) IBOutlet NSStackView *stackViewRightButtons;
@property (weak) IBOutlet NSTextField *lbTitle;

@property (weak) IBOutlet NSView *containerView;
@property (weak) IBOutlet NSButton *backButton;
@property (weak) IBOutlet NSButton *button1;
@property (weak) IBOutlet NSButton *button2;

@property (weak,nonatomic) IBNavigationItem* navigationItem;
@property (copy,nonatomic) IBButtonPressed buttonPressed;

#pragma mark -
#pragma mark BFNavigationController Delegate

/**
 *  Sent to the receiver just after the navigation controller displays a view controller’s view and navigation item properties.
 */
- (void)navigationController:(IBNavigationController *)navigationController
	   didShowViewController:(NSViewController *)viewController
					animated:(BOOL)animated;

/**
 *  Sent to the receiver just before the navigation controller displays a view controller’s view and navigation item properties.
 */
- (void)navigationController:(IBNavigationController *)navigationController
	  willShowViewController:(NSViewController *)viewController
					animated:(BOOL)animated;

@end
