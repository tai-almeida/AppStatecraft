//
//  DesafiosMultimidiaView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 17/06/25.
//

import SwiftUI
import PhotosUI

struct DesafiosMultimidiaView: View {
    var enunciado: String
    
    var body: some View {
        ScrollView{
            VStack(){
                ContainerEnunciadoView(enunciado: enunciado).padding()
                Divider()
                
            }
        }
    }
}

//struct DesafiosMultimidiaView_Previews: PreviewProvider {
//    static var previews: some View {
//        DesafiosMultimidiaView(enunciado: "Escreva uma curta historia a partir desse quadro")
//    }
//}
