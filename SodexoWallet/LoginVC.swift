//
//  LoginVC.swift
//  SodexoWallet
//
//  Created by Sujatha Nagarajan on 8/27/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import Foundation
import UIKit
import Security

class LoginVC: UIViewController {
	@IBOutlet weak var LoginImageView: UIImageView!
	@IBOutlet weak var RegisterButton: UIButton!
	@IBOutlet weak var LoginButton: UIButton!

	@IBOutlet weak var PasswordText: UITextField!
	@IBOutlet weak var EmailText: UITextField!
	@IBAction func LoginButtonPress(_ sender: Any) {
		guard let em = EmailText.text else { 
			EmailText.layer.borderColor = UIColor.red.cgColor
			return
		}
		
		guard let pw = PasswordText.text else {
			PasswordText.layer.borderColor = UIColor.red.cgColor
			return
		}
		
		let ExistingPassword = load(em as NSString);
		if(ExistingPassword as String == pw){
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let tabViewCtrl = storyboard.instantiateViewController(withIdentifier: "MainTabVC")
			//self.window?.makeKeyAndVisible()// step 1
			self.present(tabViewCtrl, animated: true, completion: nil)// step 2
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sodexo-bg1.jpg")!)
		if let image = UIImage.animatedImageNamed("LoginAnimation", duration: 1){
			self.LoginImageView.image = image
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func load(_ email: NSString) -> NSString {
		//let keyChainQuery: NSMutableDictionary = NSMutableDictionary(
		//https://stackoverflow.com/questions/37539997/save-and-load-from-keychain-swift
		if(email == "s@i.com"){
			return "Ss"
		}
		return ""
		//https://www.raywenderlich.com/92667/securing-ios-data-keychain-touch-id-1password
	}



}
