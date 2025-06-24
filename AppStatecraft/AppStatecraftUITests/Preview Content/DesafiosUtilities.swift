////
////  DesafiosUtilities.swift
////  AppStatecraft
////
////  Created by Aluno 45 on 13/06/25.
////
//
//import Foundation
//import SwiftUI
//
//class DesafiosUtilities: ObservableObject {
//
//    @Published var todosDesafios = [QuestaoDesafios]()
//    @Published var desafiosFeitos = [QuestaoDesafios]()
//    @Published var desafiosNaoFeitos = [QuestaoDesafios]()
//
//
//    init() {
//        //copiaJson()
//        carregaDesafios()
//    }
//
////    func copiaJson() {
////        // manipulacao de arquivos
////        let gerenciaArquivo = FileManager.default
////
////        // obtem caminho ate o arquivo json com as questoes
////        let url = gerenciaArquivo.urls(for: .documentDirectory, in: .userDomainMask)[0]
////        let caminho = url.appendingPathComponent("BancoQuestoes.json")
////
////
////        // copia arquivo json e verifica se ha erros
////        if !gerenciaArquivo.fileExists(atPath: caminho.path){
////            if let origem = Bundle.main.url(forResource: "BancoQuestoes", withExtension: "json") {
////                do {
////                    try gerenciaArquivo.copyItem(at: origem, to: caminho)
////                } catch {
////                    print("erro ao copiar arquivo")
////                }
////            }
////        }
////    }
//
//    func carregaDesafios() {
//
//        // pega url do arquivo json
//        guard let url = Bundle.main.url(forResource: "BancoQuestoes", withExtension: "json") else {
//            print("json file not found")
//            return
//        }
//
//        do {
//            // descarrega os dados decodificados
//            let data = try Data(contentsOf: url)
//            let decodedDesafios = try JSONDecoder().decode([QuestaoDesafios].self, from: data)
//
//
//            DispatchQueue.main.async {
//                self.todosDesafios = decodedDesafios
//                self.desafiosFeitos = self.todosDesafios.filter { $0.feita }
//                self.desafiosNaoFeitos = self.todosDesafios.filter { !$0.feita }
//            }
//
//        }catch {
//            print("erro")
//        }
//    }
////
////    func atualizaJson() {
////        // atualiza o json apos manipular vetores com desafios completos e nao feitos pelo usuario
////        todosDesafios = desafiosFeitos + desafiosNaoFeitos
////
////        do {
////            // codifica dados do vetor para o json e acessa o arquivo pelo caminho
////            let data = try JSONEncoder().encode(todosDesafios)
////            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
////            let fileURL = documentsDirectory.appendingPathComponent("BancoQuestoes.json")
////
////            // escreve no arquivo
////            try data.write(to: fileURL)
////        } catch {
////            print("Erro ao salvar JSON: \(error)")
////        }
////    }
////
//}
