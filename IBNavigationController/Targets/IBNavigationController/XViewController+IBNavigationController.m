//
//  NSViewController+IBNavigationController.m
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "XViewController+IBNavigationController.h"
#import <objc/runtime.h>
#import "IBNavController.h"
#import "IBNavigationItem.h"

@implementation X_VIEWCONTROLLER (IBNavigationController)


#ifdef IB_TARGET_PLATFORM_MAC
-(IBNavigationController *)navigationController
{
	return self.navController;
}

-(void)setNavigationController:(IBNavigationController *)navigationController
{
	self.navController = navigationController;
}

#endif



/**
 * Associates our navigation controller
 */
- (void)setNavController:(IBNavigationController *)navigationController
{
	objc_setAssociatedObject(self, @selector(navController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}

/**
 * Retrieves the navigation controller that hosts this controller
 */
- (IBNavigationController *)navController
{
	return objc_getAssociatedObject(self, @selector(navController));
}



- (IBNavigationItem *)navItem
{
	IBNavigationItem* item = objc_getAssociatedObject(self, @selector(navigationItem));
	
	if (!item)
	{
		item = [[IBNavigationItem alloc] init];
		[self _setNavigationItem: item];
	}
	
	return item;
}

- (void)_setNavigationItem:(IBNavigationItem *)navigationItem
{
	objc_setAssociatedObject(self, @selector(navigationItem), navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
