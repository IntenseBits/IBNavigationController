//
//  MyCustomNavigationController.swift
//  SubclassSwift
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

import Cocoa
import IBNavigationController
class MyCustomNavigationController: IBNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	override func newProxyViewController() -> IBNavigationProxyViewController!
	{
		//Here we return our custom subclass of the proxy 
		return  IBNavigationProxyViewController(nibName: "MyCustomNavProxyViewController", bundle: nil)
	}
	
}
