import SwiftUI
import UIKit

struct TextFieldUIKit: UIViewRepresentable {
    @Binding var texto: String
    var onEnter: (String) -> Void

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.returnKeyType = .done
        textField.delegate = context.coordinator
        textField.textAlignment = .center
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = texto
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(texto: $texto, onEnter: onEnter)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var texto: String
        var onEnter: (String) -> Void

        init(texto: Binding<String>, onEnter: @escaping (String) -> Void) {
            self._texto = texto
            self.onEnter = onEnter
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let conteudo = textField.text {
                onEnter(conteudo)
                textField.text = ""
                texto = ""
            }
            textField.resignFirstResponder()
            return true
        }
    }
}
