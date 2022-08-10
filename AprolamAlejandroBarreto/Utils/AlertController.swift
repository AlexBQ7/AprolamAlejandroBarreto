//
//  AlertController.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import Foundation
import UIKit

struct Alert {
    static func showAlert(on vc: UIViewController, with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        vc.present(alertController, animated: true)
    }
    
    static func missingImage(on vc: UIViewController) {
        showAlert(on: vc, with: "Imagen", message: "Aún no has agregado una imagen de tu bebé.")
    }
    
    static func missingName(on vc: UIViewController) {
        showAlert(on: vc, with: "Nombre", message: "Aún no has agregado el numbre de tu bebé.")
    }
    
    static func missingBirthday(on vc: UIViewController) {
        showAlert(on: vc, with: "Fecha de nacimiento", message: "Aún no seleccionas la fecha de nacimiento de tu bebé.")
    }
    
    static func missingGender(on vc: UIViewController) {
        showAlert(on: vc, with: "¿Niño o niña?", message: "Aún no has seleccionado el sexo de tu bebé.")
    }
}
