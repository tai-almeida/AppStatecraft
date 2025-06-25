//
//  MaieuticaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 16/06/25.
//

import Foundation
import UIKit

class PingPongViewModel: ObservableObject {
    
    @Published var respostaIA: String = ""
    let textField = UITextField(frame: CGRect(x: 16, y:125, width: UIScreen.main.bounds.width-32, height: 40))
    
    func fazerRequisicao(context: [String]) async -> String? {
        let url = URL(string: "https://api.replicate.com/v1/models/openai/gpt-4o-mini/predictions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // fazer a requisicao
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["API_KEY_PINGPONG"] as? String {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            print ("Bearer \(apiKey)") // autenticacao com a chave da api
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // passar json
        print ("A")
        
        let system_prompt = "Você é um artista que está ajudando outra pessoa a exercitar a criatividade, fornecendo uma palavra para a pessoa dizer tudo que vêm a mente dela."
        
        var auxContext = "Gere uma palavra aleatória em português. Deve ser uma palavra instigante, mas que a maioria das pessoas conhece. Busque sempre variar o tema. Retorne só a palavra, com a primeira letra maiúscula. Não imprima mais texto e pontuação."
        
        if !context.isEmpty {
            auxContext += " Não use as seguintes palavras: "
        }
        
        for palavra in context {
            auxContext += palavra
            auxContext += " "
        }
        
        let jsonBody: [String: Any] = [
            "stream": false,
            "input": [
                "prompt": auxContext,
                "system_prompt": system_prompt, //Concatenei as variaveis dos dois prompts
                "temperature": 1.5,
                "max_completion_tokens": 10,
                "frequency_penalty": 0.8,
                "presence_penalty": 1.0
            ]
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let predictionId = json["id"] as? String {
                let respostaIA = await checarRequisicao(idRequisicao: predictionId)
//                print(respostaIA!)
                self.respostaIA = respostaIA ?? "Erro"
                return respostaIA ?? "Erro"
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func checarRequisicao (idRequisicao: String) async -> String? {
        let url_ans = URL(string: "https://api.replicate.com/v1/predictions/\(idRequisicao)")!
        var request_ans = URLRequest(url: url_ans)
        request_ans.httpMethod = "GET"
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["API_KEY_PINGPONG"] as? String {
            request_ans.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        request_ans.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var retorno: String = ""
        do {
            var (data, _) = try await URLSession.shared.data(for: request_ans)
            if var json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], var terminou = json["status"] as? String {
                while (terminou != "succeeded") {
                    (data, _) = try await URLSession.shared.data(for: request_ans)
                    json = try! JSONSerialization.jsonObject(with: data) as! [String : Any]
                    terminou = json["status"] as! String
                }
                if let ans = try? json["output"] as? [String] {
                    for token_atual in ans {
                        retorno += token_atual
                    }
//                    print (retorno)
                    return retorno
                }
                else {
                    print("erro")
                    return nil
                }
            }
        } catch {
            return nil
        }
        return nil
    }
    
//    init () {
//        self.respostaIA = ""
//    }
}
