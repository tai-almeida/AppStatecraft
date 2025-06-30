//
//  MaieuticaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 16/06/25.
//

import Foundation

struct ContentItem: Codable {
    let type: String
    let text: String
}

struct OutputItem: Codable {
    let content: [ContentItem]
}

struct OpenAIResponse: Codable {
    let output: [OutputItem]
}

class MaieuticaViewModel: ObservableObject {

    func fazerRequisicao(context: String) async -> String {
        let url = URL(string: "https://api.openai.com/v1/responses")!
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
        Como Sócrates, você deve realizar o processo da maiêutica com base no prompt. Dado uma ideia escrita por um usuário, identifique os termos mais importantes e gere uma pergunta bem sucinta e que faça sentido, mas também criativa, que estimule o usuário a expandir sua ideia. Questione a viabilidade, implicações e suposições por trás dos termos usados. Evite repetir a ideia. Seja direto e instigante. Faça uma pergunta bem curta, finalizada por um ponto de interrogação. Não disserte, só faça a pergunta. Segue o prompt do usuário:
        """
        
        let jsonBody: [String: Any] = [
            "model": "gpt-4o-mini-2024-07-18",
            "input": system_prompt + context
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            if let text = decoded.output.first?.content.first?.text {
                print("Texto da resposta: \(text)")
                return text
            } else {
                return "Texto não encontrado"
            }
        } catch {
            return "Erro ao decodificar JSON: \(error)"
        }
    }
}

