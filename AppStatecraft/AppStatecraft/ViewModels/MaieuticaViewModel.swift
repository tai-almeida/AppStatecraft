//
//  MaieuticaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 16/06/25.
//

import Foundation

class MaieuticaViewModel: ObservableObject {

    func fazerRequisicao(context: String) async -> String {
        let url = URL(string: "https://api.replicate.com/v1/models/openai/gpt-4o-mini/predictions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Pega a chave da Secrets.plist
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["API_KEY"] as? String {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let system_prompt = """
        Como Sócrates, você deve realizar o processo da maiêutica com base no prompt. Dado uma ideia escrita por um usuário, identifique os termos mais importantes e gere uma pergunta bem sucinta e que faça sentido, mas também criativa, que estimule o usuário a expandir sua ideia. Questione a viabilidade, implicações e suposições por trás dos termos usados. Evite repetir a ideia. Seja direto e instigante. Faça uma pergunta bem curta, finalizada por um ponto de interrogação. Não disserte, só faça a pergunta.
        """
        
        let jsonBody: [String: Any] = [
            "stream": false,
            "input": [
                "prompt": context,
                "system_prompt": system_prompt,
                "temperature": 0.9,
                "max_completion_tokens": 45
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let predictionId = json["id"] as? String {
                
                // Espera a resposta finalizada
                if let resposta = await checarRequisicao(idRequisicao: predictionId) {
                    return resposta
                } else {
                    return "Erro ao obter resposta."
                }
            } else {
                return "Erro ao criar requisição."
            }
        } catch {
            return "Erro: \(error.localizedDescription)"
        }
    }
    
    /// Checa o status da requisição até terminar, e retorna a resposta
    func checarRequisicao(idRequisicao: String) async -> String? {
        let url_ans = URL(string: "https://api.replicate.com/v1/predictions/\(idRequisicao)")!
        var request_ans = URLRequest(url: url_ans)
        request_ans.httpMethod = "GET"
        
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["API_KEY"] as? String {
            request_ans.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        request_ans.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            var (data, _) = try await URLSession.shared.data(for: request_ans)
            if var json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               var status = json["status"] as? String {
                
                // Espera até terminar
                while status != "succeeded" {
                    try await Task.sleep(nanoseconds: 1_000_000_000) // 1 segundo entre tentativas
                    (data, _) = try await URLSession.shared.data(for: request_ans)
                    json = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                    status = json["status"] as? String ?? "error"
                }
                
                if let ans = json["output"] as? [String] {
                    return ans.joined()
                } else {
                    return nil
                }
            }
        } catch {
            return nil
        }
        return nil
    }
}

