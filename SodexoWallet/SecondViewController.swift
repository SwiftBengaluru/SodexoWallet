//
//  SecondViewController.swift
//  SodexoWallet
//
//  Created by Sujatha Nagarajan on 2/27/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

	var TotalAmount:UInt32 = 0;
	@IBOutlet weak var AmountTextField: UITextField!
	@IBAction func PayButtonClick(_ sender: UIButton, forEvent event: UIEvent) {
		SetTotalAmount();
	}
	
	@IBOutlet weak var OutputText: UILabel!
	@IBAction func AmountTextValueChanged(_ sender: Any) {
		SetTotalAmount()
	}
	@IBAction func AmountTextEditingEnded(_ sender: UITextField, forEvent event: UIEvent) {
			SetTotalAmount();
	}
	
	func SetTotalAmount()
	{
		if let t = AmountTextField.text, t != "", let amount = UInt32(t)  {
			TotalAmount = amount;				
			print(TotalAmount)
			OutputText.text = String(TotalAmount) + " X 1"// Debug
		}
	

	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

