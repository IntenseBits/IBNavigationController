 //
//  Segue.m
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//


#import "IBNavigationPushSegue.h"
#import "IBNavigationPushSegueAnimator.h"
#import "XViewController+IBNavigationController.h"
#import "IBNavController.h"
//#import "NSViewControllerPresentations-Swift.h"

@implementation IBNavigationPushSegue

- (void)perform {
    //Objective-C and Swift versions of animator both work
    //id animator1 = [[IBNavigationPushSegueAnimator alloc] init];
	
	NSViewController* controller =  self.sourceController;
	[controller.navController pushViewController:self.destinationController animated:YES];
	
//    id animator2 = [[IBNavigationPushSegueAnimator alloc] init];
//    [self.sourceController presentViewController:self.destinationController
//                                        animator:animator2];
}
@end
