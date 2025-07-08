import SwiftUI


struct TabBar: View {
    var body: some View {
        
        TabView {
            MetodologiasView()
                .tabItem {
                    Label("Metodologias", systemImage: "book")
                }
            
            ProjetosView()
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
