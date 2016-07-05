//
//  IBNavigationPushSegueAnimator.m
//  BFNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//
//  indirectly taken from from this Swift example
//  http://stackoverflow.com/questions/26715636/animate-custom-presentation-of-viewcontroller-in-os-x-yosemite

#import "IBNavigationPushSegueAnimator.h"

@implementation IBNavigationPushSegueAnimator

- (void)animatePresentationOfViewController:(X_VIEWCONTROLLER *)viewController fromViewController:(X_VIEWCONTROLLER *)fromViewController {
    
    X_VIEWCONTROLLER* bottomVC = fromViewController;
    X_VIEWCONTROLLER* topVC = viewController;
    
    // make sure the view has a CA layer for smooth animation
    topVC.view.wantsLayer = YES;
    
    // set redraw policy
    topVC.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    // start out invisible
    topVC.view.alphaValue = 0;
    
    // add view of presented viewcontroller
    [bottomVC.view addSubview:topVC.view];


    // adjust size and colour
    CGRect frame = NSRectToCGRect(bottomVC.view.frame);
    frame = CGRectInset(frame, 40, 40);
    [topVC.view setFrame:NSRectFromCGRect(frame)];
    topVC.view.layer.backgroundColor = [NSColor grayColor].CGColor;
    
    // Do some CoreAnimation stuff to present view
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.5;
        topVC.view.animator.alphaValue = 1;
    } completionHandler:nil];
    
}

- (void)animateDismissalOfViewController:(X_VIEWCONTROLLER *)viewController fromViewController:(X_VIEWCONTROLLER *)fromViewController {
    
    //NSViewController* bottomVC = fromViewController;
    NSViewController* topVC = viewController;
    
    // make sure the view has a CA layer for smooth animation
    topVC.view.wantsLayer = YES;
    
    // set redraw policy
    topVC.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    // Do some CoreAnimation stuff to present view
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.5;
        topVC.view.animator.alphaValue = 0;
    } completionHandler:^{
        [topVC.view removeFromSuperview];
    }];

}

@end
