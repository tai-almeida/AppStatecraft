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
            VStack(){
                Picker("", selection: $projetosConcluidos) {
                    Text("Em andamento").tag("Em andamento")
                    Text("Concluido").tag("Concluido")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                if projetosConcluidos == "Em andamento" {
                    VStack(alignment: .center) {
                        ScrollView {

                            LazyVGrid(columns: colunaCard, spacing: 20) {
                                ForEach(projetos.filter { projeto in
                                    !projeto.finalizado &&
                                    (pesquisarProjeto.isEmpty || projeto.nome?.localizedCaseInsensitiveContains(pesquisarProjeto) == true)
                                }) { projeto in
                                    projetoCardView(projeto: projeto)
                                }
                            }
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
            }
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
