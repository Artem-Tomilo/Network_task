//
//  ViewController.swift
//  Test_task
//
//  Created by Артем Томило on 27.10.22.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    static let cellIdentifier = "cell"
    static let cellLoadingId = "cellLoadingId"
    
    private var usersArray = [User]()
    private var links = [String]()
    
    private var isLoading = false
    
    private var loadingView: LoadingReusableView?
    
    private var usersCounter = 0
    private let loadStep = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()
    }
    
    private func setup() {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        collectionView.register(CollectionViewCustomCell.self, forCellWithReuseIdentifier: ViewController.cellIdentifier)
        collectionView.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ViewController.cellLoadingId)
    }
    
    private func getData() {
        isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            NetworkService.shared.loadData(from: self.usersCounter, to: self.usersCounter + self.loadStep) { [weak self] users in
                guard let self = self else { return }
                self.usersArray = users
                self.getLinks()
                self.isLoading = false
                self.collectionView.reloadData()
            }
        }
    }
    
    private func loadMore() {
        usersCounter = usersCounter + loadStep
        getData()
    }
    
    private func getLinks() {
        var photos = [Photo]()
        for i in usersArray {
            photos.append(i.photos.first!)
        }
        for i in photos {
            links.append(i.url)
        }
    }
}

// MARK: - CollectionView

extension ViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.cellIdentifier, for: indexPath) as? CollectionViewCustomCell else { return UICollectionViewCell() }
        
        let url = URL(string: links[indexPath.row].replacingOccurrences(of: "@", with: "500"))
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    cell.bind(data: data)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCustomCell
        cell?.showImage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        
        if offsetY > (contentHeight - scrollView.frame.size.height) {
            if !isLoading {
                self.loadMore()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ViewController.cellLoadingId, for: indexPath) as! LoadingReusableView
            loadingView = footerView
            loadingView?.backgroundColor = UIColor.clear
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
//            if elementKind == UICollectionView.elementKindSectionFooter {
//                if self.isLoading {
//                    self.loadingView?.activityIndicator.startAnimating()
//                } else {
//                    self.loadingView?.activityIndicator.stopAnimating()
//                }
//            }
//        }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}
