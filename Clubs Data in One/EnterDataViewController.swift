//
//  EnterDataViewController.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/29.
//

import UIKit
import RealmSwift

class EnterDataViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var EventTextField: UITextField!
    @IBOutlet var TimeTextField: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateTextField.delegate = self
        EventTextField.delegate = self
        TimeTextField.delegate = self
        
        let data: Data? = read()
        
        DateTextField.text = data?.Date
        EventTextField.text = data?.Event
        TimeTextField.text = data?.Time
        
    }
    
    func read() -> Data?{
        return realm.objects(Data.self).first
    }
    
    @IBAction func save(){
        let Date: String = DateTextField.text!
        let Event: String = EventTextField.text!
        let Time: String = TimeTextField.text!
        
        let data: Data? = read()
        if data != nil{
            try! realm.write{
                data!.Date = Date
                data!.Event = Event
                data!.Time = Time
            }
        }else{
            let newData = Data()
            newData.Date = Date
            newData.Event = Event
            newData.Time = Time
            try! realm.write{
                realm.add(newData)
            }
        }
        
        let alert: UIAlertController = UIAlertController(title: "保存完了", message: "データを保存しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        present(alert, animated: true, completion: nil)
        
        func textFieldShouldReturn (_ textField: UITextField!) -> Bool{
            textField.resignFirstResponder()
        }
        
    }
    
}
