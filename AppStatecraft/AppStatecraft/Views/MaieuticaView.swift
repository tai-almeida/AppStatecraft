import SwiftUI

struct MaieuticaView: View {
    @State private var textoUser = ""
    @StateObject private var viewModel = MaieuticaViewModel()
    @State private var historicoIA: [String] = ["Conte sobre sua ideia!"]
    @State private var indiceAtual = 0
    @State private var respostaUsuario: [String] = [""]
    private let maxPerguntas = 10
    private let limitePerguntasTexto = "Você atingiu o limite de 10 perguntas"
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                
                Text(historicoIA[indiceAtual])
                    .font(.title3)
                    .padding()
                
                Divider()
                
                // Caixa de texto disponivel para digitar
                if(indiceAtual == historicoIA.count - 1){
                    TextField("Escreva aqui", text: $textoUser)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                }
                // Pergunta anterior a texfield vai estar imutável
                else{
                    Text(respostaUsuario[indiceAtual])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                
                Button(action: {
                    Task {
                        if indiceAtual == historicoIA.count - 1 {
                            if indiceAtual < maxPerguntas {
                                if respostaUsuario.count <= indiceAtual {
                                    respostaUsuario.append(textoUser)
                                } else {
                                    respostaUsuario[indiceAtual] = textoUser
                                }
                                
                                let respostaIA = await viewModel.fazerRequisicao(context: textoUser)
                                
                                historicoIA.append(respostaIA)
                                respostaUsuario.append(textoUser)
                                indiceAtual = historicoIA.count - 1
                                textoUser = ""
                            } else {
                                print("Limite de 10 perguntas atingidas!")
                                
                            }
                        } else {
                            if indiceAtual < historicoIA.count - 1{
                                indiceAtual += 1
                            }
                        }
                    }
                })
                {
                    Text("Seguinte")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(Color.indigo)
                .cornerRadius(10)
                .padding(.horizontal)
                .disabled(textoUser.isEmpty)
                .padding(.horizontal)
                .padding(.bottom, 80)
                
                
                Spacer()
                
                
            }
            .navigationTitle("Maiêutica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if (indiceAtual < 0){
                            indiceAtual -= 1
                        }
                    }) {
                        Text("Voltar")
                            .tint(.indigo)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Text("Salvar")
                            .tint(.indigo)
                    }
                }
            }
        }
    }
}

