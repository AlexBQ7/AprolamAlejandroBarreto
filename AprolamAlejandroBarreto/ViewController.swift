//
//  ViewController.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro on 09/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func miBebeAction(_ sender: Any) {
        performSegue(withIdentifier: "addBaby", sender: self)
    }
    
}

