//
//  WeatherViewController.swift
//  TextFileConvert
//
//  Created by Lilianna Kinakh on 2/27/19.
//  Copyright © 2019 Lilianna Kinakh. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
     // MARK: Properties
    
    let controller = WeatherController()
    
    private var pickerView: UIPickerView?
    
    // MARK: IBOutles
    
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerView()
        createToolbar()
        infoTextField.text = controller.stations[0]
        controller.setupInfoInTableView(station:controller.stations[0])
        textView.text = controller.description
        title = controller.currentStation
    }
    
    
    func createPickerView() {
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        infoTextField.inputView = pickerView
        pickerView?.backgroundColor = .white
    }
    
    func createToolbar() {

        let toolBar = UIToolbar()
        toolBar.sizeToFit()        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(WeatherViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        infoTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Actions
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        guard let curentStation = infoTextField.text else { return }
        controller.setupInfoInTableView(station: curentStation)
        view.endEditing(true)
        tableView.reloadData()
        textView.text = controller.description
        self.title = controller.currentStation
        
    }
}

extension WeatherViewController:  UIPickerViewDelegate, UIPickerViewDataSource{
    
    // MARK: - UIPickerView: datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  controller.stations.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return controller.stations[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        infoTextField.text = controller.stations[row]
        
    }
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
   
    // MARK: - UITableView: datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.arrayWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! TableViewCell
        
        let item = controller.arrayWeathers[indexPath.row]
        
        cell.yyyyLabel.text = item["yyyy"]
        cell.mmLabel.text = item["mm"]
        cell.tmaxLabel.text = item["tmax"]
        cell.tminLabel.text = item["tmin"]
        cell.afLabel.text = item["af"]
        cell.rainLabel.text = item["rain"]
        cell.sunLabel.text = item["sun"]
        
        return cell
    }

}
