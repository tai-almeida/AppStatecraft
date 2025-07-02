//
//  InicialDesafiosView.swift
//  AppStatecraftColor("AccentColor").toolbar.datePickerStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Date Picker Style@*/DefaultDatePickerStyle()/*@END_MENU_TOKEN@*/)
//
//  Created by Aluno 07 on 17/06/25.
//

import SwiftUI


struct InicialFreeWritingView: View {
    
    @State private var showingSheet = false
    @State private var minutes = 15
    @State private var seconds = 0
    
    
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: HistoricoView(tipoMetodologia: "freewriting").navigationTitle("Histórico")) {
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
                
                Text("Receba um desafio e crie um texto livre, com a imaginação guiando a escrita!")
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
            }
            Button("Começar") {
                showingSheet.toggle()
            }.frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.vertical)
                .fullScreenCover(isPresented: $showingSheet) {
                    FreeWritingView(minutos: minutes, segundos: seconds)
                        .accentColor(Color("AccentColor"))
                        .interactiveDismissDisabled()
                }
        }
        .navigationTitle("Free-Writing")
    }
}

//struct InicialPingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        InicialPingPongView()
//    }
//}
