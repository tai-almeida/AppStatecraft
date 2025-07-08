import SwiftUI
import CoreData

struct ProjetosView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Projeto.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Projeto.data, ascending: false)]
    ) private var projetos: FetchedResults<Projeto>
    @StateObject private var projetosVM = ProjetosViewModel()
    @State private var minhaIdeiaModal = false
    @State private var adicionarProjeto = false
    @State private var projetosConcluidos = "Em andamento"
    @State private var addProjetoVazio = false
    @State var nomeProjeto = ""
    @State private var textoDaBusca = "" // estado local para a busca
    
    
    let colunaCard = [GridItem(.flexible()), GridItem(.flexible())]
    
    private var projetosFiltrados: [Projeto] {
        let projetosPorStatus: [Projeto]
        
        if projetosConcluidos == "Em andamento" {
            projetosPorStatus = projetos.filter { !$0.finalizado }
        } else {
            projetosPorStatus = projetos.filter { $0.finalizado }
        }
        
        //busca vazia, não precisa filtrar mais nada
        if textoDaBusca.isEmpty {
            return projetosPorStatus
        }
        
        //resultado anterior pelo texto da busca
        return projetosPorStatus.filter { projeto in
            projeto.nome?.localizedCaseInsensitiveContains(textoDaBusca) ?? false
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(){
                //TODO: Colocar o icone de editar externo (nao so o longpress para deletar/concluido)
//                Picker("", selection: $projetosConcluidos) {
//                    Text("Em andamento").tag("Em andamento")
//                    Text("Concluido").tag("Concluido")
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
                
                VStack(alignment: .center){
                    ScrollView{
                        if projetosFiltrados.isEmpty{
                            TelaVaziaProjeto() //tentei deixar isso no meio da tela mas nao esta indo -sofi
                        }
                        
                        LazyVGrid(columns: colunaCard, spacing: 20) {
                            ForEach(projetosFiltrados, id: \.self) { projeto in
                                NavigationLink(destination: DetalhesProjetoView(projeto: projeto)) {
                                    projetoCardView(projeto: projeto)
                                }.contextMenu { // .contextMenu para o long press
                                    Button(action: {
                                        projetosVM.toggleConcluidoProjeto(viewContext: viewContext, projeto: projeto)
                                    }) {
                                        Label(projeto.finalizado ? "Marcar como Em Andamento" : "Marcar como Concluído",
                                              systemImage: projeto.finalizado ? "arrow.uturn.backward.circle" : "checkmark.circle")
                                    }
                                    
                                    Button(role: .destructive, action: {
                                        projetosVM.deletarProjeto(viewContext: viewContext, projeto: projeto)
                                    }) {
                                        Label("Deletar", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
                .navigationTitle("Projetos")
                .searchable(text: $textoDaBusca, placement: .navigationBarDrawer(displayMode: .always)) //para a busca ficar fixa la em cima
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            addProjetoVazio = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $addProjetoVazio) {
                            AddProjetoVazioView(nomeProjeto: $nomeProjeto)
                        }
                    }
                }
            }
        }
    }
}
