//
//  IBNavigationItem.h
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBCrossPlatformHelpers.h"


/**
 * Handler signature for clicks on our buttons
 */
typedef void(^IBNavigationItemButtonPressed)(X_BUTTON* button);

@interface IBNavigationItem : NSObject


@property (copy,nonatomic) NSString* title;

@property (copy,nonatomic) NSString* button1Title;
@property (copy,nonatomic) NSString* button2Title;

/**
 * There are three ways to supply toolbar items in Interface builder.
 * 1) Define button titles as custom runtime attributes of the view controller and supply a block in code to handle the click
 * 2) Define NSButton, add it to the Root view and tag it 1001 or 1002 and drag a segue to the controller to push.
	  Certain properties of the button will be extracted and copied to our buttons we have defined in the
	  IBNavigationProxyViewController nib
 * 3) Define ANY NSView subclass, add it to the root view and set its Identifier to "1001" or "1002".
	  The view will be extracted and inserted into the navigation bar stack view, replacing the existing NSButton 1 or 2
 *	
 * If you supply more than one in IB The order in which they are used are top to bottom, i.e 3 overrides 1
 *
 */

#pragma mark -
#pragma mark NSButtons defined in Interface Builder as a subview of the root view AND tag specified
/**
 * You can specify the toolbar buttons at design time in the storyboard. They are
 * removed from their original superviews, stored here and used to dynamically modify the toolbar at
 * runtime
 */
@property (strong,nonatomic) NSButton* userSuppliedButton1;
/**
 * You can specify the toolbar buttons at design time in the storyboard. They are
 * removed from their original superviews, stored here and used to dynamically modify the toolbar at
 * runtime
 */
@property (strong,nonatomic) NSButton* userSuppliedButton2;
#pragma mark -
#pragma mark Custom views defined in Interface Builder as a subview of the root view AND Identifier specified
/**
 * You can specify the toolbar buttons at design time in the storyboard. They are
 * removed from their original superviews, stored here and used to dynamically modify the toolbar at
 * runtime
 */
@property (strong,nonatomic) X_VIEW* userSuppliedToolBarView1;
/**
 * You can specify the toolbar buttons at design time in the storyboard. They are
 * removed from their original superviews, stored here and used to dynamically modify the toolbar at
 * runtime
 */
@property (strong,nonatomic) X_VIEW* userSuppliedToolBarView2;


/**
 * Handles clicks on buttons
 */
@property (copy,nonatomic) IBNavigationItemButtonPressed buttonPressed;

/**
 * Called to fire blocks
 */
-(void)onButtonPressed:(X_BUTTON*)button;





@end
