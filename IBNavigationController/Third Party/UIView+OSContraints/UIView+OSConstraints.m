//
//  UIView+OSConstraints.m
//  Pods
//
//  Created by Chris Birch on 24/07/2014.
//
//

#import "UIView+OSConstraints.h"

@implementation X_VIEW (OSConstraints)


-(NSLayoutConstraint*)addSubviewWithAutoSizeConstraints:(X_VIEW *)view
{
 
    view.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:view positioned:NSWindowAbove relativeTo:nil];
	
	
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0]];

	NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:view.superview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
	[self addConstraint:bottom];
	
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
	
	[self setNeedsUpdateConstraints:YES];
	[view setNeedsUpdateConstraints:YES];
	
	
	
	return bottom;
    

}

@end
