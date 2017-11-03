//
//  ViewController.swift
//  EggUhr
//
//  Created by MacMini on 02.11.17.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var resetTime = 420
    var time = 420
    var timer = Timer()
    var timeDifference = 30
    var timeUnit = 1 // 0 >> min, 1 >> second
    
    func showTime() {
        timeLabel.text = String (time)
        
    }
    
    @objc func decreaseTimer() {
        if time > 0 {
            time -= 1
            showTime()
        } else {
            timer.invalidate()
        }
    }
    
    func playTimer() {
        // Vorsicht: untere Zeile ist fehlerhaft
        //timer = Timer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
        
        if let anfangsZeit = anfangszeitTextField.text {
            if timeUnit == 0 {
                time = Int (anfangsZeit)! * 60
            } else {
                time = Int (anfangsZeit)!
            }
        }
    }
    
    @IBAction func play(_ sender: Any) {
    
        playTimer()
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
        anfangszeitTextField.text = timeLabel.text
    }
    
    @IBAction func `return`(_ sender: UIBarButtonItem) {
      playTimer()
        
    }
    
    @IBAction func plusTime(_ sender: Any) {
        time += timeDifference
        anfangszeitTextField.text = String (time)
        showTime()
    }
    
    @IBOutlet weak var plusTimeOutlet: UIBarButtonItem!
    
    @IBAction func reset(_ sender: Any) {
        time = Int (anfangszeitTextField.text!)!
        timer.invalidate()
        showTime()
    }
    
    @IBAction func minusTime(_ sender: Any) {
        if (time - timeDifference) > 0 {
            time -= timeDifference
            anfangszeitTextField.text = String (time)
            showTime()
        }
    }
    
    @IBOutlet weak var minusTimeOutlet: UIBarButtonItem!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var anfangszeitTextField: UITextField!
    
    @IBAction func anfangszeitTextField(_ sender: UITextField) {
  
    }
    
    @IBAction func einheitControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:    // min
                timeUnit = 0
            case 1:    // sec
                timeUnit = 1
            default:
                break
        }
        timer.invalidate()
        showTime()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        time = resetTime;
        anfangszeitTextField.text = String (time)
        minusTimeOutlet.title = "-"+String (timeDifference)
        plusTimeOutlet.title = "+"+String (timeDifference)

        showTime()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

