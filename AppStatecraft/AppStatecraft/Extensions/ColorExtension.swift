//
//  ColorExtension.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

import SwiftUI

extension Color {
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255
//            opacity: opacity
        )
    }
}
