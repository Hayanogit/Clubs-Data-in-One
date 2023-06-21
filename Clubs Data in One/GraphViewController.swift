//
//  GraphViewController.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/29.
//

import Foundation
import UIKit
import RealmSwift
import DGCharts

class GraphViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    
    @IBOutlet var EventTextField: UITextField!
    var EventpickerView: UIPickerView = UIPickerView()
    var event: [String] = ["100m","400m","1500m"]
    let realm = try! Realm()
    @IBOutlet weak var lineChartView: LineChartView!
    var rawDataGraph: [Int] = [130, 240, 500, 550, 670, 800, 950, 1300, 1400, 1500, 1700, 2100, 2500, 3600, 4200, 4300, 4700, 4800, 5400, 5800, 5900, 6700]
    
    
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
        
        
        // Chart dataSet準備
        rawDataGraph.append(Data.Time)
                let entries = rawDataGraph.enumerated().map { ChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
                let dataSet = LineChartDataSet(entries: entries)
                // 線の太さ
                dataSet.lineWidth = 5
                // 各プロットのラベル表示
                dataSet.drawValuesEnabled = false
                // 各プロットの丸表示
                dataSet.drawCirclesEnabled = true
                // 各プロットの丸の大きさ
                dataSet.circleRadius = 2
                // 各プロットの丸の色
                dataSet.circleColors = [UIColor.lightGray]

                // 作成したデータセットをLineChartViewに追加
                lineChartView.data = LineChartData(dataSet: dataSet)

                // X軸のラベルの位置を下に設定
                lineChartView.xAxis.labelPosition = .bottom
                // X軸のラベルの色を設定
                lineChartView.xAxis.labelTextColor = .systemGray
                // X軸の線、グリッドを非表示にする
                lineChartView.xAxis.drawGridLinesEnabled = false
                lineChartView.xAxis.drawAxisLineEnabled = false

                // 右側のY座標軸は非表示にする
                lineChartView.rightAxis.enabled = false

                // Y座標の値が0始まりになるように設定
                lineChartView.leftAxis.axisMinimum = 0.0
                lineChartView.leftAxis.axisMaximum = 10000.0
                lineChartView.leftAxis.drawZeroLineEnabled = true
                lineChartView.leftAxis.zeroLineColor = .systemGray

                // グラフに境界線(横)を追加
                let limitLine = ChartLimitLine(limit: 7200, label: "AAAAA")
                limitLine.lineColor = .darkGray
                limitLine.valueTextColor = .darkGray
                lineChartView.leftAxis.addLimitLine(limitLine)

                // グラフに境界線(縦)を追加
                let limitLineX = ChartLimitLine(limit: 3, label: "BBBBB")
                limitLineX.lineColor = .darkGray
                limitLineX.valueTextColor = .darkGray
                lineChartView.xAxis.addLimitLine(limitLineX)

                // ラベルの数を設定
                lineChartView.leftAxis.labelCount = 5
                // ラベルの色を設定
                lineChartView.leftAxis.labelTextColor = .systemGray
                // グリッドの色を設定
                lineChartView.leftAxis.gridColor = .systemGray
                // 軸線は非表示にする
                lineChartView.leftAxis.drawAxisLineEnabled = false

                // 凡例を非表示
                lineChartView.legend.enabled = false

                // タップでプロットを選択できないようにする
                lineChartView.highlightPerTapEnabled = false
                // ピンチズームオフ
                lineChartView.pinchZoomEnabled = false
                // ダブルタップズームオフ
                lineChartView.doubleTapToZoomEnabled = false

                // アニメーションをつける
                lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.3, easingOption: .easeInCubic)

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
