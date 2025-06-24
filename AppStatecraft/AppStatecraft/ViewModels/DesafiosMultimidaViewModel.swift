//
//  DesafiosMultimidaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 13/06/25.
//

import Foundation
import SwiftUI

class DesafiosMultimidiaViewModel: ObservableObject {
    
    @Published var todosDesafios = [QuestaoDesafios]()
    @Published var desafiosFeitos = [QuestaoDesafios]()
    @Published var desafiosNaoFeitos = [QuestaoDesafios]()
    
    //@Published var desafio = SessaoDesafioMult()
    
    //    private var dadosURL: URL {
    //        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //        return documentsDirectory.appendingPathComponent("BancoQuestoes.json")
    //    }
    
    //var desafiosUtilities = DesafiosUtilities()
    
    init() {
        copiaJson()
        carregaDesafios()
        verificaDesafiosVazios()
        
    }
    
    func atualizaJson() {
        // atualiza o json apos manipular vetores com desafios completos e nao feitos pelo usuario
        todosDesafios = desafiosFeitos + desafiosNaoFeitos
        
        do {
            // codifica dados do vetor para o json e acessa o arquivo pelo caminho
            let data = try JSONEncoder().encode(todosDesafios)
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("BancoQuestoes.json")
            
            // escreve no arquivo
            try data.write(to: fileURL)
        } catch {
            print("Erro ao salvar JSON: \(error)")
        }
    }
    
    func carregaDesafios() {
        
        // pega url do arquivo json
        guard let url = Bundle.main.url(forResource: "BancoQuestoes", withExtension: "json") else {
            print("json file not found")
            return
        }
        
        do {
            // descarrega os dados decodificados
            let data = try Data(contentsOf: url)
            let decodedDesafios = try JSONDecoder().decode([QuestaoDesafios].self, from: data)
            
            
            self.todosDesafios = decodedDesafios
            self.desafiosFeitos = self.todosDesafios.filter { $0.feita }
            self.desafiosNaoFeitos = self.todosDesafios.filter { !$0.feita }
            
        }catch {
            print("erro")
        }
    }
    
    func copiaJson() {
        // manipulacao de arquivos
        let gerenciaArquivo = FileManager.default
        
        // obtem caminho ate o arquivo json com as questoes
        let url = gerenciaArquivo.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let caminho = url.appendingPathComponent("BancoQuestoes.json")
        
        
        // copia arquivo json e verifica se ha erros
        if !gerenciaArquivo.fileExists(atPath: caminho.path){
            if let origem = Bundle.main.url(forResource: "BancoQuestoes", withExtension: "json") {
                do {
                    try gerenciaArquivo.copyItem(at: origem, to: caminho)
                } catch {
                    print("erro ao copiar arquivo")
                }
            }
        }
    }
    
    //    func carregaDados() {
    //        //desafiosUtilities.carregaDesafios()
    //
    //        self.desafiosFeitos = desafiosUtilities.desafiosFeitos
    //        self.desafiosNaoFeitos = desafiosUtilities.desafiosNaoFeitos
    //        verificaDesafiosVazios()
    //
    //    }
    
    func verificaDesafiosVazios() {
        if desafiosNaoFeitos.isEmpty {
            for desafio in desafiosFeitos {
                var copiaDesafio = desafio
                copiaDesafio.feita = false
                desafiosNaoFeitos.append(copiaDesafio)
            }
            desafiosFeitos.removeAll()
        } else {
            return
        }
    }
    
    func desafioConcluido(desafioRealizado: QuestaoDesafios) {
        var copiaDesafio: QuestaoDesafios = desafioRealizado
        
        // encontra o elemento de id igual ao do desafio feito no vetor de nao realizados
        if let index = desafiosNaoFeitos.firstIndex(where: { $0.id == desafioRealizado.id }) {
            copiaDesafio.feita = true
            desafiosNaoFeitos.remove(at: index)
            desafiosFeitos.append(copiaDesafio)
        }
    }
    
    func sorteiaDesafio() -> QuestaoDesafios? {
        /* Sorteia um desafio dentre os nao feitos para o usuario fazer */
        verificaDesafiosVazios()
        return desafiosNaoFeitos.randomElement()
    }
}
