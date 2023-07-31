//
//  ViewController.swift
//  timerHomeWork
//
//  Created by Lazzat on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
   @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var textFieldTitle: UITextField!
    
    var time = 0
    var timer = Timer()
    var day = 1
    let maxTime = 86400
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeLabel.text = timeToString(intTime: time)
        
    }
    
    @IBAction func addPost(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let taskName = textFieldTitle.text!
        
        
        var newTask = TaskItem()
        newTask.title = taskName
        
        do{
            if let data = defaults.data(forKey: "taskItemArray"){
                var array = try JSONDecoder().decode([TaskItem].self, from: data)

                array.append(newTask)
                let encodedata = try JSONEncoder().encode(array)
                defaults.set(encodedata, forKey: "taskItemArray")
            }else{
                let encodedata = try JSONEncoder().encode([newTask])
                defaults.set(encodedata, forKey: "taskItemArray")
            }
 
        }catch{
            print("unable to encode \(error)")
        }
        textFieldTitle.text = ""
        
        
        
    }
    @objc func countTime(){
        time = time + 1
        timeLabel.text = timeToString(intTime: time)
        if time == maxTime {
            day += 1
            time = 0
        }
    }
    
    @IBAction func startTime(_ sender: Any) {
        if isTimerRunning {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        isTimerRunning = true
        
        
    }
    
    func timeToString (intTime: Int) -> String {
        let seconds = intTime % 60
        let minutes = (intTime / 60) % 60
        let hours = intTime / 3600
        return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
    
  
        

}

