//
//  WalletModel.swift
//  SodexoWallet
//
//  Created by M, Ramya on 4/15/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import Foundation

class Wallet{
    
    var denomination:NSNumber
    var count:NSNumber
    
    init (denomination:NSNumber,count:NSNumber){
        
        self.denomination = denomination
        self.count = count
    }
}
