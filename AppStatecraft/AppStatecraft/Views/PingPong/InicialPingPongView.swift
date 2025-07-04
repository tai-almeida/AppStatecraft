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
    let modalidades = ["Livre", "Conduzida"]
    @State var selecionada = "Conduzida"
    @State var resetaPicker = UUID()
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                    .padding(2)
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
                    
                Text("Com a palavra recebida, escreva o que ela te lembrar! Escolha a modalidade e defina um timer para a atividade.")
                    .padding(.horizontal)
                
                Divider().padding(.horizontal)
                Spacer()
                    
                HStack {
                    Text("Timer")
                        .foregroundColor(.black)
                    //
                    Spacer()
                    //
                    Text(String(format: "%02d:%02d", minutes, seconds))
                        .padding(2)
                        .foregroundColor(Color.accentColor)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    //                        .cornerRadius(10)
                    
                    //
                }.padding(.horizontal)
                DurationPickerView(minutes: $minutes, seconds: $seconds)

                Divider().padding(.horizontal)
                /*Toggle(isOn: $individual) {
                    HStack {
                        Text((individual == true ? "Modalidade livre" : "Modalidade conduzida"))
                        Button(action: {
                            mostrarInfo = true
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.accentColor)
                        }
                        .buttonStyle(.plain)
                    }
                }
                    .padding(.horizontal)*/
                
                HStack {
                    Text("Modalidade")
                    Button(action: {
                        mostrarInfo = true
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color.accentColor)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                        Picker("", selection: $selecionada) {
                            ForEach(modalidades, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .id(resetaPicker)
                    Image(systemName: "chevron.up")
                        .foregroundColor(Color.accentColor)
                    
                }
                .padding(.horizontal)
                
                /*Picker("Selecione a modalidade", selection: $selecionada) {
                    ForEach(modalidades, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)*/
                
            }
            Button(action: { showingSheet.toggle() }) {
                Text("Começar")
                    .frame(maxWidth: .infinity)
                    .clipShape(Capsule())
            }
            .fullScreenCover(isPresented: $showingSheet, onDismiss: { resetaPicker = UUID(); selecionada = "Conduzida"; Task{
                palavras.removeAll()
                var aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                while aux == "Erro da IA" {
                    aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                }
                textoIA = aux;
                palavras.append(textoIA)
            }}) {
                PingPongView(metodologiaAparecendo: $showingSheet, textoIA: $textoIA, palavras: $palavras, minutos: minutes, segundos: seconds, selecionada: $selecionada)
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
            Text("No modo livre, você vai receber apenas a primeira palavra. Já no modo conduzido, assim que você enviar uma palavra, você receberá outra.")
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
