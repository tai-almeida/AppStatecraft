//
//  TimerView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 25/06/25.
//

import SwiftUI

struct TimerView: View {
    @Binding var minutos: Int
    @Binding var segundos: Int
    @StateObject var viewModel:TimerViewModel
    
    init(minutos: Binding<Int>, segundos: Binding<Int>) {
        self._minutos = minutos
        self._segundos = segundos
        self._viewModel = StateObject(wrappedValue: TimerViewModel(minutos: minutos.wrappedValue, segundos: segundos.wrappedValue))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.tempoFormatado)
        }
    }
}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}
