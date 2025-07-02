//
//  DesafiosMultimidaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 13/06/25.
//

import Foundation
import SwiftUI
import CoreData

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
    
    func criarSessao(contexto: NSManagedObjectContext) -> SessaoDesafioMult {
        
        let sessaoDesafio = SessaoDesafioMult(context: contexto)
        sessaoDesafio.id = UUID()
        sessaoDesafio.data = Date()
        
       return sessaoDesafio
    }
    
    func salvarContexto(sessao: SessaoDesafioMult, contexto: NSManagedObjectContext, respostaTexto: String, respostaImagem: UIImage?, desafio: QuestaoDesafios?) {
        do {
            if let desafio = desafio{
                
                sessao.enunciado = desafio.enunciado
                sessao.desafioID = Int64(desafio.id)
                sessao.desafioFeito = desafio.feita
                
                if desafio.tipo == "imagem"{
                    sessao.mediaFoto = converterAssetParaData(nome: desafio.conteudo)
                }else{
                    sessao.mediaTexto = desafio.conteudo
                }
                
                //se a resposta do usuario for uma imagem
                if let img = respostaImagem {
                    sessao.respostaFoto = img.pngData() //transformar para binary data
                }else{
                    sessao.respostaTexto = respostaTexto
                }
                
                try contexto.save()
                print("deu bom salvou")
            }else{
                print("Desafio ta vazio")
            }
        } catch {
            print("erro ao salvar a resposta - \(error)")
        }
    }
    
    func converterAssetParaData(nome: String) -> Data? {
        // criar a UIImage a partir do nome do asset
        guard let uiImage = UIImage(named: nome) else {
            print("Erro: Imagem com o nome '\(nome)' não encontrada no Asset Catalog.")
            return nil
        }
        
        // cconverter a UIImage para o formato PNG Data
        guard let data = uiImage.pngData() else {
            print("Erro: Não foi possível converter a UIImage '\(nome)' para Data.")
            return nil
        }

        return data
    }
    

}
