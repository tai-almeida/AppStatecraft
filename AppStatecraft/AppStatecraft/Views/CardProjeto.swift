import SwiftUI

struct CardMyProject: View {
    let systemImage: String
    let titulo: String
    let corDeFundo: Color
    let acao: () -> Void

    var body: some View {
        
        VStack{
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 60)
                .foregroundColor(.yellow)
                .padding(30)
                .cornerRadius(40)
            
            
        }
        .frame(width: 140, height: 140)
        .contentShape(Rectangle())
        .background(corDeFundo)
        .cornerRadius(40)
        .onTapGesture {
            acao()
        }
        Text("Meus projetos")
            .font(.subheadline)
            .foregroundColor(.primary)
            .padding(20)
        Spacer()
    }
     
}
