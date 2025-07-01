//
//  BotaoCloseModal.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 01/07/25.
//

import SwiftUI

struct BotaoCloseModal: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.title2)
                .foregroundColor(.gray)
        }.padding(.top)
            .padding(.trailing)
    }
}

struct BotaoCloseModal_Previews: PreviewProvider {
    static var previews: some View {
        BotaoCloseModal()
    }
}
