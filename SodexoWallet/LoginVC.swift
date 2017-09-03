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

struct KeychainConfiguration {
	static let serviceName = "MyAppService"
	static let accessGroup = "SodexoWallet.com.example.apple"
}

struct KeychainPasswordItem {

	enum KeychainError: Error {
		case noPassword
		case unexpectedPasswordData
		case unexpectedItemData
		case unhandledError(status: OSStatus)
	}
	
	let service: String
	private(set) var account: String
	let accessGroup: String?
	
	init(service: String, account: String, accessGroup: String? = nil) {
		self.service = service
		self.account = account
		self.accessGroup = accessGroup
	}
	
	func Save(_ password: String) throws { 
	
		let encodedPassword = password.data(using: String.Encoding.utf8)!
		
		do {
			try _ = readPassword()
			
			var attributesToUpdate = [String : AnyObject]()
			attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
			let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
			
			let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
			
			guard status == noErr else {
				throw KeychainError.unhandledError(status: status) 
			}
		}
			
		catch KeychainError.noPassword {
				//create new
				
				var newItem = KeychainPasswordItem.keychainQuery(withService: self.service, account: self.account, accessGroup: self.accessGroup)
				
				newItem[kSecValueData as String] = encodedPassword as AnyObject?
				
				let status = SecItemAdd(newItem as CFDictionary, nil)
				
				guard status == noErr else { 
					throw KeychainError.unhandledError(status: status) 
				}
		}
	}
	
	func readPassword() throws -> String {
		var query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
		
		query[kSecMatchLimit as String] = kSecMatchLimitOne
		query[kSecReturnAttributes as String] = kCFBooleanTrue
		query[kSecReturnData as String] = kCFBooleanTrue
		
		var queryResult: AnyObject?
		
		let status = withUnsafeMutablePointer(to: &queryResult) { 
			SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
		}
		
		guard status != errSecItemNotFound else {
			throw KeychainError.noPassword 
		}
		
		guard status == noErr else {
			throw KeychainError.unhandledError(status: status) 
		}
		
		// Parse
		
		guard let existingItem = queryResult as? [String : AnyObject],
				let passwordData = existingItem[kSecValueData as String] as? Data,
				let password = String(data: passwordData, encoding: String.Encoding.utf8)
		else {
			throw KeychainError.unexpectedPasswordData
		}
		
		return password
	} // read password
	
	private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] { 
		var query = [String : AnyObject]()
		
		query[kSecClass as String] = kSecClassGenericPassword
		query[kSecAttrService as String] = service as AnyObject?
		
		if let account = account { 
			query[kSecAttrAccount as String] = account as AnyObject?
		}
		
		if let accessGroup = accessGroup {
			query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
		}
		
		return query
		
 	} // keychainQuery
}

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
			SaveToKeyChain(em, Password: pw);
		
		
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
	
	// https://developer.apple.com/library/content/samplecode/GenericKeychain/Introduction/Intro.html
	func load(_ email: NSString) -> NSString {
		//let keyChainQuery: NSMutableDictionary = NSMutableDictionary(
		//https://stackoverflow.com/questions/37539997/save-and-load-from-keychain-swift
		if(email == "s@i.com"){
			return "Ss"
		}
		return ""
		//https://www.raywenderlich.com/92667/securing-ios-data-keychain-touch-id-1password
	}
	
	func SaveToKeyChain(_ Email: String, Password: String) -> Void {
		//Create a new entry
		do { 
			let newItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: Email, accessGroup: KeychainConfiguration.accessGroup)
			try newItem.Save(Password)
		}
		catch {
			fatalError("error saving login credentials - \(error)")
		}
	}



}
