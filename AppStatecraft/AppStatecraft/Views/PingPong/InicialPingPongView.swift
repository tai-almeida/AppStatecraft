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
    @State var individual: Bool = true
    @State var mostrarInfo: Bool = false
    @State var mostrarTimer: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: HistoricoView(tipoMetodologia: "pingpong") .navigationTitle("Histórico")) {
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
                    
                /*HStack {
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
                }*/
                    //.padding(.horizontal)
                DisclosureGroup (isExpanded: $mostrarTimer){
                    DurationPickerView(minutes: $minutes, seconds: $seconds)
                } label: {
                    Button (action: {mostrarTimer = !mostrarTimer}) {
                        HStack {
                            Text("Timer")
                                .foregroundColor(.black)
        //
                            Spacer()
        //
                            Text(String(format: "%02d:%02d", minutes, seconds))
                                .padding(2)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
        //                        .cornerRadius(10)
                                
        //
                        }
                    }
                }
                .padding(.horizontal)
                Divider().padding(.horizontal)
                Toggle(isOn: $individual) {
                    HStack {
                        Text((individual == true ? "Modalidade individual" : "Modalidade em dupla"))
                        Button(action: {
                            mostrarInfo = true
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.accentColor)
                        }
                        .buttonStyle(.plain)
                    }
                }
                    .padding(.horizontal)
                
            }
            Button("Começar") {
                showingSheet.toggle()
            }
            .fullScreenCover(isPresented: $showingSheet, onDismiss: { Task{
                palavras.removeAll()
                var aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                while aux == "Erro da IA" {
                    aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                }
                textoIA = aux;
                palavras.append(textoIA)
            }}) {
                PingPongView(textoIA: $textoIA, palavras: $palavras, minutos: minutes, segundos: seconds, ehIndividual: $individual)
                    .accentColor(Color("AccentColor"))
                    .interactiveDismissDisabled()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical)
        }
        .alert("Sobre as modalidades", isPresented: $mostrarInfo) {
            Button("Entendi", role: .cancel) {}
        } message: {
            Text("No modo individual, você vai receber apenas a primeira palavra. Já no modo em dupla, assim que você enviar uma palavra, você receberá outra.")
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
