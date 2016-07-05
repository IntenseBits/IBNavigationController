//
//  IBView.m
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBView.h"

@interface IBView ()

@property (weak,nonatomic) IBView* proxyForIB;

@end
@implementation IBView



-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
	IBView* view =[super awakeAfterUsingCoder:aDecoder];
	
	
#if !TARGET_INTERFACE_BUILDER
	// connect to the server
#else
	IBView* proxy = [[IBView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	view.proxyForIB = proxy;
	
	[view addSubview:proxy];
#endif
	
	return view;
}

-(void)prepareForInterfaceBuilder
{
	_proxyForIB.borderWidth = self.borderWidth;
	_proxyForIB.backgroundColour = self.backgroundColour;
	_proxyForIB.cornerRadius = self.cornerRadius;
	_proxyForIB.borderColour = self.borderColour;
}

-(void)setupForOSX
{
#ifdef IB_TARGET_PLATFORM_MAC
	self.wantsLayer = YES;
#endif
}

-(void)setBackgroundColour:(X_COLOUR *)backgroundColour
{
	
	[self setupForOSX];
	
	self.layer.backgroundColor = backgroundColour.CGColor;
}

-(X_COLOUR *)backgroundColour
{
	CGColorRef ref = self.layer.backgroundColor;
	X_COLOUR* colour = nil;
	
	if (!ref)
	{
		colour = [X_COLOUR clearColor];
		
	}
	else
	{
		colour = [X_COLOUR colorWithCGColor:ref];
	}
	
	return colour;
	
}

-(void)setBorderColour:(X_COLOUR*)borderColour
{
	[self setupForOSX];
	self.layer.borderColor = borderColour.CGColor;
}
-(CGFloat)cornerRadius
{
	return self.layer.cornerRadius;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
	[self setupForOSX];
	self.layer.cornerRadius = cornerRadius;
}

-(X_COLOUR*)borderColour
{
	CGColorRef ref = self.layer.borderColor;
	X_COLOUR* colour = nil;
	
	if (!ref)
	{
		colour = [X_COLOUR clearColor];
		
	}
	else
	{
		colour = [X_COLOUR colorWithCGColor:ref];
	}
	
	return colour;
}


-(void)setBorderWidth:(CGFloat)borderWidth
{
	[self setupForOSX];
	self.layer.borderWidth = borderWidth;
	
}

-(CGFloat)borderWidth
{
	return self.layer.borderWidth;
}



//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//    
//    // Drawing code here.
//}

@end
