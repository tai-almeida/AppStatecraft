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
    
    @Published var todosPrompts = [PromptFW]()
    @Published var promptsFeitos = [PromptFW]()
    @Published var promptsNaoFeitos = [PromptFW]()
    @Published var isShowingDialog = false
    @Published var respostaTexto: String = ""


    //@Published var desafio = SessaoDesafioMult()
    
    //    private var dadosURL: URL {
    //        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //        return documentsDirectory.appendingPathComponent("BancoQuestoes.json")
    //    }
    
    //var desafiosUtilities = DesafiosUtilities()
    
    init() {
        copiaJson()
        carregaPrompts()
        verificaPromptsVazios()
//
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

        // pega url do arquivo json
        guard let url = Bundle.main.url(forResource: "BancoFW", withExtension: "json") else {
            print("json file not found")
            return
        }

        do {
            // descarrega os dados decodificados
            let data = try Data(contentsOf: url)
            let decodedPrompts = try JSONDecoder().decode([PromptFW].self, from: data)


            self.todosPrompts = decodedPrompts
            self.promptsFeitos = self.todosPrompts.filter { $0.feita }
            self.promptsNaoFeitos = self.todosPrompts.filter { !$0.feita }

        }catch {
            print("erro")
        }
    }
    
    func copiaJson() {
        // manipulacao de arquivos
        let gerenciaArquivo = FileManager.default

        // obtem caminho ate o arquivo json com as questoes
        let url = gerenciaArquivo.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let caminho = url.appendingPathComponent("BancoFW.json")


        // copia arquivo json e verifica se ha erros
        if !gerenciaArquivo.fileExists(atPath: caminho.path){
            if let origem = Bundle.main.url(forResource: "BancoFW", withExtension: "json") {
                do {
                    try gerenciaArquivo.copyItem(at: origem, to: caminho)
                } catch {
                    print("erro ao copiar arquivo")
                }
            }
        }
    }
    
//        func carregaDados() {
//            //desafiosUtilities.carregaDesafios()
//
//            self.promptsFeitos = desafiosUtilities.desafiosFeitos
//            self.desafiosNaoFeitos = desafiosUtilities.desafiosNaoFeitos
//            verificaDesafiosVazios()
//
//        }
    
    func verificaPromptsVazios() {
        if promptsNaoFeitos.isEmpty {
            for prompt in promptsFeitos {
                var copiaPrompt = prompt
                copiaPrompt.feita = false
                promptsNaoFeitos.append(copiaPrompt)
            }
            promptsFeitos.removeAll()
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
    func sorteiaPrompt() -> PromptFW? {
        /* Sorteia um desafio dentre os nao feitos para o usuario fazer */
        verificaPromptsVazios()
        return promptsNaoFeitos.randomElement()
    }
    
    func criarSessao(contexto: NSManagedObjectContext) -> SessaoFreeWriting {
        let sessaoFreeWriting = SessaoFreeWriting(context: contexto)
        sessaoFreeWriting.id = UUID()
        sessaoFreeWriting.data = Date()
        
        return sessaoFreeWriting
    }
    
    func salvarContexto(sessao: SessaoFreeWriting, contexto: NSManagedObjectContext, respostaTexto: String, prompt: String) {
        do {
            sessao.enunciado = prompt
            sessao.resposta = respostaTexto
            try contexto.save()
        } catch {
            print("erro ao salvar a resposta - \(error)")
        }
    }
}

