//
//  DurationPickerView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

//import UIKit
import SwiftUI

struct DurationPickerView: View {
//    private let pickerView = UIPickerView()
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    private let intervaloMinutos = Array(0...59)
    private let intervaloSegundos = Array(0...59)
    
    var body: some View {
        HStack {
            Picker("Minutos", selection: $minutes) {
                ForEach(intervaloMinutos, id: \.self) { minutos in
                    Text("\(minutos) min")
                        .tag(minutos)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: .infinity)
//            .clipped()
            
            Picker("Segundos", selection: $seconds) {
                ForEach(intervaloSegundos, id: \.self) { segundos in
                    Text("\(segundos) sec")
                        .tag(segundos)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: .infinity)
//            .clipped()
        }
    }
}

//struct DurationPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DurationPickerView()
//    }
//}
