//
//  MyCustomNavigationController.m
//  NavControllerTest
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "MyCustomNavigationController.h"
@import IBNavigationController;

@interface MyCustomNavigationController ()

@end

@implementation MyCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(IBNavigationProxyViewController *)newProxyViewController
{
	return  [[IBNavigationProxyViewController alloc] initWithNibName:@"MyCustomNavProxyViewController" bundle:nil];
}
@end
