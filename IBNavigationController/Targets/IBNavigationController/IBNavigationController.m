//
//  IBNavigationController.m
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBNavController.h"
#import "IBNavigationProxyViewController.h"
#import "UIView+OSConstraints.h"
#import "XViewController+IBNavigationController.h"
#import "BFViewController.h"
#import "IBNavigationItem.h"

//We didnt find a view matching that tag so try and find a view with a matching identifier

#define TAG_TO_ID(TAG) [[NSString alloc] initWithFormat:@"%d",TAG]
#ifdef IB_TARGET_PLATFORM_MAC
#import "NSView+BFUtilities.h"

#endif




@interface IBNavigationItem (friend)

/**
 * Handles clicks on buttons, used internally
 */
@property (copy,nonatomic) IBNavigationItemButtonPressed buttonPressed_INTERNAL;


@end

@interface IBNavigationController ()
{
	
}

/**
 * We use this to draw over the actual content of our tab bar view controller, that we're only using in order to work with IB
 */
@property (strong,nonatomic)  IBNavigationProxyViewController* proxyVC;

@end
@implementation IBNavigationController




-(IBNavigationProxyViewController *)newProxyViewController
{
	NSBundle* bundle =nil;
	//Choose bundle
	//see if the main application bundle contains a nib called "IBNavigationProxyViewController"
	if (![[NSBundle mainBundle] pathForResource:@"IBNavigationProxyViewController" ofType:@"nib"])
	{
		//we use our own internal nib
		bundle = [NSBundle bundleForClass:self.class];
	}
	else
	{
		NSLog(@"Using custom navigation controller nib found in main bundle");
	}
	
	IBNavigationProxyViewController* vc = [[IBNavigationProxyViewController alloc] initWithNibName:nil bundle:bundle];
	
	return vc;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
	
	//set default if needed
	self.pushPopAnimationDuration = _pushPopAnimationDuration > 0 ? _pushPopAnimationDuration : kPushPopAnimationDuration;
	
#ifdef IB_TARGET_PLATFORM_MAC
	
	NSTabViewItem* item =  self.tabViewItems[self.selectedTabViewItemIndex];
	NSView* view = item.view;
	[view removeFromSuperview];
	NSViewController* rootViewController = item.viewController;
#else
	UIViewController* rootViewController = self.topViewController;
#endif

	
	
	[self commonInitWithRootViewController:rootViewController];
	dispatch_async(dispatch_get_main_queue(), ^{
		
#ifdef IB_TARGET_PLATFORM_MAC
		[self.view setNeedsLayout:YES];
#else
		[self.view setNeedsLayout];
#endif


		
	});
	
	self.delegate = self;
	
}
-(void)commonInitWithRootViewController:(X_VIEWCONTROLLER *)viewController
{
	
	
	
	NSMutableArray* array = @[].mutableCopy;
	[array addObject: viewController];
	self.viewControllers = array;
	
	
	if ([viewController respondsToSelector:@selector(setNavigationController:)]) {
		[viewController performSelector:@selector(setNavigationController:) withObject:self];
	}
	
	IBNavigationProxyViewController* vc = [self newProxyViewController];
	
	self.proxyVC = vc;
	
	__weak typeof(self) this= self;
	vc.buttonPressed = ^(NSInteger buttonTag)
	{
		if (buttonTag == BF_BUTTON_TAG_BACK)
		{
			[this popViewControllerAnimated:YES];
		}
		else
		{
			if (buttonTag == BF_BUTTON_TAG_BUTTON_1)
			{
				NSLog(@"Button 1 clicked");
			}
			else if (buttonTag == BF_BUTTON_TAG_BUTTON_2)
			{
				NSLog(@"Button 2 clicked");
			}
			
			//pass through to user code
			if (this.barButtonPressed)
			{
				this.barButtonPressed(buttonTag);
			}
		}
		
	};
	
	//See if we need to pull the information out of the storyboard and insert manually into
	//our navigation item
	[self extractToolbarButtonsFromViewController:vc];
	
	
	
	[self.view addSubviewWithAutoSizeConstraints:vc.view];
	
	//vc.view.frame = CGRectMake(0, 0, 100, 100);
	
	//otherwise we get strangeness the first time we push.
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.proxyVC.containerView addSubviewWithAutoSizeConstraints:self.topViewController.view];
		self.proxyVC.backButton.hidden = YES;
	});
	
	
	
	self.proxyVC.navigationItem = viewController.navItem;
	
	
	//	viewController.view.autoresizingMask = self.view.autoresizingMask;
	//	viewController.view.frame = self.view.bounds;
	//	[self.proxyVC addSubview:viewController.view];
	//
	// Initial controller will appear on startup
	if([viewController respondsToSelector:@selector(viewWillAppear:)]) {
		[(id<BFViewController>)viewController viewWillAppear:NO];
	}
	
}



-(NSView*)extractUserDefinedViewWithIdentifier:(NSString*)identifier fromViewController:(X_VIEWCONTROLLER*)viewController
{
	X_VIEW* view = viewController.view;

	for (NSView* subview in view.subviews)
	{
		NSString* thisID = subview.identifier;
		
		if ([thisID isEqualToString:identifier])
		{
			return subview;
		}
	}
	
	
	return nil;
}
/**
 * Attempts to create NavigationItem toolbar buttons from NSButton OR NSView instances defined in the storyboard
 * that are tagged with unique values.
 */
-(void)extractToolbarButtonsFromViewController:(X_VIEWCONTROLLER*)viewController
{
	IBNavigationItem* item = viewController.navItem;
	
	if (viewController.title)
	{
		item.title = viewController.title;
	}
	
	NSButton* userButton1 = (NSButton*)[viewController.view viewWithTag:TAG_TOOLBAR_BUTTON_1];
	NSButton* userButton2 = (NSButton*)[viewController.view viewWithTag:TAG_TOOLBAR_BUTTON_2];
	
	X_VIEW* userSuppliedView1 = [self extractUserDefinedViewWithIdentifier:TAG_TO_ID(TAG_TOOLBAR_BUTTON_1) fromViewController:viewController];
	X_VIEW* userSuppliedView2 = [self extractUserDefinedViewWithIdentifier:TAG_TO_ID(TAG_TOOLBAR_BUTTON_2) fromViewController:viewController];
	
	//for when we are popping back, we have already extracted the view from the view controller
	//CB: Dont think we need this anymore as we just are extracting stuff here, not actually using it
//	userSuppliedView1 = userSuppliedView1 ? userSuppliedView1 : item.userSuppliedToolBarView1;
//	userSuppliedView2 = userSuppliedView2 ? userSuppliedView2 : item.userSuppliedToolBarView2;
//	
	//store these for adding to the toolbar
	item.userSuppliedToolBarView1 = userSuppliedView1 ? userSuppliedView1 : item.userSuppliedToolBarView1;
	item.userSuppliedToolBarView2 = userSuppliedView2 ? userSuppliedView2 : item.userSuppliedToolBarView2;
	
	//handle backward journey, because we have removed the views from their original homes
	item.userSuppliedButton1 = userButton1 ? userButton1 : item.userSuppliedButton1;
	item.userSuppliedButton2 = userButton2 ? userButton2 : item.userSuppliedButton2;
	
	//we can now safely remove it from its original storyboard, if we are travelling backwards, this will also remove it from any view its currently in
	[userButton1 removeFromSuperview];
	[userButton2 removeFromSuperview];
	[userSuppliedView1 removeFromSuperview];
	[userSuppliedView2 removeFromSuperview];
	
	item.buttonPressed_INTERNAL = ^(X_BUTTON* button)
	{
		NSInteger tag = button.tag;
		
		NSLog(@"Firing segue: '%@'",SEGUE_ID_TOOLBAR_BUTTON_1);
		[viewController performSegueWithIdentifier:[[NSString alloc] initWithFormat:@"%lu",tag + 1000] sender:self];
		
	};
}


#ifdef IB_TARGET_PLATFORM_MAC


//Mostly copy + paste from the base BFNavigationController with a few changes for autolayout constraints
- (void)_navigateFromViewController:(X_VIEWCONTROLLER *)lastController
				   toViewController:(X_VIEWCONTROLLER *)newController
						   animated:(BOOL)animated
							   push:(BOOL)push
{
	//  newController.view.autoresizingMask = self.view.autoresizingMask;
	NSLog(@"Last %@",lastController.title);
	NSLog(@"Next %@",newController.title);
	//See if we need to pull the information out of the storyboard and insert manually into
	//our navigation item
	
	[self extractToolbarButtonsFromViewController:newController];
	//	id<BFNavigationControllerDelegate>_delegate = self.delegate;
	
	// Call delegate
	//	if (_delegate && [_delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
	//		[_delegate navigationController:self willShowViewController:newController animated:animated];
	//	}
	
	// New controller will appear
	if ([newController respondsToSelector:@selector(viewWillAppear:)]) {
		[(id<BFViewController>)newController viewWillAppear:animated];
	}
	
	// Last controller will disappear
	if ([lastController respondsToSelector:@selector(viewWillDisappear:)]) {
		[(id<BFViewController>)lastController viewWillDisappear:animated];
	}
	
	X_VIEW* container =self.proxyVC.containerView;
	CGRect newControllerStartFrame = container.bounds;
	CGRect lastControllerEndFrame = container.bounds;
	
	// Completion inline Block
	void(^navigationCompleted)(BOOL) = ^(BOOL animated) {
		// Call delegate
		//		if (_delegate && [_delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
		//			[_delegate navigationController:self didShowViewController:newController animated:animated];
		//		}
		
		// New controller did appear
		if ([newController respondsToSelector: @selector(viewDidAppear:)]) {
			[(id<BFViewController>)newController viewDidAppear:animated];
		}
		
		// Last controller did disappear
		if ([lastController respondsToSelector: @selector(viewDidDisappear:)]) {
			[(id<BFViewController>)lastController viewDidDisappear:animated];
		}
	};
	
	//hide our back button if we cant go back
	self.proxyVC.backButton.hidden = ([self.viewControllers count] == 1);
	
	
	
	if (animated)
	{
		newControllerStartFrame.origin.x = push ? newControllerStartFrame.size.width : -newControllerStartFrame.size.width;
		lastControllerEndFrame.origin.x = push ? -lastControllerEndFrame.size.width : lastControllerEndFrame.size.width;
		
		// Assign start frame
		newController.view.frame = newControllerStartFrame;
		
		// Remove last controller from superview
		[lastController.view removeFromSuperview];
		
		[container addSubviewWithAutoSizeConstraints:newController.view];
		
		// We use NSImageViews to cache animating views. Of course we could animate using Core Animation layers - Do it if you like that.
		NSImageView *lastControllerImageView = [[NSImageView alloc] initWithFrame:container.bounds];
		NSImageView *newControllerImageView = [[NSImageView alloc] initWithFrame:newControllerStartFrame];
		
		
		[lastControllerImageView setImage:[lastController.view flattenWithSubviews]];
		[newControllerImageView setImage:[newController.view flattenWithSubviews]];
		newController.view.hidden = YES;
		[container addSubview: lastControllerImageView];
		[container addSubview: newControllerImageView];
		
		// Animation 'block' - Using default timing function
		[NSAnimationContext beginGrouping];
		[[NSAnimationContext currentContext] setDuration:kPushPopAnimationDuration];
		[[lastControllerImageView animator] setFrame:lastControllerEndFrame];
		[[newControllerImageView animator] setFrame:container.bounds];
		[NSAnimationContext endGrouping];
		
		//        // Could have just called setCompletionHandler: on animation context if it was Lion only.
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, _pushPopAnimationDuration * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
			[lastControllerImageView removeFromSuperview];
			newController.view.hidden = NO;
			[newControllerImageView removeFromSuperview];
			
			self.proxyVC.navigationItem = newController.navItem;
			
			newController.view.frame = self.view.bounds;
			navigationCompleted(animated);
		});
	}
	else
	{
		newController.view.frame = newControllerStartFrame;
		[container addSubview:newController.view];
		[lastController.view removeFromSuperview];
		navigationCompleted(animated);
	}
}
//#pragma mark -
//#pragma mark BFNavigationController delegate
//
//-(void)navigationController:(BFNavigationController *)navigationController didShowViewController:(NSViewController *)viewController animated:(BOOL)animated
//{
//
//}
//
//-(void)navigationController:(BFNavigationController *)navigationController willShowViewController:(NSViewController *)viewController animated:(BOOL)animated
//{
//
//}


#endif



@end
