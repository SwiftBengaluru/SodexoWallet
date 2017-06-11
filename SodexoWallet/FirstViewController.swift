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
    @IBOutlet weak var walletTableView: UITableView!
     
	 let couponArray:[String] = ["10", "20", "35", "50"]
	 let couponCount :[String] = ["10", "2", "5", "5"]
	 let couponAmount :[String] = ["100", "40", "35", "50"]
	override func viewDidLoad() {
		super.viewDidLoad()
        resetAllFields()
        
       // var walletAmount: [[String: AnyObject]]
        walletTableView.dataSource = self
    walletTableView.delegate = self
    walletTableView.register(UITableViewCell.self, forCellReuseIdentifier: "walletCell")
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
    }

    // ToDo: Calculate the total amount to be shown
    func calculateTotalAmount() {
        // value = type1 * count1 + type2 * count2
    }

    // ToDo: Save the total amount to Wallet
    func saveAmount() {
//        walletAmount = [["couponName":"10","couponCount":5],
//                        ["couponName":"20","couponCount":15],
//                        ["couponName":"35","couponCount":15],
//                        ["couponName":"50","couponCount":10]]
   }
    
    
    func resetAllFields() {
       //reset the Wallet table view
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

// MARK: - UITableViewDelegate
extension FirstViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource
extension FirstViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 4
        //couponName count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell",
                                                 for: indexPath) as! UITableViewCell
        
        //coupon name
        //coupon count
        //coupon amount
       //  cell.couponName?.text = "Section \(indexPath.section) Row \(indexPath.row)"
       // let row = indexPath.row
		
		cell.textLabel?.text = "Ramya"
//        cell.couponName.text = couponArray[indexPath.item] //denomination
//        cell.couponCount?.text = couponCount[indexPath.item] //count
//        cell.couponAmount.text = couponAmount[indexPath.item]
        
        return cell
    }
}
