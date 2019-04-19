//
//  ConverterViewController.swift
//  Conversion-Calculator
//
//  Created by Nicole Dillon on 4/19/19.
//  Copyright © 2019 Nicole Dillon. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var inputVal: String = ""
    var outputVal: String = ""
    var unitOn = 0
    let converters = [Converter(labels:"fahrenheit to celcius", unitInput:" °F", unitOutput:" °C"),
                      Converter(labels:"celcius to fahrenheit", unitInput:" °C", unitOutput:" °F"),
                      Converter(labels:"kilometers to miles", unitInput:" km", unitOutput:" mi"),
                      Converter(labels:"miles to kilometers", unitInput:" mi", unitOutput:" km")]
    @IBOutlet weak var displayOutput: UILabel!
    @IBOutlet weak var displayInput: UITextField!
    
    @IBAction func numbers(_ sender: UIButton) {
        inputVal = inputVal + sender.currentTitle!
        displayInput.text = inputVal
        
        switch unitOn {
        case 0:
            displayInput.text = inputVal + converters[0].unitInput
            displayOutput.text = converters[0].unitOutput
            calculate()
            
        case 1:
            displayInput.text = inputVal + converters[1].unitInput
            displayOutput.text = converters[1].unitOutput
            calculate()
            
        case 2:
            displayInput.text = inputVal + converters[2].unitInput
            displayOutput.text = converters[2].unitOutput
            calculate()
            
        case 3:
            displayInput.text = inputVal + converters[3].unitInput
            displayOutput.text = converters[3].unitOutput
            calculate()
            
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate()
        self.displayInput.text = "0 °F"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func converterTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: converters[0].labels, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.displayInput.text = self.inputVal + self.converters[0].unitInput
            self.unitOn = 0
            self.calculate()
        }))
        alert.addAction(UIAlertAction(title: converters[1].labels, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.displayInput.text = self.inputVal + self.converters[1].unitInput
            self.unitOn = 1
            self.calculate()
        }))
        alert.addAction(UIAlertAction(title: converters[2].labels, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.displayInput.text = self.inputVal + self.converters[2].unitInput
            self.unitOn = 2
            self.calculate()
        }))
        alert.addAction(UIAlertAction(title: converters[3].labels, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.displayInput.text = self.inputVal + self.converters[3].unitInput
            self.unitOn = 3
            self.calculate()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func calculate(){
        
        var input: Double {
            return Double(inputVal) ?? 0.0
        }

        switch unitOn {
        case 0:
            outputVal = fahrenheitToCelcius(farenheit: input)
            self.displayOutput.text = outputVal
            self.displayInput.text = self.inputVal + self.converters[0].unitInput

        case 1:
            outputVal = celciusToFahrenheit(celcius: input)
            self.displayOutput.text = outputVal
            self.displayInput.text = self.inputVal + self.converters[1].unitInput

        case 2:
            outputVal = kilometeresToMiles(kilometers: input)
            self.displayOutput.text = outputVal
            self.displayInput.text = self.inputVal + self.converters[2].unitInput

        case 3:
            outputVal = milesToKilometers(miles: input)
            self.displayOutput.text = outputVal
            self.displayInput.text = self.inputVal + self.converters[3].unitInput

        default:
            break
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        self.inputVal.removeAll()
        self.outputVal.removeAll()
        self.displayInput.text = inputVal + converters[unitOn].unitInput
        self.displayOutput.text = outputVal + converters[unitOn].unitOutput
    }
    
    @IBAction func decimal(_ sender: Any) {
        if inputVal.contains(".") {
            return
        }
        
        if inputVal.isEmpty {
            inputVal += "0."
        } else {
            inputVal += "."
        }
    }
    
    @IBAction func negPos(_ sender: Any) {
        if inputVal.contains("-") {
            if let i = inputVal.characters.index(of: "-") {
                inputVal.remove(at: i)
            }
        } else {
            inputVal = "-" + inputVal
        }
    }
    func fahrenheitToCelcius(farenheit: Double) -> String {
        let celcius = ((farenheit) - 32) * (5/9)
        return String(format: "%.2f", celcius) + converters[0].unitOutput
    }
    func celciusToFahrenheit(celcius: Double) -> String {
        let fahrenheit = (celcius * (9/5)) + 32
        return String(format: "%.2f", fahrenheit) + converters[1].unitOutput
    }
    func kilometeresToMiles(kilometers: Double) -> String{
        let miles = (kilometers) / 1.60934
        return String(format: "%.2f", miles) + converters[2].unitOutput
    }
    func milesToKilometers(miles: Double) -> String{
        let kilometers = miles * 1.60934
        return String(format: "%.2f", kilometers) + converters[3].unitOutput
    }
}
