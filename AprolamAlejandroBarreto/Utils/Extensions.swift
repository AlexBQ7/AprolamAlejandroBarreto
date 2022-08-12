//
//  Extensions.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 11/08/22.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let image_data = try? Data(contentsOf: url) {
                if let loaded_image = UIImage(data: image_data) {
                    DispatchQueue.main.async {
                        self?.image = loaded_image
                    }
                }
            }
        }
    }
}
