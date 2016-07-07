//
//  ViewController.m
//  SubclassNavController-ObjC
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@import IBNavigationController;

@interface ViewController ()
{
	
}

@property (weak) IBOutlet NSTextField *txtName;

@end
@implementation ViewController

- (IBAction)SayHello:(NSButton *)sender
{
	NSAlert *alert = [[NSAlert alloc] init];
	[alert addButtonWithTitle:@"OK"];
	NSString* msg = [[NSString alloc] initWithFormat:@"Hello %@",_txtName.stringValue];
	[alert setMessageText:@"Nice to meet you"];
	[alert setInformativeText:msg];
	[alert setAlertStyle:NSInformationalAlertStyle];
	//[alert beginSheetModalForWindow:[self window] modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
	
	[alert runModal];
}


- (void)viewDidLoad
{
	[super viewDidLoad];

	// Do any additional setup after loading the view.
	
	//Handle our buttons being clicked
	self.navItem.buttonPressed = ^(NSButton* button)
	{
		if (button.tag == 1)
		{
			
			NSViewController* vc =
			[self.storyboard instantiateControllerWithIdentifier:@"CodeViewController"];
			[self.navController pushViewController:vc animated:YES];
		}
//		else if(button.tag == 2)
//		{
//			We dont do anything in this demo
//		}
	};
}



- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];

	// Update the view, if already loaded.
}

@end
