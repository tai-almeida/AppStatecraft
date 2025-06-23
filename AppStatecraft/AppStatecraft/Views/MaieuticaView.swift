import SwiftUI

struct MaieuticaView: View {
    @State private var textoUser = ""
    @StateObject private var viewModel = MaieuticaViewModel()
    @State private var historicoIA: [String] = ["Conte sobre sua ideia!"]
    @State private var indiceAtual = 0
    @State private var respostaUsuario: [String] = [""]
    private let maxPerguntas = 10
    
    var body: some View {
        NavigationView {
            VStack {
                Text(historicoIA[indiceAtual])
                    .font(.title3)
                    .padding()
                
                Divider()
                
                if(indiceAtual == historicoIA.count - 1){
                    TextField("Escreva aqui", text: $textoUser)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                }
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
                        if historicoIA.count < maxPerguntas {
                            let resposta = await viewModel.fazerRequisicao(context: textoUser)
                            historicoIA.append(resposta)
                            indiceAtual = historicoIA.count - 1
                            textoUser = ""
                        } else {
                            // opcional: alerta ou feedback se tentar passar de 5
                            print("Limite de 5 perguntas atingido")
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
                HStack {
                    Button(action: {
                        if indiceAtual > 0 {
                            indiceAtual -= 1
                        }
                    }) {
                        Text("Anterior")
                    }
                    .disabled(indiceAtual == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        if indiceAtual < historicoIA.count - 1 {
                            indiceAtual += 1
                        }
                    }) {
                        Text("Próximo")
                    }
                    .disabled(indiceAtual >= historicoIA.count - 1)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
            }
            .navigationTitle("Maiêutica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    }) {
                        Text("Cancelar")
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

