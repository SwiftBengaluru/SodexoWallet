//
//  WalletUtility.swift
//  SodexoWallet
//
//  Created by M, Ramya on 4/15/17.
//  Copyright © 2017 SwiftBengaluru. All rights reserved.
//

import Foundation
import UIKit

class WalletUtility{
    
    let documentDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    // #MARK:- Plist Path In Bundle And Doc
    //**************************************
    var plistPathInBundle =  Bundle.main.path(forResource: "Wallet", ofType: "plist") as String!
    
    var plistPathInDoc:String
    {
        let docDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0]
        return docDirPath.appending("/Wallet.plist")
    }
    
    // #MARK:- Copy Plist From Bundle To Doc
    //***************************************
    func copyPlistBundleToDoc()
    {
        
        let fileManager = FileManager.default
        if !(fileManager.fileExists(atPath: plistPathInDoc))
        {
            do {
                try fileManager.copyItem(atPath: plistPathInBundle!, toPath: plistPathInDoc)
            }catch{
                print("Error \(error)")
            }
        }
        else
        {
            print("already exists")
        }
    }
    
    // #MARK:- Extract Data From Document Plist
    //******************************************
    func extractDataFromPlist()->NSArray
    {
        
        var plistArray:NSArray = []
        let data =  FileManager.default.contents(atPath: plistPathInDoc)! as Data
        do{
            plistArray = try PropertyListSerialization.propertyList(from: data as Data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as! NSArray
        }catch{
            print("Error occured while reading from the plist file")
        }
        return plistArray
    }
    
//    // #MARK:- Data To Model
//    //***********************
//    func dataToModel()->[Wallet]
//    {
//        var modelData = [Wallet]()
//        let plistArray = extractDataFromPlist() as! [NSNumber: NSNumber]
//        for item in plistArray{
//            
//            modelData.append(Wallet(denomination: item["denomination"]!, count: item["count"]!))
//        }
//        return modelData
//    }
//    
//    //MARK: Add Data to Plist
//    //***************************
//    func saveDatatoPlist(newDataModel:[Wallet])
//    {
//        
//        var arrayOfDict: [[String:String]]=[]
//        let fileManager = FileManager.default
//        if fileManager.fileExists(atPath: plistPathInDoc)
//        {
//            for item in newDataModel
//            {
//                let dict:[NSNumber: NSNumber] = ["denomination": item.denomination, "count": item.count]
//                arrayOfDict.append(dict)
//            }
//            (arrayOfDict as NSArray).write(toFile:plistPathInDoc , atomically:true)
//            
//        }
//    }
}
