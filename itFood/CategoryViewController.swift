//
//  CategoryViewController.swift
//  itFood
//
//  Created by Student on 30/06/23.
//

import UIKit

protocol CategoryViewControllerDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let menuController = MenuController()
    var categories = [String]()
    
    weak var delegate: CategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Task.init {
            do{
                let categories = try await menuController.fetchCatergories()
                updateUI(with: categories)
        
            } catch {
                displayError (error, title: "Failed to Fetch Categories \(self.categories)")
            }
        }
        
        let nib = UINib (nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "categoryItem_cell")
    }
    

    func updateUI (with categories: [String]){
        self.categories = categories
        self.tableView.reloadData()
    }
    
    func displayError(_ error: Error, title: String) {
            guard let _ = viewIfLoaded?.window else { return }
            let alert = UIAlertController(title: title, message:
               error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
               style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
}

extension CategoryViewController: UITableViewDelegate{
}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryItem_cell", for: indexPath) as! CategoryTableViewCell
        let category = categories[indexPath.row]
        cell.setup(category: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        print("clicked here -> \(category)")
        delegate?.didSelectCategory(category)
        
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
        menuViewController.categoryMenu = category
        navigationController?.pushViewController(menuViewController, animated: true)
    }
}
