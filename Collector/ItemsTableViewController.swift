//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Steven Lerner on 2/28/18.
//  Copyright © 2018 Steven Lerner. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems_Func()
    }
    
    func getItems_Func() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataStuff = try?context.fetch(Item.fetchRequest()) as? [Item] {
                if let coreDataItems = coreDataStuff {
                    items = coreDataItems
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        if let imageData = item.image {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let item = items[indexPath.row]
                
                context.delete(item)
                getItems_Func()
            }
        }
    }
    
    
    
}
