//
//  TimerViewController.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 25/06/25.
//

import Foundation
import UIKit

class TimerViewController: UIViewController {
    var minutes: Int
    var seconds: Int
    var countdownTimerSegundos: Int
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(minutes: Int, seconds: Int) {
        //super.init(coder: coder)
        self.minutes = minutes
        self.seconds = seconds
        
        self.countdownTimerSegundos = (self.minutes)*60 + self.seconds
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdownTimerSegundos > 0 {
                print("\(self.countdownTimerSegundos)")
                self.countdownTimerSegundos -= 1
            } else {
                timer.invalidate()
                print("Timer: Complete!")
            }
        }
        
    }
}
