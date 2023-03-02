

import UIKit
import Kingfisher

class RecipeViewController: UIViewController {
  
    var requestManager = RequestManager()
    
    let scrollView: UIScrollView = { // scrolling View
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()
    
    // title recipe's label
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsBold40()
        return label
    }()
    
    var imageView: UIImageView = {
//        let image = UIImageView(image: UIImage(systemName: "frying.pan.fill"))
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
//        image.tintColor = .black
       return image
    }()
    
    // cooking time label
    let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "45 min"
        label.numberOfLines = 0
        label.font = UIFont.poppinsBold16()
        return label
    }()

    // serving label (portions amount)
    var servingLabel: UILabel = {
        let label = UILabel()
//        label.text = "2 servings"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.poppinsBold16()
        return label
    }()
    
    // likes label
    var likesLabel: UILabel = {
        let label = UILabel()
//        label.text = "200 likes"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.poppinsBold16()
        return label
    }()
    
    // ingredients label
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.numberOfLines = 0
        label.font = UIFont.poppinsRegular16()
        return label
    }()
    
    // recipe field label
    let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Direction"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.poppinsRegular16()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        requestManager.delegate = self
        requestManager.fetchRecipe(636729)
    }
}

extension RecipeViewController {
    
    func setupViews() { // masks and adding on view
        // title and image stackView
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, imageView])
        titleStackView.axis = .vertical
        titleStackView.alignment = .fill
        titleStackView.distribution = .equalSpacing
        titleStackView.spacing = 10
        
        // time, servings and likes label
        let infoStackView = UIStackView(arrangedSubviews: [timeLabel, servingLabel, likesLabel])
        infoStackView.axis = .horizontal
        infoStackView.alignment = .fill
        infoStackView.distribution = .equalCentering
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
        
        view.addSubview(scrollView) // add scrollView
        
        for i in [titleStackView, infoStackView, recipeStackView] {
            scrollView.addSubview(i)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0 ),
            titleStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            titleStackView.heightAnchor.constraint(equalToConstant: 400),
            
            infoStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 34),
            infoStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            infoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            infoStackView.heightAnchor.constraint(equalToConstant: 50),
            
            recipeStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 34),
            recipeStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            recipeStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            recipeStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recipeStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

extension RecipeViewController: RequestManagerDelegate{
    
    func didUpdateRecipe(_ requestManager: RequestManager, recipe: RecipeModel) {
        DispatchQueue.main.async {
            
            self.titleLabel.text = recipe.title // title
            
            // image
            if let imageUrl = URL(string: "https://spoonacular.com/recipeImages/636729-556x370.jpg") {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                        return
                    }
                    if let imageData = data, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            // Update the UI on the main thread
                            self.imageView.image = image
                        }
                    }
                }.resume()
            }
            
            // info labels
            self.timeLabel.text = "\(recipe.minutes) \nminutes"
            self.servingLabel.text = "\(recipe.servings) \nservings"
            self.likesLabel.text = "\(recipe.likes) \nlikes"
            
            // ingredients label
            for i in 0...recipe.ingredients.count - 1 {
                let originalIngridients = recipe.ingredients[i].original
                self.ingredientsLabel.text! += "\n\(originalIngridients)"
            }
            
            let ingredientString = NSMutableAttributedString(string: self.ingredientsLabel.text!)
            ingredientString.setAttributes([NSAttributedString.Key.font: UIFont.poppinsBold18()!],
                                           range: NSMakeRange(0, 11))
            self.ingredientsLabel.attributedText = ingredientString
            
            // recipe label
            var recipeText = "\(recipe.steps)"
            for _ in 1...2 {
                recipeText.removeFirst()
                recipeText.removeLast()
            }
            self.recipeLabel.text! += "\n\(recipeText)"
            
            let recipeString = NSMutableAttributedString(string: self.recipeLabel.text!)
            recipeString.setAttributes([NSAttributedString.Key.font: UIFont.poppinsBold18()!],
                                           range: NSMakeRange(0, 9))
            self.recipeLabel.attributedText = recipeString
            
            print(recipe)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
