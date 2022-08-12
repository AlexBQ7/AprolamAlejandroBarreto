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
    
    public func createNews(article: News) {
        let news = NewsL(context: context)
        news.title = article.title
        news.descriptionN = article.description
        news.image = article.image
        news.url = article.url
        news.published_at = article.publishedAt
        news.source = "\(article.source.name) \(article.source.url)"
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    public func deleteNews(news: NewsL) {
        context.delete(news)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    public func updateNews() {
        do {
            let news = try context.fetch(NewsL.fetchRequest())
            for item in news {
                deleteNews(news: item)
            }
            APIProvider.shared.getNews {
                response in
                for item in response {
                    self.createNews(article: item)
                }
                self.getNews()
            } failure: { error in
                print(error ?? "Error obteniendo noticias")
            }
        } catch {
            print("Error")
        }
    }
    
}
