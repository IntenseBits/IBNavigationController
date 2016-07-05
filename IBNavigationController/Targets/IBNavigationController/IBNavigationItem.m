//
//  IBNavigationItem.m
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBNavigationItem.h"

@interface IBNavigationItem ()

/**
 * Handles clicks on buttons, used internally
 */
@property (copy,nonatomic) IBNavigationItemButtonPressed buttonPressed_INTERNAL;


@end

@implementation IBNavigationItem


-(void)onButtonPressed:(X_BUTTON*)button
{
	if (self.buttonPressed)
	{
		self.buttonPressed(button);
	}
	
	//fire our internal one
	if (self.buttonPressed_INTERNAL)
		self.buttonPressed_INTERNAL(button);
	
}

-(NSString *)description
{
	NSString* tool1 = self.button1Title ? self.button1Title : self.userSuppliedToolBarView1 ? self.userSuppliedToolBarView1.description : @"None";
	NSString* tool2 = self.button1Title ? self.button2Title : self.userSuppliedToolBarView2 ? self.userSuppliedToolBarView2.description : @"None";
	return [[NSString alloc] initWithFormat:@"Navigation Item: %@ [Toolbar Items: %@, %@]",self.title,tool1,tool2];
}
@end
