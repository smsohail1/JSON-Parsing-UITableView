//
//  ViewController.swift
//  Json parsing UITableview
//
//  Created by Abdul Ahad on 8/2/17.
//  Copyright © 2017 G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var names: [String] = []
    var contacts: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url=URL(string:"https://api.androidhive.info/contacts/")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["contacts"]{
                
                print("\(arrJSON)")
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index] as! [String : AnyObject]
                    
                    names.append(aObject["name"] as! String)
                    contacts.append(aObject["gender"] as! String)
                }
            }
            print(names)
            print(contacts)
            
            self.tableView.reloadData()
        }
        catch {
            
        }
        
    
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.names.count;
    }
    func tableView(_ tableView: UITableView!, didSelectRowAtIndexPath indexPath: IndexPath!) {
        print("You selected name : "+names[indexPath.row])
        print("gender : "+contacts[indexPath.row])
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
       // let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell?.textLabel?.text=self.names[indexPath.row]
       cell?.detailTextLabel?.text = self.contacts[indexPath.row]
        return cell!
    }
    

}

