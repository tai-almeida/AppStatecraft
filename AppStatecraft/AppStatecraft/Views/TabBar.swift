import SwiftUI


struct TabBar: View {
    @State private var pesquisarProjeto = ""
    var body: some View {
        
        TabView {
            MetodologiasView()
                .tabItem {
                    Label("Metodologias", systemImage: "book")
                }
            
            ProjetosView(pesquisarProjeto: $pesquisarProjeto)
                .tabItem {
                    Label("Projetos", systemImage: "folder")
            }
        }
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
