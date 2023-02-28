import UIKit

class ReciptsListVC: UIViewController {
    
    var tableView = UITableView()
    var reciepts: [RecieptListModel] = []
    
    struct Cells {
        static let recieptCell = "TableViewPrototypeCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // updating data for table view
        reciepts = fetchData()
        configureTableView()
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
        return cell
    }
    // this method will run when the user click at row (so we will open segue)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


// MARK: - Generating Example Data for preview. After we should change it to be from Network Call.
extension ReciptsListVC {
    func fetchData() -> [RecieptListModel] {
        let reciept1 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept2 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept3 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept4 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept5 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept6 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept7 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept8 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept9 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept10 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        
        return [reciept1, reciept2, reciept3, reciept4, reciept5, reciept6, reciept7, reciept8, reciept9, reciept10]
    }
}
