import UIKit

class ReciptsListVC: UIViewController{
    var manager = RequestListRecipesManager()
    var tableView = UITableView()
    var reciepts: [ResultModel] = []
    var loadNum = 20
    var offset = 0
    var isEnabled = true
    
    struct Cells {
        static let recieptCell = "TableViewPrototypeCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        manager.delegate = self
        // updating data for table view
        manager.fetchRecipe(query: .list(number: loadNum, offset: offset))
        configureTableView()
        // Register the custom header view.
        tableView.register(TableViewTopCustomHeader.self, forHeaderFooterViewReuseIdentifier: K.sectiontHeaderIndent)
    }
    
    // Override 2 methods to dismiss empty space in a top of Table view (this space auto creates for navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    // init custom tableView header
     func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.sectiontHeaderIndent) as! TableViewTopCustomHeader
       view.title.text = "Popular recipes"
       return view
    }
    
    // Change size of MainTableViewTitle View box.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           if section == 0 {
               return CGFloat(45)
           }
           return tableView.sectionHeaderHeight
       }
    
    func configureTableView() {
        view.addSubview(tableView)
        //set delegates
        setTableViewDelegates()
        //set row heigt
        tableView.rowHeight = 240
        //register cells
        tableView.register(TableViewPrototypeCell.self, forCellReuseIdentifier: Cells.recieptCell)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}


// MARK: - Extension (Delegate and DataSource)
extension ReciptsListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // Here we setup how many rows do we wants to set up in table view ( Its should be equal to API Request of reciepts.count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reciepts.count
    }
    
    // Shows which kind of default cell prototype do we set up
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.recieptCell) as! TableViewPrototypeCell
        let recieptsList = reciepts[indexPath.row]
        cell.set(recieptList: recieptsList)
        
        cell.recieptLikeButton.setID(id: reciepts[indexPath.row].id)
        cell.recieptLikeButton.updateApperance()
        return cell
    }
    // this method will run when the user click at row (so we will open segue)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(reciepts[indexPath.row].id)
        present(RecipeViewController(reciepts[indexPath.row].id), animated: true, completion: nil)
    }
    //Updating amount of shoings cells it TableView
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reciepts.count - 3 {
           
            if isEnabled{
                isEnabled = false
                offset += loadNum
                DispatchQueue.main.async {
                    print("   rffrfrf   \(self.offset)")
                    self.manager.fetchRecipe(query: .list(number: self.loadNum, offset: self.offset))
                    tableView.reloadData()
                }
                
            }
        }
    }
}


// MARK: - Extension (RequestListRecipeDelegate)
extension ReciptsListVC: RequestListRecipeDelegate{
    
    func didUpdateRecipeList(_ requestListRecipeManager: RequestListRecipesManager, recipeList: RecipeListModel) {
        
        DispatchQueue.main.async {
            
            recipeList.results.forEach({
                self.reciepts.append($0)
            })
            self.tableView.reloadData()
        }
        
        isEnabled = true
        print( self.reciepts.count)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
