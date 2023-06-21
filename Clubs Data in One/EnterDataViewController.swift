//
//  EnterDataViewController.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/29.
//

import UIKit
import RealmSwift

class EnterDataViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var DateTextField: UITextField!
    @IBOutlet var EventTextField: UITextField!
    @IBOutlet var TimeTextField: UITextField!
    let datePicker = UIDatePicker()
    var EventpickerView: UIPickerView = UIPickerView()
    var event: [String] = ["100m","400m","1500m"]
    
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateTextField.delegate = self
        EventTextField.delegate = self
        TimeTextField.delegate = self
        EventpickerView.delegate = self
        EventpickerView.dataSource = self
        
        createDatePicker()
        EventTextField.inputView = EventpickerView
        
        let data: RealmData? = read()
        
        /*DateTextField.text = data?.Date
        EventTextField.text = data?.Event
        if(data?.Time==nil){
            TimeTextField.text = " "
        }else{
            TimeTextField.text = String(describing: data!.Time)
        }*/
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([space,doneButton], animated: true)
        EventTextField.inputAccessoryView = toolbar
        TimeTextField.inputAccessoryView = toolbar
        
    }
    
    func createDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        datePicker.preferredDatePickerStyle = .wheels
        DateTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([space,doneButton], animated: true)
        DateTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
        DateTextField.text = dateFormatter.string(from: datePicker.date)
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
    
    func read() -> RealmData?{
        return realm.objects(RealmData.self).first
    }
    
    @IBAction func save(){
        let Date: String = DateTextField.text!
        let Event: String = EventTextField.text!
        let Time: String = TimeTextField.text!
        
        let data: RealmData? = read()
        if data != nil{
            try! realm.write{
                data!.Date = Date
                data!.Event = Event
                data!.Time = Double(Time)!
            }
        }else{
            let newData = RealmData()
            newData.Date = Date
            newData.Event = Event
            newData.Time = Double(Time) ?? 0
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
    
    @IBAction func returnButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
