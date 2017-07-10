//
//  SecondViewController.swift
//  SodexoWallet
//
//  Created by Sujatha Nagarajan on 2/27/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import UIKit
class PaymentConfirmation: UIAlertController
{
} 


class SecondViewController: UIViewController {

	//Debug placeholder coupon inventory until the actual inventory gets ready.
	
	@IBOutlet weak var CurrentWorthValueLabel: UILabel!
	var CouponInventory: [UInt32:UInt32] = [:]
	@IBOutlet weak var CurrentBalanceValueLabel: UILabel!
	var redeemInventory: [UInt32:UInt32] = [:]

	var PayAlert = UIAlertController()
	
	// debug ends
	
	var TotalAmount:UInt32 = 0;
	
	// todo Displays the current remaining total amount calculated from all the coupons available for the user. This would help user guess how much more they could use from their coupons.
		
	
	//This action function is needed
	@IBAction func CalculateButtonClick(_ sender: UIButton, forEvent event: UIEvent) {
		SetTotalAmount();
	}
	
	@IBOutlet weak var AmountTextField: UITextField!
	
	@IBAction func PayButtonClick(_ sender: UIButton, forEvent event: UIEvent) {
		self.present(PayAlert, animated: true, completion: nil)
	}
	
	func InternalPay(){
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
		displayCurrentWorth() // Recalculate total remaining amount and display to user.
	}
	
	func displayCurrentWorth()
	{
		var Total : UInt32 = 0
		for(key, value) in CouponInventory{
			Total += (key * value)
		}
		
		CurrentWorthValueLabel.text = "\(Total)"
	}
	
	@IBOutlet weak var OutputText: UILabel!	
	 
	func SetTotalAmount(){
		// UInt32() cast handles negative values. Hence control will not enter the if condition block
		if let t = AmountTextField.text{
			if t != ""{
				if let amount = UInt32(t)  {
					TotalAmount = amount;				
					redeem();
				}
				else
				{
					OutputText.text = "Enter valid amount"
				}
			}
			else
			{
				OutputText.text = "Enter amount"
			}
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
			let SortedInventory = tempInventory.sorted(by: {(a,b) in 
									a.key > b.key; });

			for(key, value) in SortedInventory{
				if(Total < 5) { break; } 
				if(value == 0){ continue; }

				var Count = Total / key
				
				while(Count > value / 2 && Count != 1){
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
		
		if(Total == TotalAmount && CouponInventory.count > 0)
		{
			//Try to pay with the higher value coupon available and then inform that the balance they have to get back is such and such amount
			for(key, value) in tempInventory.sorted(by: {(a,b) in a.key > b.key; }) {
				if Total < key && value > 0 {
					Total = key - Total // Use one coupon
					redeemInventory[key] = 1;
					break;
				}
			}
			displayCouponsToRedeem("change you should get - \(Total)", Total : Total)
		}
		else{
			//Else the user has to pay extra cash. verify that and display.
			if verifyCalculation(Total) {
				displayCouponsToRedeem("cash you owe - \(Total)", Total : Total);
			}
			else
			{
				print("Error: calculation is wrong. recalculate");
			}
		}		
	}
	
	// Displays the coupons that user can use to pay the amount
	func displayCouponsToRedeem(_ cash : String, Total : UInt32){
		OutputText.text = "";
				
		for(key, value) in  redeemInventory{
			OutputText.text = OutputText.text! + "\(key) X \(value)\n";
		}
		if(Total > 0){
			OutputText.text = OutputText.text! + cash;
		}

	}
	
	//Verifies the calculated coupons to redeem. Does not display to user. Internal calculation only.
	func verifyCalculation(_ TotalRemaining : UInt32) -> Bool{
		var CalculatedTotal : UInt32 = 0
		for(key, value) in  redeemInventory{
				CalculatedTotal += (key * value)
		}
		CalculatedTotal += TotalRemaining;
		if(CalculatedTotal == TotalAmount){
			return true;
		}
		else{
			return false;
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		//debug
		debugAddCoupon(25, CouponCount: 1);
		debugAddCoupon(5, CouponCount: 5);
	//	debugAddCoupon(10, CouponCount: 20);
//		debugAddCoupon(25, CouponCount: 20);
//		debugAddCoupon(50, CouponCount: 40);
		debugAddCoupon(50, CouponCount: 4);
		displayCurrentWorth() // Display remaining amount so user can make educated guess if they want.
		
		//Alert box
		PayAlert = UIAlertController(title: "Are you sure?", message: "Proceed to pay?", preferredStyle: UIAlertControllerStyle.alert)
		let PayAlertAction = UIAlertAction(title: "Pay", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) -> Void in 
		self.InternalPay() })
		let CancelAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
		PayAlert.addAction(PayAlertAction)
		PayAlert.addAction(CancelAlertAction)
		
		
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
	
	// Called when touches begin in the view
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true);
	}

}

