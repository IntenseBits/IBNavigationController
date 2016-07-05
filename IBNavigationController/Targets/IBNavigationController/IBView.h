//
//  IBView.h
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBCrossPlatformHelpers.h"

IB_DESIGNABLE
@interface IBView : X_VIEW

@property(nonatomic,assign) IBInspectable X_COLOUR* borderColour;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (weak,nonatomic) IBInspectable X_COLOUR* backgroundColour;
@end
