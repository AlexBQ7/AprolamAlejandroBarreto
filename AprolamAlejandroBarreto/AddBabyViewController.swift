//
//  AddBabyViewController.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import UIKit

class AddBabyViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var clearText: UIButton!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var girlButton: UIButton!
    @IBOutlet weak var boyButton: UIButton!
    
    enum Gender {
        case boy
        case girl
    }
    private var baby_gender: Gender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didSelectGirl(_ sender: Any) {
        baby_gender = Gender.girl
        boyButton.backgroundColor = .white
        girlButton.backgroundColor = UIColor(named: "secondary_color")
        
    }
    
    @IBAction func didSelectBoy(_ sender: Any) {
        baby_gender = Gender.boy
        girlButton.backgroundColor = .white
        boyButton.backgroundColor = UIColor(named: "secondary_color")
    }
    
    @IBAction func selectDate(_ sender: Any) {
        
    }
    
    @IBAction func clearAll(_ sender: Any) {
        
    }
    
    @IBAction func saveBaby(_ sender: Any) {
        
    }
    
}

extension AddBabyViewController: UITextFieldDelegate {
    
}

extension AddBabyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        babyImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
