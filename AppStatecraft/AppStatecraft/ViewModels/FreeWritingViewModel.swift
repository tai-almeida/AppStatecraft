//
//  DesafiosMultimidaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 13/06/25.
//

import Foundation
import SwiftUI
import CoreData


class FreeWritingViewModel: ObservableObject {
    
    @Published var todosPrompts: [PromptFW]?
    @Published var promptsFeitos: [PromptFW]?
    @Published var promptsNaoFeitos: [PromptFW]?
    @Published var isShowingDialog = false
    @Published var respostaTexto: String = ""


    //@Published var desafio = SessaoDesafioMult()
    
    //    private var dadosURL: URL {
    //        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //        return documentsDirectory.appendingPathComponent("BancoQuestoes.json")
    //    }
    
    //var desafiosUtilities = DesafiosUtilities()
    
    init() {
        if (todosPrompts == nil) {
            todosPrompts = [PromptFW]()
        }
        if (promptsFeitos == nil) {
            promptsFeitos = [PromptFW]()
        }
        if (promptsNaoFeitos == nil) {
            promptsNaoFeitos = [PromptFW]()
        }
        //copiaJson()
        carregaPrompts()
        verificaPromptsVazios()
//
    }
    
    func atualizaJson() {
        // atualiza o json apos manipular vetores com desafios completos e nao feitos pelo usuario
        todosPrompts = promptsFeitos! + promptsNaoFeitos!
        //print(todosDesafios)
        print("ATUALIZA")
        //print(todosPrompts)
        
        do {
            // codifica dados do vetor para o json e acessa o arquivo pelo caminho
            let data = try JSONEncoder().encode(todosPrompts)
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("BancoFW.json")
            
            // escreve no arquivo
            try data.write(to: fileURL)
            
        } catch {
            print("Erro ao salvar JSON: \(error)")
        }
    }
    
//    func atualizaJson() {
//        // atualiza o json apos manipular vetores com desafios completos e nao feitos pelo usuario
//        todosDesafios = desafiosFeitos + desafiosNaoFeitos
//
//        do {
//            // codifica dados do vetor para o json e acessa o arquivo pelo caminho
//            let data = try JSONEncoder().encode(todosDesafios)
//            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let fileURL = documentsDirectory.appendingPathComponent("BancoQuestoes.json")
//
//            // escreve no arquivo
//            try data.write(to: fileURL)
//        } catch {
//            print("Erro ao salvar JSON: \(error)")
//        }
//    }
    
    func carregaPrompts() {
        
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("BancoFW.json")
        if let data = try? Data(contentsOf: fileURL),
           let decodedPlants = try? JSONDecoder().decode([PromptFW].self, from: data) {
            todosPrompts = decodedPlants
            self.promptsFeitos = self.todosPrompts!.filter { $0.feita }
            self.promptsNaoFeitos = self.todosPrompts!.filter { !$0.feita }
            //print(todosDesafios)
        } else {
            guard let url = Bundle.main.url(forResource: "BancoFW", withExtension: "json") else {
                print("json file not found")
                return
            }
            if let dataBundle = try? Data(contentsOf: url),
               let decodedPrompts = try? JSONDecoder().decode([PromptFW].self, from: dataBundle) {
                todosPrompts = decodedPrompts
                self.promptsFeitos = self.todosPrompts!.filter { $0.feita }
                self.promptsNaoFeitos = self.todosPrompts!.filter { !$0.feita }
            }
        }
    }
    
    
    func verificaPromptsVazios() {
        if promptsNaoFeitos!.isEmpty {
            for prompt in promptsFeitos! {
                var copiaPrompt = prompt
                copiaPrompt.feita = false
                promptsNaoFeitos!.append(copiaPrompt)
            }
            promptsFeitos!.removeAll()
        } else {
            return
        }
    }
//
//    func desafioConcluido(desafioRealizado: QuestaoDesafios) {
//        var copiaDesafio: QuestaoDesafios = desafioRealizado
//
//        // encontra o elemento de id igual ao do desafio feito no vetor de nao realizados
//        if let index = desafiosNaoFeitos.firstIndex(where: { $0.id == desafioRealizado.id }) {
//            copiaDesafio.feita = true
//            desafiosNaoFeitos.remove(at: index)
//            desafiosFeitos.append(copiaDesafio)
//        }
//    }
//
    func promptConcluido(promptRealizado: PromptFW) {
        //var copiaDesafio: QuestaoDesafios = desafioRealizado
        var copiaPrompt = PromptFW(id: promptRealizado.id, enunciado: promptRealizado.enunciado, feita: true)
        
        // encontra o elemento de id igual ao do desafio feito no vetor de nao realizados
        if let index = promptsNaoFeitos!.firstIndex(where: { $0.id == promptRealizado.id }) {
            promptsNaoFeitos!.remove(at: index)
            promptsFeitos!.append(copiaPrompt)
            //print(desafiosFeitos)
        }
        //print("Atualizado")
        //print(todosPrompts)
    }
    
    
    func sorteiaPrompt() -> PromptFW? {
        /* Sorteia um desafio dentre os nao feitos para o usuario fazer */
        verificaPromptsVazios()
        return promptsNaoFeitos!.randomElement()
    }
    
    func criarSessao(contexto: NSManagedObjectContext, resposta: String, prompt: PromptFW) -> SessaoFreeWriting {
        let sessaoFreeWriting = SessaoFreeWriting(context: contexto)
        sessaoFreeWriting.id = UUID()
        sessaoFreeWriting.data = Date()
        
        sessaoFreeWriting.enunciado = prompt.enunciado
        sessaoFreeWriting.resposta = resposta
        
        return sessaoFreeWriting
    }
    
    func salvarContexto(contexto: NSManagedObjectContext) {
        do {
            try contexto.save()
        } catch {
            print("erro ao salvar a resposta - \(error)")
        }
    }
}

