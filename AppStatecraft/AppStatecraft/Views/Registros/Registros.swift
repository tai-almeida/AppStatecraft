//
//  Registros.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 11/08/25.
//

import SwiftUI

struct Registros: View {
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath: \Registro.data, ascending: false)]
    ) var registros: FetchedResults<Registro>
    @StateObject private var registrosVM = RegistrosVM()
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView{
            VStack(){
                ForEach(registros, id: \.self) { registro in
                    //card do registro ver que componente usar
                    BoxView(registro: registro)
                }
            }
            .navigationTitle(Text("Registros"))
            .navigationBarItems(trailing:
                Button(action: {
                    //adicionar registro
                    //modal para usuario inputar texto
                    isShowingSheet.toggle()
                }){
                    Image(systemName: "plus")
                })
        }.sheet(isPresented: $isShowingSheet){
            CriarRegistroView()
        }
    }
}

struct BoxView: View{
    var registro: Registro
    
    var body: some View{
        GroupBox{
            Text(registro.texto ?? "Sem texto")
        }
    }
}

struct CriarRegistroView: View {
    @State var text = ""

    var body: some View{
        //TextField("Enter Text", text: $text)
    }
}
