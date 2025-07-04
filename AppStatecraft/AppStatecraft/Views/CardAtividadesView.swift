//
//  CardAtividadesView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 03/07/25.
//

import SwiftUI

struct CardAtividadesView: View {
    @State var projeto: Projeto
     
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .shadow(radius: 10)
        }
    }
}

//struct CardAtividadesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardAtividadesView()
//    }
//}
