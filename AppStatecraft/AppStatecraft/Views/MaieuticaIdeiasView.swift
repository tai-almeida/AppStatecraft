import SwiftUI

struct MaieuticaIdeiasView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var textoUser = ""
    @StateObject private var viewModel = MaieuticaViewModel()
    @State private var historicoIA: [String] = ["Conte sobre sua ideia!"]
    @State private var respostasUsuario: [String] = [""]
    @State private var indiceAtual = 0
    private let maxPerguntas = 10
    @State private var mostrarLimitePerguntas = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(historicoIA[indiceAtual])
                    .foregroundColor(.black)
                    .font(.title3)
                Divider()
                
                if indiceAtual == historicoIA.count - 1 {
                    TextField("Escreva aqui", text: $textoUser)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                        .padding(.horizontal)
                } else {
                    Text(respostasUsuario[indiceAtual])
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        if indiceAtual == historicoIA.count - 1 {
                            if historicoIA.count < maxPerguntas {
                                if respostasUsuario.count <= indiceAtual {
                                    respostasUsuario.append(textoUser)
                                } else {
                                    respostasUsuario[indiceAtual] = textoUser
                                }
                                
                                let respostaIA = await viewModel.fazerRequisicao(context: textoUser)
                                historicoIA.append(respostaIA)
                                respostasUsuario.append("")
                                indiceAtual = historicoIA.count - 1
                                textoUser = ""
                            } else {
                                mostrarLimitePerguntas = true
                            }
                        } else {
                            if indiceAtual < historicoIA.count - 1 {
                                indiceAtual += 1
                            }
                        }
                    }
                }) {
                    Text("Seguinte")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.primary)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                }
                .disabled(indiceAtual == historicoIA.count - 1 && textoUser.isEmpty)
            }
            .padding()
            .navigationTitle("Maiêutica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Voltar") {
                        if indiceAtual > 0 {
                            indiceAtual -= 1
                        }
                    }
                    .foregroundColor(.accentColor)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        dismiss()
                    }
                    .foregroundColor(.accentColor)
                }
            }
            .alert("Limite de perguntas atingido", isPresented: $mostrarLimitePerguntas) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Você já respondeu 10 perguntas. Salve ou volte para revisar.")
            }
        }
    }
}

