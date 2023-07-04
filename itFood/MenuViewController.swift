//
//  MenuViewController.swift
//  itFood
//
//  Created by Student on 01/07/23.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryMenu: String = ""
    let menuController = MenuController()
    var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let category = String(categoryMenu)
        title = category.capitalized
        
        Task.init {
            do{
                let menuItems = try await menuController.fetchMenuItems(forCategory: categoryMenu)
                    updateUI(with: menuItems)
            }catch{
                displayError(error, title: "Failed to Fetch Menu Items for \(self.categoryMenu)")
            }
        }
    
        let nib = UINib (nibName: "MenuTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "menuItem")
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func updateUI(with menuItems: [MenuItem]) {
            self.menuItems = menuItems
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

extension MenuViewController: UITableViewDelegate{}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath) as! MenuTableViewCell
        let menu = menuItems[indexPath.row]
        cell.setup(menuItems: menu)
        return cell
    }
}
