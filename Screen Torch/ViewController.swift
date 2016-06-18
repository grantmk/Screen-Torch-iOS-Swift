//
//  ViewController.swift
//  Screen Torch
//
//  Created by Grant on 17/06/2016.
//  Copyright © 2016 GK MIcro Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sleepLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let preferences = UserDefaults.standard()
        
        let brightN = preferences.float(forKey: "brightness")
        let red = preferences.float(forKey: "red")
        let green = preferences.float(forKey: "green")
        let blue = preferences.float(forKey: "blue")
        let saved = preferences.bool(forKey: "haveSaved")
        let sleepOn = preferences.bool(forKey: "sleepOn")
        
        if (saved) {
            ChangeBrightness(value: brightN)
            ChangeScreenColorStart(red: red, green: green, blue: blue)
            
            sleepSwitch.isOn = sleepOn
            SetSleepSwitch(value: sleepOn)
            
            redSlider.value = red
            greenSlider.value = green
            blueSlider.value = blue
            brightnessSlider.value = brightN
        } else {
            redSlider.value = 1
            brightnessSlider.value = (Float)(UIScreen.main().brightness)
        }
        
    }
    
    @IBOutlet weak var sleepSwitch: UISwitch!
    
    @IBAction func SleepSwitchClicked(_ sender: AnyObject) {
        
            SetSleepSwitch (value: sleepSwitch.isOn)
    }
    
    func SetSleepSwitch (value: Bool) {
        if (value) {
            UIApplication.shared().isIdleTimerDisabled = false
            sleepLabel.text = "Sleep on"
        } else {
            UIApplication.shared().isIdleTimerDisabled = true
            sleepLabel.text = "Sleep off"
        }
    }

    @IBAction func SliderMoved(_ sender: UISlider) {
        ChangeBrightness(value: sender.value)
    }
    
    func ChangeBrightness (value: Float) {
        UIScreen.main().brightness = CGFloat(value)
    }

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    @IBAction func RedSliderMoved(_ sender: UISlider) {
        ChangeScreenColor()
    }

    @IBAction func GreenSliderMoved(_ sender: UISlider) {
        ChangeScreenColor()
    }
    @IBAction func BlueSliderMoved(_ sender: UISlider) {
        ChangeScreenColor()
    }
    
    
    @IBAction func SaveButtonClicked(_ sender: UIButton) {
        let preferences = UserDefaults.standard()
        
        preferences.set(redSlider.value, forKey: "red")
        preferences.set(greenSlider.value, forKey: "green")
        preferences.set(blueSlider.value, forKey: "blue")
        preferences.set(sleepSwitch.isOn, forKey: "sleepOn")
        preferences.set(brightnessSlider.value, forKey: "brightness")
        preferences.set(true, forKey: "haveSaved")
        //  Save to disk
        preferences.synchronize()
        

    }
    
    func ChangeScreenColor () {
        self.view.backgroundColor = UIColor.init(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    func ChangeScreenColorStart (red: Float, green: Float, blue: Float) {
        self.view.backgroundColor = UIColor.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

