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
    var timer = Timer()
    let presenter = NewsPresenter()
    private let widthScreen = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsCollection.delegate = self
        newsCollection.dataSource = self
        newsCollection.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newsCell")
        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getNews()
        updateNews()
    }
    
    func timerNews() {
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateNews), userInfo: nil, repeats: true)
    }
    
    @objc func updateNews() {
        presenter.updateNews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }

}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollection.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCollectionViewCell
        cell?.titleNews.text = news[indexPath.row].title
        cell?.descriptionNews.text = news[indexPath.row].descriptionN
        cell?.published_At.text = "\(news[indexPath.row].published_at?.prefix(10) ?? "")"
        cell?.source.text = "Source: \(news[indexPath.row].source ?? "Anónimo")"
        if let image = news[indexPath.row].image {
            cell?.image.load(url: URL(string: image)!)
        } else {
            cell?.image.image = UIImage(named: "news")
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UIApplication.shared.canOpenURL(URL(string: news[indexPath.row].url!)!) {
            UIApplication.shared.open(URL(string: news[indexPath.row].url!)!, options: [:], completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthScreen - 60, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
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
