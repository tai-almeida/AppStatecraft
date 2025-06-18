//
//  MaieuticaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 16/06/25.
//

import Foundation

class MaieuticaViewModel: ObservableObject {
    
    @Published var respostaIA: String
    
    func gerarSystemPromptPersona(textoUser: String) -> String {
        return "Você é um analista criativo. Dado uma ideia escrita por um usuário como essa \"\(textoUser)\", identifique os termos mais importantes e gere perguntas críticas, provocativas ou criativas que estimulem o usuário a expandir sua ideia. Questione o significado, viabilidade, implicações e suposições por trás dos termos usados. Evite repetir a ideia. Seja direto e instigante."
    }
    
    
    
    func fazerRequisicao(context: String) async -> String? {
        let url = URL(string: "https://api.replicate.com/v1/models/meta/meta-llama-3-8b-instruct/predictions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["API_KEY"] as? String {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let system_promptPersona = gerarSystemPromptPersona(textoUser: context)
        
        let system_prompt = "Como Sócrates você deve realizar o processo da maiêutica com base no prompt. Dado uma ideia escrita por um usuário, identifique os termos mais importantes e gere uma pergunta bem sucinta e que faça sentido, mas também criativa que estimule o usuário a expandir sua ideia. Questione a viabilidade, implicações e suposições por trás dos termos usados. Evite repetir a ideia. Seja direto e instigante. Faça uma pergunta bem curta, finalizada por um ponto de interrogação. Não disserte, só faça a pergunta."
        
        let jsonBody: [String: Any] = [
            "stream": false,
            "input": [
                "prompt": context,
                "system_prompt": system_prompt, //Concatenei as variaveis dos dois prompts
                "max_tokens": 45,
                "min_tokens": 15,
                "temperature": 0.9,
                "length_penalty": 0.1,
                "prompt_template": "<|begin_of_text|><|start_header_id|>system<|end_header_id|>\n\n{system_prompt}<|eot_id|><|start_header_id|>user<|end_header_id|>\n\n{prompt}<|eot_id|><|start_header_id|>assistant<|end_header_id|>\n\n",
                "max_new_tokens": 45,
                "min_new_tokens": 15
            ]
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let predictionId = json["id"] as? String {
                let respostaIA = await checarRequisicao(idRequisicao: predictionId)
                self.respostaIA = respostaIA ?? "Erro"
                return respostaIA
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
           let apiKey = dict["API_KEY"] as? String {
            request_ans.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        request_ans.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var retorno: String = ""
        do {
            let (data, _) = try await URLSession.shared.data(for: request_ans)
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let ans = json["output"] as? [String] {
                for token_atual in ans {
                    retorno += token_atual
                }
                return retorno
            }
        } catch {
            return nil
        }
        return nil
    }
    
    init () {
        self.respostaIA = "Conte sobre sua ideia!"
    }
}
