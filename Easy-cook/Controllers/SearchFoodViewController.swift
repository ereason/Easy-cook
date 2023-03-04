//
//  SearchFoodViewController.swift
//  Easy-cook
//
//  Created by Дербе Эмма on 04.03.2023.
//

import UIKit

class SearchFoodViewController: UIViewController {

    private var recipeCategoryCollectionView = RecipeCategoryCollectionView()
    private var categoryCollectionView = CategoryCollectionView()

    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular category"
        label.font = .poppinsBold40()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
}

extension SearchFoodViewController {
    func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(recipeCategoryCollectionView)
        view.addSubview(categoryCollectionView)

        recipeCategoryCollectionView.set(cells: RecieptListModel.fetchData())
        categoryCollectionView.set(cells: RecieptListModel.fetchData())
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
