//
//  DurationPickerView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

//import UIKit
import SwiftUI

struct DurationPickerView: View {
    @Binding var minutes: Int
    @Binding var seconds: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker("Minutos", selection: $minutes) {
                    ForEach(0..<60) { min in
                        Text("\(min) min").tag(min)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geometry.size.width / 2, height: geometry.size.height)
                .clipped()

                Picker("Segundos", selection: $seconds) {
                    ForEach(0..<60) { sec in
                        Text("\(sec) s").tag(sec)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geometry.size.width / 2, height: geometry.size.height)
                .clipped()
            }
        }
        .frame(height: 150)
        .padding(.horizontal)
        .cornerRadius(30)
    }
}

//struct DurationPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DurationPickerView()
//    }
//}
