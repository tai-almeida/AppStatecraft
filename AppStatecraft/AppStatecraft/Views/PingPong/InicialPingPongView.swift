//
//  InicialDesafiosView.swift
//  AppStatecraftColor("AccentColor").toolbar.datePickerStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Date Picker Style@*/DefaultDatePickerStyle()/*@END_MENU_TOKEN@*/)
//
//  Created by Aluno 07 on 17/06/25.
//

import SwiftUI


struct InicialPingPongView: View {
    
    @State private var showingSheet = false
    @State private var minutes = 1
    @State private var seconds = 0
    @State var textoIA = ""
    @StateObject var viewModel = PingPongViewModel()
    @State var palavras: [String] = []
    
    
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: Text("Conteudo historico") .navigationTitle("Histórico")) {
                HStack(alignment: .top) {
                    Image(systemName: "tray")
                        .foregroundColor(Color.accentColor)
                    
                    Text("Histórico")
                        .foregroundColor(.primary)
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(.tertiaryLabel))
                        
                    }
                    
                .padding(.horizontal)
                
                }
                Divider().padding(.horizontal)
                    
                Text("Te daremos uma palavra e, sem pensar demais, escreva palavras que ela te fizer lembrar!")
                
                Divider().padding(.horizontal)
                Spacer()
                    
                HStack {
                    Text("Timer")
                        .foregroundColor(Color.accentColor)
//
                    Spacer()
//
                    Text(String(format: "%02d:%02d", minutes, seconds))
                        .padding(2)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
//                        .cornerRadius(10)
                        
//
                }.padding(.horizontal)
                DurationPickerView(minutes: $minutes, seconds: $seconds)
            }
            Button("Começar") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet, onDismiss: { Task{
                palavras.removeAll()
                var aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                while aux == "Erro da IA" {
                    aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                }
                textoIA = aux;
                palavras.append(textoIA)
            }}) {
                PingPongView(textoIA: $textoIA, palavras: $palavras, minutos: minutes, segundos: seconds)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical)
        }
        .onAppear {
            Task {
                if textoIA == "" {
                    var aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                    while aux == "Erro da IA" {
                        aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                    }
                    textoIA = aux
                    palavras.append(textoIA)
                }
            }
        }
        .navigationTitle("Ping-Pong")
    }
}

//struct InicialPingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        InicialPingPongView()
//    }
//}
