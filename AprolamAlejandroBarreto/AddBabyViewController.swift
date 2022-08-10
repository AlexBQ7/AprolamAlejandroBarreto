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
    @IBOutlet weak var dateButton: UIButton!
    
    private let presenter = BabyPresenter()
    private var baby_data: BabyEntity? = nil
    
    private var baby_gender: Gender?
    private var baby_birthday: Date?
    private var baby_image: UIImage?
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(delegate: self)
        nameField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImageOptions(sender:)))
        babyImage.addGestureRecognizer(tapGesture)
        babyImage.isUserInteractionEnabled = true
        presenter.getBaby()
    }
    
    @objc func showImageOptions(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Imagen del bebé", message: "Elige una imagen para el bebé", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { (handler) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Carrete", style: .default, handler: { (handler) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func willSelectDate() {
        let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.maximumDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        let loc = Locale(identifier: "es")
        pickerView.locale = loc
        dateComponents.year = -3
        pickerView.minimumDate = calendar.date(byAdding: dateComponents, to: Date())
        pickerView.datePickerMode = .date
        pickerView.preferredDatePickerStyle = .wheels
        let action = UIAlertAction(title: "Seleccionar", style: .default, handler: {
            (UIAlertAction) in
            self.baby_birthday = pickerView.date
            self.dateField.text = pickerView.date.getFormattedDate(format: "dd/MM/yyyy")
        })
        createActionSheet(pickerView: pickerView, action: action)
    }
    
    private func createActionSheet(pickerView: UIDatePicker, action: UIAlertAction) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Fecha de nacimiento", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = dateButton
        alert.popoverPresentationController?.sourceRect = dateButton.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearName(_ sender: Any) {
        nameField.text = ""
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
        willSelectDate()
    }
    
    @IBAction func clearAll(_ sender: Any) {
        self.presenter.deleteBaby()
        do {
            let data = try self.presenter.context.fetch(BabyEntity.fetchRequest())
            print(data)
        } catch {
            
        }
    }
    
    @IBAction func saveBaby(_ sender: Any) {
        guard let image = baby_image else {
            Alert.missingImage(on: self)
            return
        }
        guard let name = nameField.text, !name.isEmpty else {
            Alert.missingName(on: self)
            return
        }
        
        guard let baby_birthday = baby_birthday else {
            Alert.missingBirthday(on: self)
            return
        }
        guard let baby_gender = baby_gender else {
            Alert.missingGender(on: self)
            return
        }
        
        let baby = BabyItem(name: name, birthday: baby_birthday, image: image, baby_gender: baby_gender)
        print("Test \(baby_data)")
        
        if let data = baby_data {
            if presenter.updateBaby(baby: data, newData: baby) {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                Alert.showAlert(on: self, with: "Error", message: "Hubo un error al intentar actualizar los datos.")
            }
        } else {
            if presenter.createBaby(baby: baby) {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                Alert.showAlert(on: self, with: "Error", message: "Hubo un error al intentar guardar los datos.")
            }
        }
        
    }
    
}

extension AddBabyViewController: BabyPresenterDelegate {
    func didGetBaby(baby: BabyEntity?) {
        guard let baby = baby else {
            print("No hay bebé")
            return
        }
        babyImage.image = baby.image
        nameField.text = baby.name
        dateField.text = baby.birthday.getFormattedDate(format: "dd/MM/yyyy")
        if baby.gender {
            boyButton.backgroundColor = UIColor(named: "secondary_color")
        } else {
            girlButton.backgroundColor = UIColor(named: "secondary_color")
        }
        baby_image = baby.image
        baby_birthday = baby.birthday
        baby_gender = baby.gender == true ? .boy : .girl
        baby_data = baby
        print("Hola: \(baby_data!)")
    }
    
    func presentAlert(title: String, message: String) {
        
    }
    
    
}

extension AddBabyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        if numberOfChars > 0 {
            clearText.isHidden = false
        } else {
            clearText.isHidden = true
        }
        return numberOfChars <= 30
    }
}

extension AddBabyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        babyImage.image = image
        baby_image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
