//
//  ViewController.m
//  SubclassNavController-ObjC
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "ViewController.h"
@import IBNavigationController;

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view.
	
	//Handle our buttons being clicked
	self.navItem.buttonPressed = ^(NSButton* button)
	{
		if (button.tag == 1)
		{
			
			NSViewController* vc = [self.storyboard instantiateControllerWithIdentifier:@"CodeViewController"];
			[self.navController pushViewController:vc animated:YES];
		}
	};
}

- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];

	// Update the view, if already loaded.
}

@end
