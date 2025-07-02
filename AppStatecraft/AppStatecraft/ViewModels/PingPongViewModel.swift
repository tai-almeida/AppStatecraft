//
//  MaieuticaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 16/06/25.
//

import Foundation
import UIKit
import CoreData

class PingPongViewModel: ObservableObject {
    
    func fazerRequisicao(context: [String]) async -> String? {
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
        
        var system_prompt = "Você é um artista que está ajudando outra pessoa a exercitar a criatividade, fornecendo uma palavra para a pessoa dizer tudo que vêm a mente dela. Gere uma palavra aleatória em português. Deve ser uma palavra instigante, mas que a maioria das pessoas conhece. Busque sempre variar o tema. Retorne só a palavra, com a primeira letra maiúscula. Não imprima mais texto e pontuação."
        
        if !context.isEmpty {
            system_prompt += " Não use as seguintes palavras: "
        }
        
        for palavra in context {
            system_prompt += palavra
            system_prompt += " "
        }
        
        let jsonBody: [String: Any] = [
            "model": "gpt-4o-mini-2024-07-18",
            "input": system_prompt
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            if let text = decoded.output.first?.content.first?.text {
                return text
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func continuarPingPong (context: [String]) async -> String? {
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
        
        var system_prompt = "Você é um artista que está ajudando outra pessoa a exercitar a criatividade. Gere uma palavra em português. Deve ser uma palavra instigante, mas que a maioria das pessoas conhece. Retorne só a palavra, com a primeira letra maiúscula. Não imprima mais texto e pontuação."
        
        if !context.isEmpty {
            system_prompt += " Gere uma palavra relacionada com a seguinte palavra: \(context.last ?? "Criatividade"), mas sem repetir nenhuma das seguintes palavras: "
        }
        
        for palavra in context {
            system_prompt += palavra
            system_prompt += ", "
        }
        
        let jsonBody: [String: Any] = [
            "model": "gpt-4o-mini-2024-07-18",
            "input": system_prompt
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            if let text = decoded.output.first?.content.first?.text {
                return text
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    
    func salvarSemProjeto(contexto: NSManagedObjectContext, palavras: [String]){
        let novaSessao = SessaoPingPong(context: contexto)
        novaSessao.id = UUID()
        novaSessao.data = Date()
        
        do {
            let logData = try JSONEncoder().encode(palavras)
            novaSessao.log = logData
            try contexto.save()
            print("deu bom salvou")
                
        }catch{
            print("Desafio ta vazio")
        }
    }
}
