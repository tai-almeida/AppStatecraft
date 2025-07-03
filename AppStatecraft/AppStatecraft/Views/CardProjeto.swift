import SwiftUI

struct CardMyProject: View {
    let systemImage: String
    let titulo: String
    let corDeFundo: Color
    let acao: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 60)
                .foregroundColor(.yellow)
                .padding(30)
            
            Text(titulo)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
        }
        .frame(width: 140, height: 160) // ajustei altura para acomodar texto
        .contentShape(Rectangle())
        .cornerRadius(40)
        .onTapGesture {
            acao()
        }
    }
}

