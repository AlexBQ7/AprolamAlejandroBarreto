//
//  NewsViewController.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 11/08/22.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsCollection: UICollectionView!
    var news = [NewsL]()
    let presenter = NewsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsCollection.delegate = self
        newsCollection.dataSource = self
        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getNews()
    }

}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollection.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCollectionViewCell
        cell?.titleNews.text = news[indexPath.row].title
        cell?.descriptionNews.text = news[indexPath.row].description
        cell?.published_At.text = news[indexPath.row].published_at
        cell?.source.text = "Source: \(news[indexPath.row].source)"
        cell?.image.load(url: URL(string: news[indexPath.row].image!)!)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UIApplication.shared.canOpenURL(URL(string: news[indexPath.row].url!)!) {
            UIApplication.shared.open(URL(string: news[indexPath.row].url!)!, options: [:], completionHandler: nil)
        }
    }
}

extension NewsViewController: NewsPresenterDelegate {
    func showNews(news: [NewsL]) {
        self.news = news
        
        DispatchQueue.main.async {
            self.newsCollection.reloadData()
        }
    }
}
