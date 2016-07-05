//
//  IBTargetConditionals.h
//  DesireSDK
//
//  Created by Chris Birch on 21/03/2015.
//  Copyright (c) 2015 desireitnow. All rights reserved.
//

/**
 * Simplifies cross platform (mac/ios) development
 */

#ifndef DesireSDK_IBTargetConditionals_h
#define DesireSDK_IBTargetConditionals_h


	#include "TargetConditionals.h"

	#if TARGET_IPHONE_SIMULATOR

		#define IB_TARGET_PLATFORM_IOS
		#define IB_TARGET_PLATFORM_IOS_SIMULATOR

@import UIKit;

	#elif TARGET_OS_IPHONE
		#define IB_TARGET_PLATFORM_IOS

	#else

		#define IB_TARGET_PLATFORM_MAC

	#endif

#ifdef IB_TARGET_PLATFORM_MAC
@import Cocoa;
#define X_VIEW NSView
#define X_COLOUR NSColor
#define X_BUTTON NSButton
#define X_VIEWCONTROLLER NSViewController
#define X_NAVIGATIONCONTROLLER IBNavigationController
#define X_STACKVIEW NSStackView
#define X_LABEL NSTextField
#define X_IMAGEVIEW NSImageView

/**
 * Used for simplfying cross platform (iOS/mac) code
 */
static inline void setXLabelText(X_LABEL* label, NSString* text)
{
	label.stringValue = text;
}
/**
 * Used for simplfying cross platform (iOS/mac) code
 */
static inline void setXButtonText(X_BUTTON* button, NSString* text)
{
	[button setTitle:text];
}
#else
@import UIKit;
#define X_VIEW UIView
#define X_COLOUR UIColor
#define X_BUTTON UIButton
#define X_VIEWCONTROLLER UIViewController
#define X_NAVIGATIONCONTROLLER UINavigationController
#define X_STACKVIEW UIStackView
#define X_LABEL UILabel
#define X_IMAGEVIEW UIImageView

/**
 * Used for simplfying cross platform (iOS/mac) code
 */
static inline void setXLabelText(X_LABEL* label, NSString* text)
{
	label.text = text;
}
/**
 * Used for simplfying cross platform (iOS/mac) code
 */
static inline void setXButtonText(X_BUTTON* button, NSString* text)
{
	[button setTitle:text forState: UIControlStateNormal];
}
#endif


#endif
