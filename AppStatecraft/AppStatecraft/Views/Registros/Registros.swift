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
    
    var body: some View {
        NavigationView{
            VStack(){
                ForEach(registros, id: \.self) { registro in
                    //card do registro ver que componente usar
                }
            }
            .navigationTitle(Text("Registros"))
            .navigationBarItems(trailing: Button(action: {
                //adicionar registro
            }){
                Image(systemName: "plus")
            })
        }
    }
}

