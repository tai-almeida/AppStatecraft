//
//  CardAtividadesView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 03/07/25.
//

import SwiftUI

struct CardAtividadesView: View {
    @State var sessao: Sessao
     
    
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
                                .foregroundColor(.black)
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
                                .fill(.gray)
                                .brightness(0.3)
                                .shadow(radius: 4)
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
                            .foregroundColor(.black)
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
                            .fill(.gray)
                            .brightness(0.3)
                            .shadow(radius: 4)
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
                                .foregroundColor(.black)
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
                                .fill(.gray)
                                .brightness(0.3)
                                .shadow(radius: 4)
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
                            .foregroundColor(.black)
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
                            .fill(.gray)
                            .brightness(0.3)
                            .shadow(radius: 4)
                        )
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
        }
        
    }


