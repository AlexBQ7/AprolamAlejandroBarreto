//
//  ViewController.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func miBebeAction(_ sender: Any) {
        performSegue(withIdentifier: "addBaby", sender: self)
    }
    
    @IBAction func newsAction(_ sender: Any) {
        performSegue(withIdentifier: "newsSegue", sender: self)
    }
}

