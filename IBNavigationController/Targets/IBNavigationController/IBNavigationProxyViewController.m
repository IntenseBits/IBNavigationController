//
//  IBNavigationProxyViewController.m
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBNavigationProxyViewController.h"
#import "IBNavigationItem.h"

@interface IBNavigationProxyViewController ()
@property (weak) IBOutlet X_STACKVIEW *stackViewRightButtons;
@property (weak) IBOutlet X_LABEL *lbTitle;



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



-(void)setNavigationItem:(IBNavigationItem *)navigationItem
{
	NSLog(@"Setting navitem %@",navigationItem);
	
	//ensure we have all the outlets we need
	NSAssert(_lbTitle, @"Nib file incorrect, no title label");
	NSAssert(_stackViewRightButtons, @"Nib file incorrect, no toolbar stack view");
	
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
	
	
	NSString* buttonText = navigationItem.button1Title;
	NSString* button2Text = navigationItem.button2Title;
	
	X_VIEW* storyboardView1 = navigationItem.userSuppliedToolBarView1;
	X_VIEW* storyboardView2 = navigationItem.userSuppliedToolBarView2;
	
	if (buttonText)
		setXButtonText(_button1, buttonText);
	//Or have we been given a custom view to insert into our stack?
	else if (storyboardView1)
	{
		[_stackViewRightButtons addArrangedSubview:storyboardView1];
	}
	
	if (button2Text)
		setXButtonText(_button2, button2Text);
	//Or have we been given a custom view to insert into our stack?
	else if (storyboardView2)
	{
		[_stackViewRightButtons addArrangedSubview:storyboardView2];
	}
	
	_button1.hidden = !(buttonText && ![buttonText isEqualToString:@""]);
	_button2.hidden = !(button2Text && ![button2Text isEqualToString:@""]);
	
	
	
	
}
-(void)onButtonPressed:(X_BUTTON*)button
{
	if (self.buttonPressed)
	{
		self.buttonPressed(button.tag);
	}
	
	[self.navigationItem onButtonPressed: button];
	
}

@end
