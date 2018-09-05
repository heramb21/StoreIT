//
//  DetailViewController.swift
//  StoreTask
//
//  Created by Heramb on 30/06/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    // MARK: - Global Variables
    var productTitle = String()
    var managedObjectContext: NSManagedObjectContext? = nil
    var productImageStr = String()
    
    // MARK: - Outlets
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    // MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameLbl.text = productTitle
        self.priceLbl.text = "₹ 120"
        self.detailImgView.image = UIImage(named: productImageStr)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Function To Add Selected Product In Core Data Database.
    @IBAction func btnAddTOCartPressed(_ sender: Any) {
        
        // MARK: - Add Data To Core Data Database.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let newProduct = NSManagedObject(entity: entity!, insertInto: context)
        newProduct.setValue(self.nameLbl.text, forKey: "name")
        newProduct.setValue(self.priceLbl.text, forKey: "price")
        newProduct.setValue(1, forKey: "quantity")
        newProduct.setValue(productImageStr, forKey: "image")
        do {
            try context.save()
            
            // MARK: - Custam Alert For Easy Redirection To Cart.
            let alertController = UIAlertController(title: Constant.DefaultTitle, message: "Item Added To Cart Successfully.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "CHECK CART", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.performSegue(withIdentifier: "CartVC", sender: self)
            }
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // MARK: - Present the alert controller
            self.present(alertController, animated: true, completion: nil)
        } catch {
            print("Failed saving data")
            
            // MARK: - Global Alert If Something Goes Wrong.
            Utils().SubmitAlertView(viewController: self, title: Constant.DefaultTitle, message: "Failed To Add Item.Please Try Again Later.")
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
