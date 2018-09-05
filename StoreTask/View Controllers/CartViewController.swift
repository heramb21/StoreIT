//
//  CartViewController.swift
//  StoreTask
//
//  Created by BDM3 on 7/1/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    // MARK: - Global Variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var products = [NSManagedObject]()
    var selectedItem = String()
    var selectedImageStr = String()
    
    // MARK: - Outlets
    @IBOutlet weak var prodListTblView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var noItemsLbl: UILabel!
    
    // MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.prodListTblView.separatorStyle = .none
    }
    
    // MARK: - Every Time View Loads Fetch Data From DB.
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    // MARK: - Function To Fetch Data From DB And Set Parameters.
    func loadData(){
        let context = appDelegate.persistentContainer.viewContext
        
        // MARK: - Used Helper Class For Fetching Data CoreDataManager()
        products = CoreDataManager().fetchRecordsForEntity("Product", inManagedObjectContext: context)
        //            print("Products:\(products)")
        if products.count > 0 {
            self.prodListTblView.isHidden = false
            self.noItemsLbl.isHidden = true
            self.totalPriceLbl.text = "Total:" + "₹" + "\(products.count * 120)"
            self.prodListTblView.reloadData()
        }
        else{
            self.totalPriceLbl.text = ""
            self.prodListTblView.isHidden = true
            self.noItemsLbl.isHidden = false
        }
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
        if (segue.identifier == "CartDetailVC") {
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.productTitle = selectedItem
            detailVC.productImageStr = selectedImageStr
        }
    }
    
}

// MARK: - Tableview Datasource methods
extension CartViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Cell With Required Details As Product Name, Price And Image.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "ProductCell")
        cell.textLabel?.text = self.products[indexPath.row].value(forKey: "name") as? String
        cell.detailTextLabel?.text = self.products[indexPath.row].value(forKey: "price") as? String
        cell.imageView?.image = UIImage(named:self.products[indexPath.row].value(forKey: "image") as! String)
        return cell
    }
    
    // MARK: - Delete From Cart Functionality.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if  (editingStyle == UITableViewCellEditingStyle.delete) {
            let context = appDelegate.persistentContainer.viewContext
            
            // MARK: - Delete object with Unique Value objectID
            let selectedObject = context.object(with: self.products[indexPath.row].objectID)
            context.delete(selectedObject)
            
            // MARK: - Save After Deleting & Update Data In TableView.
            do{
                try context.save()
                self.products.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            catch{
                // MARK: - Global Alert If Save Fails.
                Utils().SubmitAlertView(viewController: self, title: Constant.DefaultTitle, message: "Error In Deleting Product.")
            }
        }
        
        // MARK: - Delete Operation Is Done.Reload Data On View.
        loadData()
    }
    
    // MARK: - Detail Screen Redirection.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedImageStr = self.products[indexPath.row].value(forKey: "image") as! String
        selectedItem = self.products[indexPath.row].value(forKey: "name") as! String
        performSegue(withIdentifier: "CartDetailVC", sender: self)
    }
}
