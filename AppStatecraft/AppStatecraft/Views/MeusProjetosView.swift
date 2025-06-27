import SwiftUI



struct ProjetosView: View {
    @State private var minhaIdeiaModal = false
    var body: some View {
        VStack(spacing: 12) {
            Button {
                minhaIdeiaModal = true
            } label: {
                Image(systemName: "lightbulb.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.yellow)
                    .padding(30)
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(20)
                    .shadow(radius: 6)
                    .frame(width: 200, height: 200)
            }
            // Texto fora do botão/card
            Text("Minhas Ideias")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.top, .leading], 20)
        // Modal vazio
        .sheet(isPresented: $minhaIdeiaModal) {
            // Modal content — pode personalizar depois
            VStack {
                Text("Aqui vai ser guardado os rascunhos?")
                    .font(.title)
                Spacer()
            }
            .padding()
        }
    }
}
