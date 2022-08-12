//
//  NewsPresenter.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 11/08/22.
//

import Foundation
import UIKit

protocol NewsPresenterDelegate: AnyObject {
    func showNews(news: [NewsL])
}

typealias NewsDelegate = NewsPresenterDelegate & UIViewController

class NewsPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: NewsPresenterDelegate?
    
    public func setViewDelegate(delegate: NewsDelegate) {
        self.delegate = delegate
    }
    
    public func getNews() {
        do {
            let news = try context.fetch(NewsL.fetchRequest())
            self.delegate?.showNews(news: news)
        } catch {
            print(error)
        }
    }
    
}
