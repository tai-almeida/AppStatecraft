//
//  InicialDesafiosView.swift
//  AppStatecraftColor("AccentColor").toolbar.datePickerStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Date Picker Style@*/DefaultDatePickerStyle()/*@END_MENU_TOKEN@*/)
//
//  Created by Aluno 07 on 17/06/25.
//

import SwiftUI

struct InicialDMView: View {
    
    @State private var showingSheet = false
    
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
            Divider()
                
            Text("Crie uma nova obra de arte a partir de outra e explore sua criatividade!")
            .padding(.horizontal)
            Spacer()
            }
            Button("Começar") {
                showingSheet.toggle()
                print("aaaaa")
            }
            .sheet(isPresented: $showingSheet) {
                comecarDMView()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            Spacer()
        }
        .navigationTitle("Desafios Multimídia")
    }
}

struct InicialDesafiosView_Previews: PreviewProvider {
    static var previews: some View {
        InicialDMView()
    }
}

struct comecarDMView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}
