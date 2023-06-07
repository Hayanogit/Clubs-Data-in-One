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
    var ohmchartView: LineChartView!
    var fhmchartView: LineChartView!
        var otfhmchartView:LineChartView!
        var chartDataSet: LineChartDataSet!
        var sampleData =  [88.0, 99.0, 93.0, 67.0, 45.0, 72.0, 58.0, 91.0, 81.0]

    
    
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
        let realmData = realm.objects(Data.self)
                for i in 0..<realmData.count {
                      sampleData.append(realmData[i].Time)
                }

        
    }
    
    @objc func doneClicked(){
        if event[0] == "100m" {
                        ohmdisplayChart(data: sampleData)
                    }else if event[1] == "400m"{
                        fhmdisplayChart(data: sampleData)
                    }else{
                        otfhmdisplayChart(data: sampleData)
                    }
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
    
    func ohmdisplayChart(data: [Double]) {
                // グラフの範囲を指定する
                ohmchartView = LineChartView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 100))
                // プロットデータ(y軸)を保持する配列
                var dataEntries = [ChartDataEntry]()
                
                for (xValue, yValue) in data.enumerated() {
                    let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
                    dataEntries.append(dataEntry)
                }
                // グラフにデータを適用
                chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
                
                chartDataSet.lineWidth = 2.0 // グラフの線の太さを変更
                
                ohmchartView.data = LineChartData(dataSet: chartDataSet)
                
                // X軸(xAxis)
                ohmchartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
                
                // Y軸(leftAxis/rightAxis)
                ohmchartView.leftAxis.axisMaximum = 17.0 //y左軸最大値
                ohmchartView.leftAxis.axisMinimum = 8.0 //y左軸最小値
                ohmchartView.leftAxis.labelCount = 1 // y軸ラベルの数
                ohmchartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
                
                // その他の変更
               ohmchartView.highlightPerTapEnabled = false // プロットをタップして選択不可
               ohmchartView.legend.enabled = false // グラフ名（凡例）を非表示
               ohmchartView.pinchZoomEnabled = false // ピンチズーム不可
               ohmchartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
               ohmchartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
                
               ohmchartView.animate(xAxisDuration: 2) // 2秒かけて左から右にグラフをアニメーションで表示する
                
                view.addSubview(ohmchartView)
            }
        
        func fhmdisplayChart(data: [Double]) {
                // グラフの範囲を指定する
                fhmchartView = LineChartView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 100))
                // プロットデータ(y軸)を保持する配列
                var dataEntries = [ChartDataEntry]()
                
                for (xValue, yValue) in data.enumerated() {
                    let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
                    dataEntries.append(dataEntry)
                }
                // グラフにデータを適用
                chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
                
                chartDataSet.lineWidth = 2.0 // グラフの線の太さを変更
                
                fhmchartView.data = LineChartData(dataSet: chartDataSet)
                
                // X軸(xAxis)
                fhmchartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
                
                // Y軸(leftAxis/rightAxis)
                fhmchartView.leftAxis.axisMaximum = 65.0 //y左軸最大値
                fhmchartView.leftAxis.axisMinimum = 45.0 //y左軸最小値
                fhmchartView.leftAxis.labelCount = 2 // y軸ラベルの数
                fhmchartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
                
                // その他の変更
               fhmchartView.highlightPerTapEnabled = false // プロットをタップして選択不可
               fhmchartView.legend.enabled = false // グラフ名（凡例）を非表示
               fhmchartView.pinchZoomEnabled = false // ピンチズーム不可
               fhmchartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
               fhmchartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
                
               fhmchartView.animate(xAxisDuration: 2) // 2秒かけて左から右にグラフをアニメーションで表示する
                
                view.addSubview(fhmchartView)
            }
        
        func otfhmdisplayChart(data: [Double]) {
                // グラフの範囲を指定する
                otfhmchartView = LineChartView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 100))
                // プロットデータ(y軸)を保持する配列
                var dataEntries = [ChartDataEntry]()
                
                for (xValue, yValue) in data.enumerated() {
                    let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
                    dataEntries.append(dataEntry)
                }
                // グラフにデータを適用
                chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
                
                chartDataSet.lineWidth = 2.0 // グラフの線の太さを変更
                
                otfhmchartView.data = LineChartData(dataSet: chartDataSet)
                
                // X軸(xAxis)
                otfhmchartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
                
                // Y軸(leftAxis/rightAxis)
                otfhmchartView.leftAxis.axisMaximum = 420 //y左軸最大値
                otfhmchartView.leftAxis.axisMinimum = 240 //y左軸最小値
                otfhmchartView.leftAxis.labelCount = 6 // y軸ラベルの数
                otfhmchartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
                
                // その他の変更
               otfhmchartView.highlightPerTapEnabled = false // プロットをタップして選択不可
               otfhmchartView.legend.enabled = false // グラフ名（凡例）を非表示
               otfhmchartView.pinchZoomEnabled = false // ピンチズーム不可
               otfhmchartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
               otfhmchartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
                
               otfhmchartView.animate(xAxisDuration: 2) // 2秒かけて左から右にグラフをアニメーションで表示する
                
                view.addSubview(otfhmchartView)
            }
        
    }

