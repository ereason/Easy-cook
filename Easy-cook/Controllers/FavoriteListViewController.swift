import UIKit

class FavoriteListViewController: BaseFeedViewController{
    
    var manager = RequestFavoriteManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        manager.delegate = self
        // updating data for table view
        manager.fetchRecipe()
        configureTableView()
        // Register the custom header view.
        tableView.register(TableViewTopCustomHeader.self, forHeaderFooterViewReuseIdentifier: StringConstants.sectiontHeaderIndent)
    }

    // Override 2 methods to dismiss empty space in a top of Table view (this space auto creates for navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reciepts.removeAll()
        self.tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = true
        manager.fetchRecipe()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     
        self.navigationController?.navigationBar.isHidden = false
       
    }
}

// MARK: - Extension (RequestListRecipeDelegate)
extension FavoriteListViewController: RequestFavoriteManagerDelegate{

    func didUpdateRecipe(_ requestManager: RequestFavoriteManager, recipe: [RecipeModel]) {
        DispatchQueue.main.async {
            
            recipe.forEach({
                self.reciepts.append($0)
            })
            self.tableView.reloadData()
        }
        
 
        print( self.reciepts.count)
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
