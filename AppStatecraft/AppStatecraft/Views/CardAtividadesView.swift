//
//  CardAtividadesView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 03/07/25.
//

import SwiftUI

struct CardAtividadesView: View {
    @State var sessao: Sessao
    
    var textoPesquisavel: String {
        if let maieutica = sessao as? SessaoMaieutica,
           let log = maieutica.log,
           let historico = try? JSONDecoder().decode([PromptResposta].self, from: log) {
            var texto = "Maiêutica "
            for item in historico {
                texto += item.resposta + " "
            }
            return texto
        } else if let pingpong = sessao as? SessaoPingPong,
                  let log = pingpong.log,
                  let historico = try? JSONDecoder().decode([String].self, from: log) {
            
            var texto = "Ping-Pong "
            for item in historico {
                texto += item + " "
            }
            return texto
        } else if let freewriting = sessao as? SessaoFreeWriting {
            var texto = "Free-Writing "
            texto += freewriting.enunciado ?? "Vazio"
            texto += " "
            texto += freewriting.resposta ?? "vazio"
            
            return texto
        } else if let multimidia = sessao as? SessaoDesafioMult {
            var texto = "Desafios Multimídia "
            texto += multimidia.enunciado ?? "Vazio"
            texto += " "
            if multimidia.respostaFoto != nil {
                texto += multimidia.respostaTexto ?? "Vazio"
            }
            return texto
        }
        return ""
    }
     
    
    var body: some View {
            
            if let maieutica = sessao as? SessaoMaieutica {
                if let logMaieutica = maieutica.log,
                   let historico = try? JSONDecoder().decode([PromptResposta].self, from: logMaieutica),
                   !historico.isEmpty {
                    let historicoOrdenado = historico.sorted { $0.index < $1.index }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Maiêutica")
//                                .padding()
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding(.bottom)
//                                .weight(.bold)
                            
                            Text(historicoOrdenado[0].resposta)
                                .lineLimit(2)
                                .font(.body)
                            
                            Divider()
                            
                            Text(maieutica.data ?? Date(), style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(UIColor.tertiarySystemBackground))
                                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2) // Sombra mais sutil e adaptável
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                        
                }
                    
            } else if let multimidia = sessao as? SessaoDesafioMult {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Desafio Multimídia")
//                                .padding()
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding(.bottom)
//                            .weight(.bold)
                            
                        
                        Text(multimidia.enunciado ?? "Vazio")
                            .lineLimit(2)
                            .font(.body)
                        
                        Divider()
                        
                        Text(multimidia.data ?? Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.tertiarySystemBackground))
                            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2) // Sombra mais sutil e adaptável
                        )
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                    
            } else if let pingpong = sessao as? SessaoPingPong {
                if let logPingPong = pingpong.log,
                   let historico = try? JSONDecoder().decode([String].self, from: logPingPong),
                   !historico.isEmpty {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Ping-Pong")
//                                .padding()
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding(.bottom)
//                                .weight(.bold)
                            Text(historico.enumerated()
                                    .map {$0.element}
                                    .joined(separator: " -> "))
                                    .lineLimit(1)
                                    .font(.body)
                            
                            Divider()
                            
                            Text(pingpong.data ?? Date(), style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(UIColor.tertiarySystemBackground))
                                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2) // Sombra mais sutil e adaptável
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                        
                }
                    
            } else if let freewriting = sessao as? SessaoFreeWriting {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Free-Writing")
//                                .padding()
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding(.bottom)
//                            .weight(.bold)
                            
                        
                        Text(freewriting.enunciado ?? "Vazio")
                            .lineLimit(2)
                            .font(.body)
                        
                        Divider()
                        
                        Text(freewriting.data ?? Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.tertiarySystemBackground))
                            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2) // Sombra mais sutil e adaptável
                        )
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
        }
        
    }


