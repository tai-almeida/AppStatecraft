//
//  HistoricoDesafiosView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 25/06/25.
//

import SwiftUI

struct HistoricoView: View {
    @Environment(\.managedObjectContext) private var contexto
    @State var tipoMetodologia: String
    @State private var sessaoSelecionada: Sessao? //quando tiver valor o modal abre
    @StateObject private var historicoVM = HistoricoViewModel()
    
    var body: some View {
        VStack{
            //refatorar isso depois em um jeito menos porco
            if historicoVM.sessoes.isEmpty  {
                Text("Não há sessões salvas de \(tipoMetodologia).")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
                //ver como deixar mais bonitinho essa view depois
            }else{
                List{
                    ForEach(historicoVM.sessoes, id: \.objectID) { sessao in
                        
                        Button(action: {
                            sessaoSelecionada = sessao
                        }) {
                            if let multimidia = sessao as? SessaoDesafioMult {
                                HStack {
                                    Text(multimidia.enunciado ?? "vazio").lineLimit(1)
                                    Spacer()
                                    Text(multimidia.data ?? Date(), style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Image(systemName: "chevron.right").foregroundColor(Color(.tertiaryLabel))
                                    
                                }.foregroundColor(.primary)
                            }
                            else if let pingpong = sessao as? SessaoPingPong {
                                HStack {
                                    if let logData = pingpong.log,
                                       let palavras = try? JSONDecoder().decode([String].self, from: logData),
                                       !palavras.isEmpty {
                                        Text(palavras[0])
                                    } else {
                                        Text("vazio")
                                    }
                                    Spacer()
                                    Text(pingpong.data ?? Date(), style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }.foregroundColor(.primary)
                            }
                            else if let freewriting = sessao as? SessaoFreeWriting{
                                HStack {
                                    Text(freewriting.enunciado ?? "vazio").lineLimit(1)
                                    Spacer()
                                    Text(freewriting.data ?? Date(), style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Image(systemName: "chevron.right").foregroundColor(Color(.tertiaryLabel))
                                    
                                }.foregroundColor(.primary)
                                
                            }
                            else if let maieutica = sessao as? SessaoMaieutica {
                                HStack {
                                    if let logData = maieutica.log,
                                       let historico = try? JSONDecoder().decode([String:String].self, from: logData),
                                       !historico.isEmpty {
                                        Text(historico.values.first ?? "Erro").lineLimit(1)
                                    } else {
                                        Text("vazio")
                                    }
                                    Spacer()
                                    Text(maieutica.data ?? Date(), style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }.foregroundColor(.primary)
                                //TODO: display de outras metodologias aqui
                            }
                        }
                    }
                    .sheet(item: $sessaoSelecionada) { sessao in
                        //TODO: colocar aqui as views especificas de visualizacao para cada metodologia salva
                        if let multimidia = sessao as? SessaoDesafioMult {
                            MultimidiaSalvoView(sessao: multimidia)
                        }else if let pingpong = sessao as? SessaoPingPong {
                            Text("Sessão Ping Pong")
                            PingPongSalvoView(sessao: pingpong)
                        }else if let maieutica = sessao as? SessaoMaieutica{
                            Text("Sessao Maieutica")
                        }else if let freewriting = sessao as? SessaoFreeWriting{
                            FreeWritingSalvo()
                        }
                    }
                }
            }
        }
        .onAppear {
            historicoVM.fetchDesafiosFeitos(contexto: contexto, tipo: tipoMetodologia)
        }
        .onChange(of: tipoMetodologia) { novoTipo in
            historicoVM.fetchDesafiosFeitos(contexto: contexto, tipo: novoTipo)
        }
    }
}
