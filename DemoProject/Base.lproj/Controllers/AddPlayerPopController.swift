//
//  AddPlayerPopController.swift
//  DemoProject
//
//  Created by HarshaVardhini on 12/01/19.
//  Copyright © 2019 HarshaVardhini. All rights reserved.
//

import UIKit
import CoreData
class AddPlayerPopController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    let appDelegate: AppDelegate = UIApplication.shared.delegate as!  AppDelegate
    @IBOutlet weak var playerNameTxt: UITextField!
    var country: Countries!
   
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10.0
        popupView.layer.shadowColor = UIColor.black .cgColor
        popupView.layer.shadowRadius = 3
        popupView.layer.shadowOffset = CGSize(width: 2, height: 2)
        popupView.layer.shadowOpacity = 0.3
       
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: playerNameTxt.frame.size.height - width, width: playerNameTxt.frame.size.width, height: playerNameTxt.frame.size.height)
        
        border.borderWidth = width
        playerNameTxt.layer.addSublayer(border)
        playerNameTxt.layer.masksToBounds = true
        
         saveBtn.layer.cornerRadius = 3.0
         cancleBtn.layer.cornerRadius = 3.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtnAction(_ sender: UIButton) {
        guard let text = self.playerNameTxt.text, !text.isEmpty else {
            let alert = UIAlertController(title: "Alert", message: "Please Enter Player Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        _ = saveDataLocal()
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func saveDataLocal() -> NSManagedObject? {
        let context = appDelegate.persistentContainer.viewContext
        if let playerEntity = NSEntityDescription.insertNewObject(forEntityName: "Players", into: context) as? Players {
            playerEntity.countryId = country.id
            playerEntity.name = playerNameTxt.text!
            return playerEntity
        }
        return nil
    }
}


