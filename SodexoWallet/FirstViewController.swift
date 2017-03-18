//
//  FirstViewController.swift
//  SodexoWallet
//
//  Created by Sujatha Nagarajan on 2/27/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBOutlet weak var tenCountAmount: UILabel!
    @IBOutlet weak var twentyCountAmount: UILabel!
    @IBOutlet weak var thirtyFiveCountAmount: UILabel!
    @IBOutlet weak var fiftyCountAmount: UILabel!
    
    @IBOutlet weak var tenCount: UITextField?
    @IBOutlet weak var twentyCount: UITextField?
    @IBOutlet weak var thirtyFiveCount: UITextField?
    @IBOutlet weak var fiftyCount: UITextField?
    
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        tenCount?.delegate = self
        twentyCount?.delegate = self
        thirtyFiveCount?.delegate = self
        fiftyCount?.delegate = self
        
        resetAllFields()
        
       // var walletAmount: [[String: AnyObject]]
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func resetTapped(_ sender: Any) {
        print("Reset")
        resetAllFields()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        print("Save")
        //  calculateTotalAmount()
        //  saveAmount()
        printAmount()
    }
  
    
    // ToDo: Calculate the individual total to be shown
    func printAmount() {
       // value = type * count , ex: 30 = 10*3
        tenCountAmount.text = "\(10 * 5)"
        twentyCountAmount.text = "\(20 * 5)"
        thirtyFiveCountAmount.text = "\(35*5)"
        fiftyCountAmount.text = "\(50*5)"
    }

    // ToDo: Calculate the total amount to be shown
    func calculateTotalAmount() {
        // value = type1 * count1 + type2 * count2
    }

    // ToDo: Save the total amount to Wallet
//    func saveAmount() {
//        walletAmount = [["couponName":"10","couponCount":5],
//                        ["couponName":"20","couponCount":15],
//                        ["couponName":"35","couponCount":15],
//                        ["couponName":"50","couponCount":10]]
//    }
    
    
    func resetAllFields() {
        tenCount?.text = ""
        twentyCount?.text = ""
        thirtyFiveCount?.text = ""
        fiftyCount?.text = ""
        tenCountAmount.text = "0.0"
        twentyCountAmount.text = "0.0"
        thirtyFiveCountAmount.text = "0.0"
        fiftyCountAmount.text = "0.0"
        totalAmount.text = "0.0"
    }
    
}

extension FirstViewController : UITextFieldDelegate {
   // ToDo: Add Done button and resign Software Keyboard on screen touch
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
