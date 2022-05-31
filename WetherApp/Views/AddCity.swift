import UIKit

extension UIViewController {

    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { _ in
            let textField = alertController.textFields?.first
            guard let text = textField?.text else { return }
            completionHandler(text)
        }

        alertController.addTextField() { textField in
            textField.placeholder = placeholder
        }

        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in }

        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)

        present(alertController, animated: true)
    }

}
