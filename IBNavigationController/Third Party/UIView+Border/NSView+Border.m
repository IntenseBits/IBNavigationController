//
//  UIView+Border.m
//  Ocasta Studios
//
//  Created by Chris Birch on 08/04/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import "NSView+Border.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSView (Border)


-(void)setBackgroundColour:(NSColor *)backgroundColour
{
	self.wantsLayer = YES;
	self.layer.backgroundColor = backgroundColour.CGColor;
}

-(NSColor *)backgroundColour
{
	NSColor* colour = [NSColor colorWithCGColor:self.layer.backgroundColor];
	
	if (!colour)
	{
		colour = [NSColor clearColor];
	}
	
	return colour;
	
}

-(void)setBorderColour:(NSColor*)borderColour
{
	self.wantsLayer = YES;
    self.layer.borderColor = borderColour.CGColor;
}
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
	self.wantsLayer = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(NSColor*)borderColour
{
    return [NSColor colorWithCGColor:self.layer.borderColor];
}


-(void)setBorderWidth:(CGFloat)borderWidth
{
	self.wantsLayer = YES;
    self.layer.borderWidth = borderWidth;
    
}

-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
@end
