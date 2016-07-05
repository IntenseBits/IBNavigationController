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
 * You can specify the toolbar buttons at design time in the storyboard. They are 
 * removed from their superviews and stored here
 */
@property (strong,nonatomic) X_VIEW* userSuppliedToolBarView1;
/**
 * You can specify the toolbar buttons at design time in the storyboard. They are
 * removed from their superviews and stored here
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
