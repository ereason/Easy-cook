//
//  ViewController.swift
//  Easy cook
//
//  Created by George on 26.02.2023.
//

import UIKit

class RecipeViewController: UIViewController {
    
    let scrollView: UIScrollView = { // scrolling View
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
    
        return scrollView
    }()
    
    // title recipe's label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PASTA WITH GARLIC, SCALLIONS, CAULIFLOWER & BREAD CRUMBS"
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins", size: 40) // !!!
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "frying.pan.fill"))
        image.tintColor = .black
        return image
    }()
    
    // cooking time label
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "45 min"
        label.font = UIFont(name: "Poppins", size: 20)
        return label
    }()

    // serving label (portions amount)
    let servingLabel: UILabel = {
        let label = UILabel()
        label.text = "2 servings"
        label.font = UIFont(name: "Poppins", size: 20)
        return label
    }()
    
    // likes label
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "200 likes"
        label.textAlignment = .right
        label.font = UIFont(name: "Poppins", size: 20)
        return label
    }()
    
    // ingredients label (extendedIngredients[5].original)
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = """
        1T butter
        1/4 cup whole wheat bread crumbs (I used panko)
        about 2T grated cheese (I used romano)
        6-8 ounces pasta (I used linguine)
        1-2T extra virgin olive oil
        about 2 cups frozen cauliflower florets, thawed, cut into bite-sized pieces
        5-6 cloves garlic
        3 scallions, chopped, white and green parts separated
        2-3T white wine
        salt and pepper, to taste
        couple of pinches red pepper flakes, optional
        """
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins", size: 14)
        return label
    }()
    
    // recipe field label
    let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = """
        In the meantime, begin to prepare your pasta according to the directions on the package. While the pasta is cooking, put about a tablespoon of olive oil in the same pan you used for the bread crumbs. Over medium heat, add the garlic, whites of the scallions, and cauliflower to the skillet. Saute until the cauliflower shows some caramelization. Then add the wine until the florets are tender-crisp. Add salt, pepper, and red pepper flakes.
        
        When pasta is just shy of al dente, reserve about a cup of the cooking water and drain the pasta. Add the drained pasta to the skillet—still over medium heat—with the veggies and toss with some pasta water, as necessary (I added a little at a time; I ended up using about 1/2 cup), till the pasta is coated and turns easily. You may want to add another little drizzle of olive oil. Again, taste and season accordingly.
        """
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "Poppins", size: 14)
        //        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
}

extension RecipeViewController {
    
    func setupViews() { // masks and adding on view
        
        // title and image stackView
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, imageView])
        titleStackView.axis = .vertical
        titleStackView.alignment = .fill
        titleStackView.distribution = .fillEqually
        titleStackView.spacing = 5
        
        // time, servings and likes label
        let infoStackView = UIStackView(arrangedSubviews: [timeLabel, servingLabel, likesLabel])
        infoStackView.axis = .horizontal
        infoStackView.alignment = .fill
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 10
        
        // info, ingridients and recipe's text
        let recipeStackView = UIStackView(arrangedSubviews: [ingredientsLabel, recipeLabel])
        recipeStackView.axis = .vertical
        recipeStackView.alignment = .fill
        recipeStackView.distribution = .fill
        recipeStackView.spacing = 40
        
        for i in [scrollView, titleStackView, infoStackView, recipeStackView] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(scrollView)
        
        for i in [titleStackView, infoStackView, recipeStackView] {
            scrollView.addSubview(i)
        }

        
        print("1")
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            titleStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0 ),
            titleStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            titleStackView.heightAnchor.constraint(equalToConstant: 300),
            
            infoStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 34),
            infoStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            infoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            infoStackView.heightAnchor.constraint(equalToConstant: 20),
            
            recipeStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 34),
            recipeStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            recipeStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            recipeStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recipeStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        
        ])
        

    }
}
