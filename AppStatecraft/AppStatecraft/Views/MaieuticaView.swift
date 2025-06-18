//
//  MaieuticaView.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 16/06/25.
//

import SwiftUI

struct MaieuticaView: View {
    
    @State var textoUser = "" // Tive que tirar a ideia de label "escreva aqui" por estar dando um bug dele perguntar sobre a label junto a ideia"
    @StateObject var viewModel = MaieuticaViewModel()
    @State var textoIA = "Conte sobre sua ideia!"
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.respostaIA)
                    .font(.title3)
                    .padding()
                Divider()
                TextField("", text: $textoUser)
                    .padding(10)
                Button (action: {Task{ await viewModel.fazerRequisicao(context: textoUser)}; textoUser = textoUser}){ // Mesma coisa aqui em relação a label do textoUser
                    Text("Seguinte")
                        .padding(20)
                    
                    
                }
                .foregroundColor(.white)
                .background(Color.indigo).cornerRadius(10)
            }
            .navigationTitle ("Maiêutica")
            .navigationBarTitleDisplayMode(.inline)
            
            // Outros botoões...
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button (action:{}){
                        Text("Cancelar")
                            .tint(.indigo)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button (action:{}){
                        Text("Salvar")
                            .tint(.indigo)
                    }
                    
                }
            }
        }
        
    }
}

struct MaieuticaView_Previews: PreviewProvider {
    static var previews: some View {
        MaieuticaView()
    }
}
