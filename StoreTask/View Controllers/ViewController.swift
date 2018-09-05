//
//  ViewController.swift
//  StoreTask
//
//  Created by Mac on 30/06/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Global Variables
    var sections = [Category]()
    var selectedItem = String()
    var selectedImageStr = String()
    
    // MARK: - Outlets
    @IBOutlet weak var productsTblView: UITableView!
    
    // MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.productsTblView.separatorStyle = .none
        self.navigationItem.title = "Available Products"
        loadData()
    }
    
    // MARK: - Structure For Home Screen Data Using Category Object
    func loadData(){
        let womenApparel = ["Jeans","Designer Dress"]
        let menApparel = ["Men Jeans"]
        let electronics = ["Television","Sound System"]
        let homeAppliance = ["Juicer & Mixers"]
        
        self.sections = [Category(name:"Women Apparel", items:womenApparel, images: ["GirlsJeans","DesignerDresses"]),
                         Category(name:"Men Apparel", items:menApparel, images: ["MenJeans"]),
                         Category(name:"Electronics", items:electronics, images: ["Television","SoundSystem"]),
                         Category(name:"Home Appliance", items:homeAppliance, images: ["Juicer"])]
        self.productsTblView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "DetailVC") {
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.productTitle = selectedItem
            detailVC.productImageStr = selectedImageStr
        }
    }
}

// MARK: - Tableview Datasource methods
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = self.sections[section].items
        return items.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].name
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "StoreCell")
        let items = self.sections[indexPath.section].items
        let item = items[indexPath.row]
        //        print(item)
        cell.textLabel?.text = item
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let items = self.sections[indexPath.section].items
        let item = items[indexPath.row]
        selectedItem = item
        let availableImages = self.sections[indexPath.section]
        let selectedImage = availableImages.images[indexPath.row]
        selectedImageStr = selectedImage
        self.performSegue(withIdentifier: "DetailVC", sender: self)
    }
    
}
