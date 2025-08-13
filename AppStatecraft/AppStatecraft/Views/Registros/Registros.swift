//
//  Registros.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 11/08/25.
//

import SwiftUI
import CoreData

struct Registros: View {
    @Environment(\.managedObjectContext) private var contexto
    @StateObject private var registrosVM: RegistrosVM
    @State private var isShowingSheet = false
    
    init(contexto: NSManagedObjectContext) {
        //criar um init customizado para a View para poder inicializar o StateObject com um parâmetro.
        self._registrosVM = StateObject(wrappedValue: RegistrosVM(contexto: contexto))
    }
    
    var body: some View {
        NavigationView{
            VStack(){
                ForEach(registrosVM.registros, id: \.self) { registro in
                    BoxView(registro: registro) //TODO: adicionar uns paddings, deixar bonitinho
                }
            }
            .navigationTitle(Text("Registros"))
            .navigationBarItems(trailing:
                Button(action: {
                    isShowingSheet.toggle()
            }){
                Image(systemName: "plus")
            })
        }.sheet(isPresented: $isShowingSheet){
            CriarRegistroView{ titulo, texto in
                self.registrosVM.addNewRegistro(titulo: titulo, texto: texto)
                isShowingSheet.toggle()
            }
        }
    }
    
    struct BoxView: View{
        var registro: Registro
        
        var body: some View{
            GroupBox{
                Text(registro.titulo ?? "Sem titulo").font(.title2)
                Text(registro.texto ?? "Sem texto")
            }
        }
    }
    
    struct CriarRegistroView: View {
        
        @State var texto: String = ""
        @State var titulo: String = ""
        var onSave: (String, String) -> Void
        
        var body: some View{
            VStack{
            //TODO: Deixar bonito agora que a logica esta funcional
                TextField("Enter titulo", text: $titulo)
                TextField("Enter Text", text: $texto)
                Button("Salvar") {
                    onSave(titulo, texto) //funcao passada como parametro na view!
                }
                .padding()
            }
        }
    }
}
