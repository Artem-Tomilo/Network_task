//
//  aaa.swift
//  Test_task
//
//  Created by Артем Томило on 31.10.22.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var aTableView: UITableView!
    
    var privateList = [String]()
    //let totalItems = 100 // server does not provide totalItems
    var fromIndex = 0
    let batchSize = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        privateList.removeAll()
        loadMoreItems()
    }

    func loadMoreItems() {
        
        //let endIndex = min(totalItems, fromIndex + batchSize)
        
//        for i in fromIndex ..< endIndex {
//            privateList.append(String(i))
//        }
        
        //print("Loading items form \(fromIndex) to \(endIndex - 1)")
        
        //fromIndex = endIndex
        //aTableView.reloadData()
        
        loadItemsNow(listType: "privateList")
    }
    
    func loadItemsNow(listType:String){
        //myActivityIndicator.startAnimating()
        
        let listUrlString = "http://infavori.com/json2.php?batchSize=" + String(fromIndex + batchSize) + "&fromIndex=" + String(fromIndex) + "&listType=" + listType
        let myUrl = URL(string: listUrlString);
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                
                if let parseJSON = json {
                    //self.privateList = parseJSON as! [String]
                    var items = self.privateList
                    items.append(contentsOf: parseJSON as! [String])
                    if self.fromIndex < items.count {
                        
                        self.privateList = items
                        self.fromIndex = items.count
                        
                        DispatchQueue.main.async {
                            self.aTableView.reloadData()
                        }
                    }
                }
                
            } catch {
                print(error)
                
            }
        }
        
        task.resume()
    }
}

extension FirstViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = privateList[indexPath.row]
        
        if indexPath.row == privateList.count - 1 { // last cell
            //if totalItems > privateList.count { //removing totalItems for always service call
                loadMoreItems()
            //}
        }
        
        return cell
    }
}
