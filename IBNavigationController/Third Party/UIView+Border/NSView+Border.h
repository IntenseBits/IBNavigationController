//
//  UIView+Border.h
//  Ocasta Studios
//
//  Created by Chris Birch on 08/04/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

@import Cocoa;

IB_DESIGNABLE
@interface NSView (Border)

@property(nonatomic,assign) IBInspectable NSColor* borderColour;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (weak,nonatomic) IBInspectable NSColor* backgroundColour;
@end
