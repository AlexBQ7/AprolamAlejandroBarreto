//
//  BabyPresenter.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import Foundation
import UIKit

protocol BabyPresenterDelegate: AnyObject {
    func didGetBaby(baby: BabyEntity)
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = BabyPresenterDelegate & UIViewController

class BabyPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: BabyPresenterDelegate?
    
    public func createBaby(baby: BabyItem) {
        let newBaby = BabyEntity(context: context)
        newBaby.name = baby.name
        newBaby.birthday = baby.birthday
        newBaby.gender = true
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    public func getBaby() {
        do {
            let baby = try context.fetch(BabyEntity.fetchRequest())
        } catch {
            
        }
    }
    
    public func updateBaby(baby: BabyEntity) {
        
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
}
