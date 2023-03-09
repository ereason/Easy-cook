//
//  SearchFoodViewController.swift
//  Easy-cook
//
//  Created by Дербе Эмма on 04.03.2023.
//

import UIKit

class SearchFoodViewController: UIViewController {
    var manager = RequestListRecipesManager()   //у каждого контроллера должен быть свой менеджер
    var reciepts: [ResultModel] = []
    var loadNum = 20
    var offset = 0
    private var searchingStarted = false    //флаг того, что поиск запущен (при пустом поле поиска и при запуске не нужно ничего отображать)
    
    private var recipeCategoryCollectionView = RecipeCategoryCollectionView()
    private var categoryCollectionView = CategoryCollectionView()

    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        search.addTarg
        //search.addAction(searchBarTextDidEndEditing(self))
        return search
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular category"
        label.font = .poppinsBold40()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textAccent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        manager.delegate = self //назначаем себя (класс SearchFoodViewController) делегатом для своего менеджера (класса RequestListRecipesManager)
    }
}
extension SearchFoodViewController: RequestListRecipeDelegate {
    func didUpdateRecipeList(_ requestListRecipeManager: RequestListRecipesManager, recipeList: RecipeListModel) {
//            print("В строке поиска введено \(textQuery)")
            if self.searchingStarted {
                DispatchQueue.main.async {
                    var recieptListModel: [RecieptListModel] = []
                    recipeList.results.forEach({
                        recieptListModel.append(RecieptListModel(image: UIImage(named: $0.image)!, title: $0.title))
                        //self.reciepts.append($0)
                    })
                    self.recipeCategoryCollectionView.set(cells: recieptListModel)
//                                                            manager. RecieptListModel.fetchData())
                        
                        //после cells: ожидается массив такого типа:         let reciept1 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")

                    self.categoryCollectionView.set(cells: recieptListModel)//RecieptListModel.fetchData())
                }
                //self.tableView.reloadData()
            
        }
        //isEnabled = true
        print( self.reciepts.count)    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
extension SearchFoodViewController {
    func setupView() {
        view.backgroundColor = .backgroundColor
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(recipeCategoryCollectionView)
        view.addSubview(categoryCollectionView)
        
        //блок кода, отвечающий за загрузку данных для контроллера
        if searchingStarted {
            recipeCategoryCollectionView.set(cells: RecieptListModel.fetchData())
            categoryCollectionView.set(cells: RecieptListModel.fetchData())
        }
    }
}

//MARK: - Delegate()
extension SearchFoodViewController: UISearchBarDelegate {
    @IBAction func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let textQuery = searchBar.text {
            self.manager.fetchRecipe(query: .search(query: textQuery, number: self.loadNum, offset: self.offset))
            print("ввод текст в поле поиска завершен, запрос в интернет отправлен")
        }
    }
}

// MARK: - setupConstraints()
extension SearchFoodViewController {
    func setupConstraints() {

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        ])

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
        ])

        NSLayoutConstraint.activate([
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 19),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 68)
        ])

        NSLayoutConstraint.activate([
            recipeCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeCategoryCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 19),
            recipeCategoryCollectionView.heightAnchor.constraint(equalToConstant: 458)
        ])
    }
}
