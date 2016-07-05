//
//  UIView+OSConstraints.h
//  Pods
//
//  Created by Chris Birch on 24/07/2014.
//
//

#import "IBCrossPlatformHelpers.h"


@interface X_VIEW (OSConstraints)

/**
 * Adds the specified subview as a child and adds constraints to size it to fill this view.
 */
-(NSLayoutConstraint*)addSubviewWithAutoSizeConstraints:(X_VIEW *)view;

@end
