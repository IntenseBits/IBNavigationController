//
//  IBNavigationProxyViewController.m
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBNavigationProxyViewController.h"
#import "IBNavigationItem.h"
@import QuartzCore;

@interface IBNavigationProxyViewController ()



#ifdef IB_TARGET_PLATFORM_MAC
#else
/**
 * This is the actual nav controller that does all the hard work on 
 * iOS
 */
@property (weak,nonatomic) UINavigationController* navController;
#endif


@end

@implementation IBNavigationProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
	
}
- (IBAction)buttonPressed:(X_BUTTON *)sender
{
	[self onButtonPressed: sender];
}


#pragma mark -
#pragma mark Toolbar item views defined in Interface Builder




/**
 * There are three ways to supply toolbar items in Interface builder.
 * 1) Define button titles as custom runtime attributes of the view controller and supply a block in code to handle the click
 * 2) Define NSButton, add it to the Root view and tag it 1001 or 1002 and drag a segue to the controller to push.
 *	  Certain properties of the button will be extracted and copied to our buttons we have defined in the
 *	  IBNavigationProxyViewController nib
 * 3) Define ANY NSView subclass, add it to the root view and set its Identifier to "1001" or "1002".
 * The view will be extracted and inserted into the navigation bar stack view, replacing the existing NSButton 1 or 2
 *
 * If you supply more than one in IB The order in which they are used are top to bottom, i.e 3 overrides 1
 *
 */
-(void)dealWithButton:(NSButton*)defaultButton userButton:(NSButton*)userButton userTitle:(NSString*)userTitle userView:(NSView*)userView
{
	//we show the button if the user code hasnt supplied a custom NSView with an identifier
	defaultButton.hidden = NO;
	
	if (userView)
	{
		//User code has supplied us with a NSView to replace our default button defined in the nib
		
		//hide the button as we are "replacing" it
		defaultButton.hidden = YES;
		
		//add our view
		[_stackViewRightButtons addArrangedSubview:userView];
		
		
	}
	else if(userButton)
	{
		//User code has supplied us with a NSButton whose values will replace those of our default button defined in the nib
		NSButton* d = defaultButton;
		NSButton* u = userButton;
		
#ifdef IB_TARGET_PLATFORM_MAC
	
		d.title = u.title;
#else
		//	[item setValue:button.titleLabel.text forKey:path];
#endif
		
		
	
		
	}
	else if (userTitle)
	{
		//User code has supplied us with the title of this button
		defaultButton.title = userTitle;
		
		defaultButton.hidden = [userTitle isEqualToString:@""];
	}
	else
	{
		//We dont have an item
		defaultButton.hidden = YES;
	}
}



#pragma mark -
#pragma mark <#Sectionname#>


#define BUTTON_ANIMATION_TIME 0.15

-(void)setNavigationItem:(IBNavigationItem *)navigationItem
{
	NSLog(@"Setting navitem %@",navigationItem);
	
	//ensure we have all the outlets we need
	NSAssert(_lbTitle, @"Nib file incorrect, no title label");
	NSAssert(_stackViewRightButtons, @"Nib file incorrect, no toolbar stack view");
	
	
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context){
		context.duration = BUTTON_ANIMATION_TIME;
		context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
		self.stackViewRightButtons.animator.alphaValue = 0;
	} completionHandler:^
	{
		if (_navigationItem)
		{
			//Remove custom views if needed
			[_navigationItem.userSuppliedToolBarView1 removeFromSuperview];
			[_navigationItem.userSuppliedToolBarView2 removeFromSuperview];
		}
		
		_navigationItem = navigationItem;
		
		if (navigationItem.title)
		{
			setXLabelText(_lbTitle, navigationItem.title);
		}
		else
			setXLabelText(_lbTitle, @"");
		
		
		NSString* userButtonTitle1 = navigationItem.button1Title;
		NSString* userButtonTitle2 = navigationItem.button2Title;
		X_VIEW* userView1 = navigationItem.userSuppliedToolBarView1;
		X_VIEW* userView2 = navigationItem.userSuppliedToolBarView2;
		NSButton* userButton1 = navigationItem.userSuppliedButton1;
		NSButton* userButton2 = navigationItem.userSuppliedButton2;
		
		//We configure our toolbar items based on information from the user supplied storyboard viewcontroller
		[self dealWithButton:_button1 userButton:userButton1 userTitle:userButtonTitle1 userView:userView1];
		[self dealWithButton:_button2 userButton:userButton2 userTitle:userButtonTitle2 userView:userView2];
		
		
		
		[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context){
			context.duration = BUTTON_ANIMATION_TIME;
			context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
			self.stackViewRightButtons.animator.alphaValue = 1;
		} completionHandler:^
		 {
		
		 }];
		
	}];
	
	
	
	
	
	
	
	
	
	
}
-(void)onButtonPressed:(X_BUTTON*)button
{
	if (self.buttonPressed)
	{
		self.buttonPressed(button.tag);
	}
	
	[self.navigationItem onButtonPressed: button];
	
}


-(void)navigationController:(IBNavigationController *)navigationController willShowViewController:(NSViewController *)viewController animated:(BOOL)animated
{
	
}

-(void)navigationController:(IBNavigationController *)navigationController didShowViewController:(NSViewController *)viewController animated:(BOOL)animated
{
	
}

@end
