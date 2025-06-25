import SwiftUI
struct MaieuticaIdeiasView: View {
    

    @State private var textoUser = ""
    @StateObject private var viewModel = MaieuticaViewModel()
    @State private var historicoIA: [String] = ["Conte sobre sua ideia!"]
    @State private var respostasUsuario: [String] = [""] // inicia com 1 resposta vazia
    @State private var indiceAtual = 0
    private let maxPerguntas = 5
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Voltar") {
                    if indiceAtual > 0 {
                        indiceAtual -= 1
                    } else {
                        
                    }
                }
                .tint(.indigo)
                Spacer()
                Text("Maiêutica")
                    .font(.headline)
                Spacer()
                Button("Salvar") {
                    // Botão de salvar, implementar logica depois
                }
                .tint(.indigo)
            }
            .padding()
            Divider()
            Text(historicoIA[indiceAtual])
                .font(.title3)
                .padding()
            Divider()
            if indiceAtual == historicoIA.count - 1 {
                TextField("Escreva aqui", text: $textoUser)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            } else {
                Text(respostasUsuario[indiceAtual])
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
                        // Última pergunta → gerar nova
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
                            print("Limite de 5 perguntas atingido")
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
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
            }
            .disabled(indiceAtual == historicoIA.count - 1 && textoUser.isEmpty)
        }
    }
}
