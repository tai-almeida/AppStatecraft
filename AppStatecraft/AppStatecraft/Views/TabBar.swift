import SwiftUI
import CoreData

struct TabBar: View {
    @Environment(\.managedObjectContext) private var contexto
    
    var body: some View {
        TabView {
            MetodologiasView()
                .tabItem {
                    Label("Metodologias", systemImage: "book")
                }
            Registros(contexto: contexto)
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



