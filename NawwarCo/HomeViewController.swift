//
//  HomeViewController.swift
//  
//
//  Created by ardMac on 13/06/2017.
//
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ItemsTableViewCell.cellNib, forCellReuseIdentifier: ItemsTableViewCell.cellIdentifier)
        }
    }
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateItems()
        // Do any additional setup after loading the view.
    }
    
    func populateItems(){
        Database.database().reference().child("items").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            guard let items = snapshot.value as? NSDictionary else {return}
            self.addToItems(id: snapshot.key, itemInfo: items)
            self.tableView.reloadData()
        })
    }
    
    func addToItems(id: String, itemInfo: NSDictionary){
        if let itemName = itemInfo["name"] as? String,
            let itemColor = itemInfo["color"] as? String,
            let itemQuantity = itemInfo["quantity"] as? Int,
            let itemPhotoUrl = itemInfo["itemPhotoUrl"] as? String {
                let newItem = Item(withName: itemName, withPhoto: itemPhotoUrl, withColor: itemColor, withQuantity: itemQuantity)
                self.items.append(newItem)
        }
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 382
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.cellIdentifier) as? ItemsTableViewCell
            else { return UITableViewCell()}
        
        cell.itemNameLabel.text = items[indexPath.row].name
        cell.itemColorLabel.text = items[indexPath.row].color
        cell.itemQuantityLabel.text = String(items[indexPath.row].quantity)
        cell.itemImageView.loadImageUsingCacheWithUrlString(urlString: items[indexPath.row].photoURL!)
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

