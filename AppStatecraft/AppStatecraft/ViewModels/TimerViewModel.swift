//
//  TimerViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 26/06/25.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var tempoRestante: Int
    @Published var sendoFeito: Bool = false
    
    private var tempoEmSegundos: Int
    private var timer: Timer?
    
    init(minutos: Int, segundos: Int) {
        self.tempoEmSegundos = minutos*60 + segundos
        self.tempoRestante = tempoEmSegundos
    }
    
    var tempoFormatado: String {
        let minutos = tempoRestante/60
        let segundos = tempoRestante % 60
        return String(format: "%02d:%02d", minutos, segundos)
    }
    
    func comecaContagem() {
        // verifica se ja ha um timer rodando
        guard !self.sendoFeito else {
            return
        }
        
        self.sendoFeito = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.tempoRestante > 0 {
                self.tempoRestante -= 1
            } else {
                self.pararContagem()
            }
        }
    }
    
    
    func pararContagem() {
        self.timer?.invalidate()
        self.sendoFeito = false
        self.timer = nil
    }
    
    func resetar(minutos: Int, segundos: Int) {
        self.tempoRestante = minutos * 60 + segundos
    }

}
