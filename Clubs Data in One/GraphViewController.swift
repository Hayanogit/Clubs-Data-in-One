//
//  GraphViewController.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/29.
//

import Foundation
import UIKit
import RealmSwift
import Charts

class GraphViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    
    @IBOutlet var EventTextField: UITextField!
    var EventpickerView: UIPickerView = UIPickerView()
    var event: [String] = ["100m","400m","1500m"]
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventTextField.delegate = self
        EventpickerView.delegate = self
        EventpickerView.dataSource = self
        EventTextField.inputView = EventpickerView
        
        let data: Data? = read()
        
        EventTextField.text = data?.Event
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([space,doneButton], animated: true)
        EventTextField.inputAccessoryView = toolbar
        
        
    }
    
    @objc func doneClicked(){
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return event.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return event[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.EventTextField.text = event[row]
    }
    
    func read() -> Data?{
        return realm.objects(Data.self).first
    }
    
    @IBAction func returnButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
