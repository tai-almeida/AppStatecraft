////
////  CriarEAddProjetoView.swift
////  AppStatecraft
////
////  Created by Aluno 07 on 30/06/25.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//  Created by Aluno 07 on 30/06/25.
//

import Foundation
import SwiftUI
import CoreData

struct criarEAddProjetoView: View {
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
   // private var projeto: FetchRequest<Projeto>
    
    let respostaTexto: String?
    let respostaFoto: UIImage? //ver depois de passar como objeto mesmo para ficar mais legivel
    let desafio: QuestaoDesafios
    
    @State private var nomeNovoProj = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    Section(header: Text("Nome do Projeto")) {
                        TextField("ex: projeto de design", text: $nomeNovoProj)
                    }
                }
                   .navigationBarTitle("Novo Projeto")
                   .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancelar") {
                            
                                dismiss()
                            }
                            foregroundColor(.accentColor)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Salvar") {
                                salvarSessao()
                                print("salvou?")
                                dismiss()
                            }
                            foregroundColor(.accentColor)
                        }
                    }
            }
        }
    }
    
    private func salvarSessao() {
        print("FUNCAO CHAMADA")
        print("--- Dentro de salvarSessao. Tipo do desafio: '\(desafio.tipo)' ---")
        
        // cria um novo projeto
        let novoProjeto = Projeto(context: viewContext)
        novoProjeto.id = UUID()
        novoProjeto.data = Date()
        novoProjeto.nome = nomeNovoProj
        novoProjeto.finalizado = false
        novoProjeto.imagemCapa = Data()
        
        switch desafio.tipo {
        case "maieutica":
            let novaSessao = SessaoMaieutica(context: viewContext)
            novaSessao.id = UUID()
            novaSessao.data = Date()
            
            novaSessao.log = Data()
            
            novaSessao.projeto = novoProjeto
        
        case "texto":
            let novaSessao = SessaoDesafioMult(context: viewContext)
            novaSessao.id = UUID()
            novaSessao.data = Date()
            
            novaSessao.desafioFeito = true
            novaSessao.desafioID = Int64(self.desafio.id)
            novaSessao.enunciado = self.desafio.enunciado
          //  novaSessao.mediaFoto = Data()
           // novaSessao.mediaTexto =
          //  novaSessao.respostaFoto =
            novaSessao.respostaTexto = self.respostaTexto
            
            novaSessao.projeto = novoProjeto
            
        case "free writing":
            let novaSessao = SessaoFreeWriting(context: viewContext)
            novaSessao.id = UUID()
            novaSessao.data = Date()
            
            novaSessao.enunciado = String()
            novaSessao.resposta = String()
            
            novaSessao.projeto = novoProjeto
            
        case "ping pong":
            let novaSessao = SessaoPingPong(context: viewContext)
            novaSessao.id = UUID()
            novaSessao.data = Date()
            
            novaSessao.log = Data()
            
            novaSessao.projeto = novoProjeto
        
        default:
            print("tipo invalido")
            return
            
        }
        
        do {
            try viewContext.save()
            print("eeeeeee :)")
            dismiss()
        } catch {
            let nsError = error as NSError
            print("aaaah :( \(nsError)")
        }
    }
}
//struct criarEAddProjetoView: View {
//    @Binding var isPresented: Bool
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) private var dismiss
//    
//    //let respostaTexto: String?
//    //let respostaFoto: UIImage? //ver depois de passar como objeto mesmo para ficar mais legivel
//    //let desafio: QuestaoDesafios
//    
//    @State private var nomeNovoProj = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form{
//                    Section(header: Text("Nome do Projeto")) {
//                        TextField("ex: projeto de design", text: $nomeNovoProj)
//                    }
//                }
//                   .navigationBarTitle("Novo Projeto")
//                   .navigationBarTitleDisplayMode(.inline)
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Cancelar") {
//                                dismiss()
//                            }
//                            foregroundColor(.accentColor)
//                        }
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button("Salvar") {
//                                salvarSessao()
//                                print("salvou?")
//                                dismiss()
//                            }
//                            foregroundColor(.accentColor)
//                        }
//                    }
//            }
//        }
//    }
//    
//    private func salvarSessao() {
//        print("FUNCAO CHAMADA")
//        print("--- Dentro de salvarSessao. Tipo do desafio: '\(desafio.tipo)' ---")
//        
//        let novoProjeto = Projeto(context: viewContext)
//        novoProjeto.id = UUID()
//        novoProjeto.data = Date()
//        novoProjeto.nome = nomeNovoProj
//        novoProjeto.finalizado = false
//        novoProjeto.imagemCapa = Data()
//        
//        switch desafio.tipo {
//        case "maieutica":
//            let novaSessao = SessaoMaieutica(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.log = Data()
//            
//            novaSessao.projeto = novoProjeto
//        
//        case "texto":
//            let novaSessao = SessaoDesafioMult(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.desafioFeito = true
//            novaSessao.desafioID = Int64(self.desafio.id)
//            novaSessao.enunciado = self.desafio.enunciado
//          //  novaSessao.mediaFoto = Data()
//           // novaSessao.mediaTexto =
//          //  novaSessao.respostaFoto =
//            novaSessao.respostaTexto = self.respostaTexto
//            
//            novaSessao.projeto = novoProjeto
//            
//        case "free writing":
//            let novaSessao = SessaoFreeWriting(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.enunciado = String()
//            novaSessao.resposta = String()
//            
//            novaSessao.projeto = novoProjeto
//            
//        case "ping pong":
//            let novaSessao = SessaoPingPong(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.log = Data()
//            
//            novaSessao.projeto = novoProjeto
//        
//        default:
//            print("tipo invalido")
//            return
//            
//        }
//        
//        do {
//            try viewContext.save()
//            print("eeeeeee :)")
//            dismiss()
//        } catch {
//            let nsError = error as NSError
//            print("aaaah :( \(nsError)")
//        }
//    }
//}
