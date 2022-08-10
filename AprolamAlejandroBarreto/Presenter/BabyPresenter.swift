//
//  BabyPresenter.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import Foundation
import UIKit

protocol BabyPresenterDelegate: AnyObject {
    func didGetBaby(baby: BabyEntity?)
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = BabyPresenterDelegate & UIViewController

class BabyPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: BabyPresenterDelegate?
    
    public func createBaby(baby: BabyItem) -> Bool {
        let newBaby = BabyEntity(context: context)
        newBaby.name = baby.name
        newBaby.birthday = baby.birthday
        newBaby.image = baby.image
        newBaby.gender = baby.baby_gender == .boy ? true : false
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    public func getBaby() {
        do {
            let baby = try context.fetch(BabyEntity.fetchRequest())
            self.delegate?.didGetBaby(baby: baby.first)
        } catch {
            
        }
    }
    
    public func updateBaby(baby: BabyEntity, newData: BabyItem) -> Bool {
        baby.name = baby.name
        baby.birthday = baby.birthday
        baby.image = baby.image
        baby.gender = true
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    public func deleteBaby() {
        do {
            let baby = try context.fetch(BabyEntity.fetchRequest())
            context.delete(baby.first!)
        } catch {
            
        }
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
}
