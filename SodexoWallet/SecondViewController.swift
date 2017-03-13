//
//  SecondViewController.swift
//  SodexoWallet
//
//  Created by Sujatha Nagarajan on 2/27/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

	//Debug placeholder coupon inventory until the actual inventory gets ready.
	
	var CouponInventory: [UInt32:UInt32] = [:]
	var redeemInventory: [UInt32:UInt32] = [:]

	
	// debug ends
	
	var TotalAmount:UInt32 = 0;
	@IBAction func CalculateButtonClick(_ sender: UIButton, forEvent event: UIEvent) {
		SetTotalAmount();
	}
	@IBOutlet weak var AmountTextField: UITextField!
	
	@IBAction func PayButtonClick(_ sender: UIButton, forEvent event: UIEvent) {
		for(key, value) in redeemInventory{
			CouponInventory[key] = CouponInventory[key]! - value;
			if CouponInventory[key]! == 0{
				CouponInventory.removeValue(forKey: key)
			}
			else{
				print("\(key) - \(CouponInventory[key]!)")
			}
		}
		OutputText.text = ""
		redeemInventory = [:]
	}
	
	@IBOutlet weak var OutputText: UILabel!
	@IBAction func AmountTextValueChanged(_ sender: Any) {
		SetTotalAmount()
	}
	
	@IBAction func AmountTextEditingEnded(_ sender: UITextField, forEvent event: UIEvent) {
		SetTotalAmount();
	}
	 
	func SetTotalAmount(){
		if let t = AmountTextField.text, t != "", let amount = UInt32(t)  {
			TotalAmount = amount;				
			redeem();
		}
	

	}


	func redeem(){
		//todo prioritize picking 
		var Total = TotalAmount;
		redeemInventory = [:]
		var tempInventory = CouponInventory
		var Attempts = 0;
		while(Total > 5 && Attempts < 5){
			Attempts += 1
			var SortedInventory = tempInventory.sorted(by: {(a,b) in 
									a.key > b.key; });

			for(key, value) in SortedInventory{
				if(Total < 5) { break; } 
				
				print(key , " " , value);
				
				var Count = Total / key
				
				while(Count > value / 2){
					Count = Count / 2; // reduce to keep 
				}
				
				if(Count == 0){ continue; }
				
				Total = Total - ( Count * key )
				
				if(redeemInventory[key] != nil){
					redeemInventory[key] = redeemInventory[key]! + Count;
				}
				else{
					redeemInventory[key] = Count;
				}
				tempInventory[key] = tempInventory[key]! - Count
			}
		}
		
		print("total : \(Total)")
		OutputText.text = "";
		for(key, value) in  redeemInventory{
			print("\(key) - \(value)");
			OutputText.text = OutputText.text! + "\(key) X \(value)\n";
		}
		if(Total > 0){
			OutputText.text = OutputText.text! + "cash - \(Total)"
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		//debug
		debugAddCoupon(25, CouponCount: 10);
		debugAddCoupon(5, CouponCount: 50);
		debugAddCoupon(10, CouponCount: 20);
		debugAddCoupon(25, CouponCount: 20);
		debugAddCoupon(50, CouponCount: 40);
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func debugAddCoupon(_ CouponValue : UInt32, CouponCount : UInt32)
	{
		if CouponInventory[CouponValue] != nil{ 
			CouponInventory[CouponValue] = CouponInventory[CouponValue]! + CouponCount
		}
		else{
			CouponInventory[CouponValue] = CouponCount;
		}
	}

}

