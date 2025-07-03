import SwiftUI
import CoreData

struct ProjetosView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Projeto.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Projeto.data, ascending: false)]
        
    ) private var projetos: FetchedResults<Projeto>
    
    @State private var minhaIdeiaModal = false
    @State private var adicionarProjeto = false
    @Binding var pesquisarProjeto: String
    @State private var projetosConcluidos = "Em andamento"
    @State private var addProjetoVazio = false
    @State var nomeProjeto = ""

    
    let colunaCard = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Picker("", selection: $projetosConcluidos) {
                    Text("Em andamento").tag("Em andamento")
                    Text("Concluido").tag("Concluido")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top, 8)
                
                if projetosConcluidos == "Em andamento" {
                    VStack(alignment: .center) {
                        ScrollView {
                            LazyVGrid(columns: colunaCard, spacing: 16){
//                                CardMyProject(
//                                    systemImage: "lightbulb.fill",
//                                    titulo: "Minhas Ideias",
//                                    corDeFundo: Color.yellow.opacity(0.2)
//                                ) {
//                                    minhaIdeiaModal = true
//                                }
                                
                                ForEach(projetos.filter { !$0.finalizado }) { projeto in
                                    projetoCardView(projeto: projeto)
                                    
                                }
                            }
//                            .padding(20)
                            
                            //                        LazyVGrid(columns: coalumns, spacing: 20) {
                            //                            ForEach(projetos, id: \.self) { projeto in
                            //                                NavigationLink(destination: detalhesProjetoView(projeto: projeto)) {
                            //                                    Text(projeto.nome ?? "Sem nome")
                            //                                }
                            //                            }
                            //                        }
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                } else {
                    VStack {
                        Text("Conteúdo dos projetos concluídos")
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 10)
            .navigationTitle("Projetos")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        addProjetoVazio = true
                        // Lógica de criar um projeto novo
                        print("Novo projeto criado")
                        
                    }) {
                        Image(systemName: "plus")
                    }

                    .sheet(isPresented: $addProjetoVazio) {
                        AddProjetoVazioView(nomeProjeto: $nomeProjeto)
                    }

//                    Button(action: {
//
//                        //Lógica de editar um projeto existente
//
//                        print("teste editando editando")
//
//                    }) {
//                        Image(systemName: "pencil")
//                    }

                }
            }
            .searchable(text: $pesquisarProjeto)
        }
        .sheet(isPresented: $minhaIdeiaModal) {
            VStack {
                Text("Aqui vai ser guardado os rascunhos?")
                    .font(.title)
                Spacer()
            }
            .padding()
        }
    }
}

