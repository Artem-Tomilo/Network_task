//
//  Test.swift
//  Test_task
//
//  Created by Артем Томило on 1.11.22.
//

//import UIKit
//
//class ViewController: UIViewController {
//    
//    @IBOutlet var collectionView: UICollectionView!
//    static let cellIdentifier = "cell"
//    
//    private var more = false
//    
//    let api = ApiCaller()
//    var data = [Int]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        api.fetchData { users in
//            self.data.append(contentsOf: users)
//            self.collectionView.reloadData()
//        }
//    }
//    
//    private func setup() {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(100))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        collectionView.collectionViewLayout = layout
//        
//        collectionView.register(Cell.self, forCellWithReuseIdentifier: ViewController.cellIdentifier)
//    }
//}
//
//// MARK: - CollectionView
//
//extension ViewController: UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//}
//
//extension ViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.cellIdentifier, for: indexPath) as? Cell
//        cell?.label.text = String(data[indexPath.item])
//        return cell!
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = collectionView.contentSize.height
//        
//        if offsetY > (contentHeight - scrollView.frame.size.height) {
//            if !more {
//                print(123)
//                qwe()
//            }
//        }
//    }
//    
//    func qwe() {
//        more = true
//        api.fetchData { users in
//            self.data.append(contentsOf: users)
//            self.collectionView.reloadData()
//            self.more = false
//        }
//    }
//}
//
//class ApiCaller {
//    func fetchData(_ completion: @escaping ([Int]) -> Void) {
//        var data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//            let newData = (data.count...data.count + 10).map { index in index }
//            data.append(contentsOf: newData)
//            completion(data)
//        }
//    }
//}




//    private func createLayout() {
//        let spacing: CGFloat = 10
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.5),
//            heightDimension: .fractionalHeight(0.4))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
//        group.interItemSpacing = .fixed(spacing)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//        section.interGroupSpacing = spacing
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        collectionView.collectionViewLayout = layout
//
//    }


//    func visible() -> Int {
//        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
//        let row = (visibleIndexPath?.row) ?? 6
//        return row
//    }

//    private func loadData() {
//        showSpinner()
//        serverDelegate.getEmployees { employees in
//            if self.getMaxRecordsCountFromSettings() != 0 {
//                self.bind(Array(employees.prefix(self.getMaxRecordsCountFromSettings())))
//            } else {
//                self.bind(employees)
//            }
//            self.hideSpinner()
//        }
//    }
