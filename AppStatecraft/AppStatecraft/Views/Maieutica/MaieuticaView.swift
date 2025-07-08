import SwiftUI

struct MaieuticaView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var metodologiaAparecendo: Bool
    @State private var textoUser = ""
    @StateObject private var viewModel = MaieuticaViewModel()
    @State private var historicoIA: [String] = ["Conte sobre sua ideia!"]
    @State private var respostasUsuario: [String] = []
    @State private var indiceAtual = 0
    private let maxPerguntas = 10
    @State private var mostrarLimitePerguntas = false
    @State var cliqueButton: Int = 0
    @State private var isShowingDialog = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var sessao: SessaoMaieutica? = nil
    @State private var isShowingAddProjetos = false

    
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
                    if (indiceAtual>0) {
                        Button("Voltar") {
                            if indiceAtual > 0 {
                                indiceAtual -= 1
                            }
                            cliqueButton = 0
                        }
                        .foregroundColor(.accentColor)
                    }
                    else {
                        Button("Cancelar") {
                            cliqueButton = 0
                            dismiss()
                        }
                        .foregroundColor(.accentColor)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Finalizar") {
                        isShowingDialog = true
                    } .foregroundColor(.accentColor) // TODO: queria muito tirar esses um milhao foregroundColor!!
                    .confirmationDialog(
                        "Tem certeza que finalizou o desafio?",
                        isPresented: $isShowingDialog,
                        titleVisibility: .hidden
                    ) {
                        Button("Adicionar a Projeto") {
                            self.respostasUsuario.append(textoUser)
                            sessao = viewModel.criaSessao(contexto: viewContext, historicoIA: historicoIA, respostasUsuario: respostasUsuario)
                            self.isShowingAddProjetos = true
                            self.indiceAtual = 0
                            self.historicoIA = ["Conte sobre sua ideia!"]
                            self.respostasUsuario = []
                        }
                        Button("Salvar em Histórico") {
                            self.respostasUsuario.append(textoUser)
                            
                            sessao = viewModel.criaSessao(contexto: viewContext, historicoIA: historicoIA, respostasUsuario: respostasUsuario)
                            viewModel.salvaContexto(contexto: viewContext)
                            
                            self.indiceAtual = 0
                            self.historicoIA = ["Conte sobre sua ideia!"]
                            self.respostasUsuario = []
                            dismiss()
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
        }.fullScreenCover(isPresented: $isShowingAddProjetos) {
            AddProjetoView(metodologiaAparecendo: $metodologiaAparecendo, sessao: sessao, desafio: nil)
        }
    }
}

