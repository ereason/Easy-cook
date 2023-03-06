import UIKit
import Kingfisher
class RecipeViewController: UIViewController {
    
    var requestManager = RequestManager()
    
    var subviewsCount = Int()
    
    var activityIndicatorView: UIActivityIndicatorView = { //indicator
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let scrollView: UIScrollView = { // scrolling View
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // like button
    var likesButton: LikeButton = {
        return LikeButton()
    }()
    
    // title recipe's label
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsBold35()
        label.textColor = .textAccent
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    // cooking time label
    let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .textAccent
        label.font = UIFont.poppinsBold16()
        return label
    }()
    
    // serving label (portions amount)
    var servingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textAccent
        label.font = UIFont.poppinsBold16()
        return label
    }()
    
    // likes label
    var likesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textAccent
        label.font = UIFont.poppinsBold16()
        return label
    }()
    
    // buttonArray (TODO list)
    var buttonArray = [UIButton]()
    
    // checkmark label
    
    //    let checkmarkLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "✔️"
    //        label.font = UIFont.poppinsBold12()
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    // recipe field label
    let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Direction"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textAccent
        label.font = UIFont.poppinsRegular16()
        return label
    }()
    
    var id: Int
    
    init(_ id: Int) {
        self.id = id
        likesButton.setID(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.id = 10000
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likesButton.updateApperance()
        indicatorViewWork()
        view.backgroundColor = .backgroundColor
        requestManager.delegate = self
        requestManager.fetchRecipe(id)
    }
    
    @objc func likeButtonPressed() {
    }
}

extension RecipeViewController {
    
    func indicatorViewWork() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
    }
    
    func setupViews() { // masks and adding on view
        // time, servings and likes label
        let infoStackView = UIStackView(arrangedSubviews: [timeLabel, servingLabel, likesLabel])
        infoStackView.axis = .horizontal
        infoStackView.alignment = .fill
        infoStackView.distribution = .equalCentering
        
        
        for button in buttonArray {
            button.layer.cornerRadius = 10
            button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 30)
            //            button.getShadow(button)
            button.backgroundColor = .clear
            button.setTitleColor(.textAccent, for: .normal)
//            button.sizeToFit()
            button.titleLabel?.font = UIFont.poppinsRegular16()
            button.titleLabel?.textColor = .textAccent
            button.titleLabel?.numberOfLines = 0
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .clear
        }
        
        // ingredients stck
        let toDoButtonStackView = UIStackView(arrangedSubviews: buttonArray)
        toDoButtonStackView.axis = .vertical
        toDoButtonStackView.alignment = .fill
        toDoButtonStackView.distribution = .fillEqually
        toDoButtonStackView.spacing = 20
        
        for i in [scrollView, likesButton, titleLabel, imageView, infoStackView, toDoButtonStackView, recipeLabel] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(scrollView) // add scrollView
        
        for i in [titleLabel, imageView, infoStackView, toDoButtonStackView, recipeLabel, likesButton] {
            scrollView.addSubview(i)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 180),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            infoStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 34),
            infoStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            infoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            infoStackView.heightAnchor.constraint(equalToConstant: 50),
            
            toDoButtonStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 34),
            toDoButtonStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            toDoButtonStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            
            recipeLabel.topAnchor.constraint(equalTo: toDoButtonStackView.bottomAnchor, constant: 34),
            recipeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            recipeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            recipeLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recipeLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            likesButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            likesButton.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -16),
            likesButton.heightAnchor.constraint(equalToConstant: 40),
            likesButton.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

extension RecipeViewController: RequestManagerDelegate {
    
    func didUpdateRecipe(_ requestManager: RequestManager, recipe: RecipeModel) {
        
        DispatchQueue.main.async {
            
            self.titleLabel.text = recipe.title // title
            
            self.imageView.kf.setImage(with: URL(string: recipe.imageURL))
            
            // info labels
            self.timeLabel.text = "\(recipe.minutes) \nminutes"
            self.servingLabel.text = "\(recipe.servings) \nservings"
            self.likesLabel.text = "\(recipe.likes) \nlikes"
            
            // ingredients button
            for i in 0...recipe.ingredients.count - 1 {
                let originalIngridients = recipe.ingredients[i].original
                //                let button = UIButton(type: .system)
                let button = UIButton(type: .system)
                button.addTarget(self, action: #selector(self.buttonTouched(_:)), for: .touchUpInside)
                button.setTitle(originalIngridients, for: .normal)
                self.buttonArray.append(button)
            }
            
            // recipe label
            var recipeText = recipe.steps.isEmpty ? "\(recipe.sourceURL)" : "\(recipe.steps)"
            
            let regex = try! NSRegularExpression(pattern: "(^\\[\"|\"\\]$)", options: .caseInsensitive)
            recipeText = regex.stringByReplacingMatches(in: recipeText, options: [], range: NSRange(0..<recipeText.utf16.count), withTemplate: "")
            
            self.recipeLabel.text! += "\n\(recipeText)"
            
            let recipeString = NSMutableAttributedString(string: self.recipeLabel.text!)
            recipeString.setAttributes([NSAttributedString.Key.font: UIFont.poppinsBold18()!],
                                       range: NSMakeRange(0, 9))
            self.recipeLabel.attributedText = recipeString
            self.setupViews()
            
            self.activityIndicatorView.stopAnimating()
            
            print(recipe)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
//        let checkmarkLabel: UILabel = {
//            let label = UILabel()
//            label.text = "√"
//            label.tintColor = .red
//            label.textColor = .red
//            label.font = UIFont.poppinsBold16()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
        
        let imageView = UIImageView(image: UIImage(named: "checkmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if sender.subviews.count == subviewsCount {
            sender.subviews.last?.removeFromSuperview()
        } else {
            //            sender.addSubview(checkmarkLabel)
            sender.addSubview(imageView)
            subviewsCount = sender.subviews.count
//            print(subviewsCount)
    
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: sender.centerYAnchor),
                imageView.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: -10),
                imageView.heightAnchor.constraint(equalToConstant: 16),
                imageView.widthAnchor.constraint(equalToConstant: 16)
            ])
        }
    }
    
    
}
