import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            MetodologiasView()
                .tabItem {
                    Label("Metodologias", systemImage: "book")
                }
            Registros()
                .tabItem {
                    Label("Registros", systemImage: "note.text")
                }
            ProjetosView()
                .tabItem {
                    Label("Projetos", systemImage: "folder")
                }
        }
    }
}
//struct TabBar_Previews: PreviewProvider {
//  static var previews: some View {
//    TabBar()
//  }
//}



