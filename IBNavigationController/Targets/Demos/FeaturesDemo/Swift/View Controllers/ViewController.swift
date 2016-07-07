//
//  ViewController.swift
//  SubclassNavController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

import Cocoa
import IBNavigationController

class ViewController: NSViewController {

	@IBOutlet weak var txtName: NSTextField!
	
	@IBAction func sayHello(sender: NSButton)
	{
		let alert = NSAlert()
		alert.addButtonWithTitle("OK")
		let msg = "Hello \(txtName.stringValue)"
		alert.informativeText = msg
		alert.messageText = "Nice to meet you"
		alert.alertStyle = .InformationalAlertStyle
		alert.runModal()
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		
		//Handle our buttons being clicked
		self.navItem.buttonPressed = {(button) in
			if button.tag == 1
			{
				let vc = self.storyboard!.instantiateControllerWithIdentifier("CodeViewController") as! NSViewController
				self.navController.pushViewController(vc, animated: true)
			}
//			else if button.tag == 2
//			{
//				We dont do anything in this demo
//			}
		}
	}
	
	
	

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

