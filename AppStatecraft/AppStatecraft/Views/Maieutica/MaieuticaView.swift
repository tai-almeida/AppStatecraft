import SwiftUI

struct MaieuticaView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var textoUser = ""
    @StateObject private var viewModel = MaieuticaViewModel()
    @State private var historicoIA: [String] = ["Conte sobre sua ideia!"]
    @State private var respostasUsuario: [String] = []
    @State private var indiceAtual = 0
    private let maxPerguntas = 10
    @State private var mostrarLimitePerguntas = false
    @State var cliqueButton: Int = 0
    @State private var isShowingDialog = false
    @State private var isShowingAddProjetos = false
    @Environment(\.managedObjectContext) private var viewContext

    
    var body: some View {
        NavigationView {
            VStack() {
                Text(historicoIA[indiceAtual])
                    .foregroundColor(.black)
                    .font(.title3)
                    //.padding(.horizontal)
                Divider()
                
                if indiceAtual == historicoIA.count - 1 {
                    RespostaMaieutica(respostaTexto: $textoUser)
                        .foregroundColor(.black)
                } else {
                    ZStack {
                        ZStack(alignment: .topLeading) {
                            Text(respostasUsuario[indiceAtual])
                                .font(.body)
                                .padding(8)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accessibilityHidden(true)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            
                        }
                    }
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {cliqueButton += 1; 
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
                                //respostasUsuario.append("")
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
                        cliqueButton = 0
                    }
                }) {
                    Text("Seguinte")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .padding(.vertical)
                }
                .disabled((indiceAtual == historicoIA.count - 1 && textoUser.isEmpty) || (cliqueButton>=1))
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
                        cliqueButton = 0
                    }
                    .foregroundColor(.accentColor)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        isShowingDialog = true
                    } .foregroundColor(.accentColor) // TODO: queria muito tirar esses um milhao foregroundColor!!
                    .confirmationDialog(
                        "Tem certeza que finalizou o desafio?",
                        isPresented: $isShowingDialog,
                        titleVisibility: .hidden
                    ) {
                        Button("Adicionar a Projeto") {
                            print(indiceAtual)
                            print(historicoIA.count)
                            print(respostasUsuario.count)
                            self.isShowingAddProjetos = true
                            self.respostasUsuario.append(textoUser)
                            //dps associamos a projeto
                            viewModel.salvarSemProjeto(
                                contexto: viewContext,
                                historicoIA: historicoIA,
                                respostasUsuario: respostasUsuario
                            )
                            //TODO: logica de permanencia dos dados sinistra
                            //criar o "objeto"
                            //navegar para o modal de adicionar a projeto
                            //salvar o objeto no coredata quando a pessoa clicar no projeto
                            
                            self.indiceAtual = 0
                            self.historicoIA = ["Conte sobre sua ideia!"]
                            self.respostasUsuario = []
                            dismiss()
                        }
                        Button("Salvar em Esboços") {
                            //TODO: logica de permanencia dos dados, so que salvar no esbocos tomee
                        }
                        Button("Descartar", role: .destructive) {
                            dismiss()
                        }
                        Button("Continuar Editando", role: .cancel) {
                            isShowingDialog = false
                        }
                    }
                    .foregroundColor(.accentColor)
                }
            }
            .alert("Limite de perguntas atingido", isPresented: $mostrarLimitePerguntas) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Você já respondeu 10 perguntas. Salve ou apague sua sessão.")
            }
        }
    }
}

