//
//  DurationPickerModelView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

import Foundation
import UIKit

class DurationPickerViewModel {
    private var minutes: Int = 0
    private var seconds: Int = 0
    
    func setMinutes(minutes: Int) {
        self.minutes = minutes
    }
    
    func setSeconds(seconds: Int) {
        self.seconds = seconds
    }
    
    func formataIntervalo() -> String {
        return "\(self.minutes):\(self.seconds)"
    }
}
