import UIKit
import Kingfisher

class TableViewPrototypeCell: UITableViewCell {
    
    var recieptImageView = UIImageView()
    var recieptTitleLabel = UILabel()
    var recieptLikeButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(recieptImageView)
        addSubview(recieptTitleLabel)
        contentView.addSubview(recieptLikeButton)
        
        configurRecieptImageView()
        configurRecieptNameLabel()
        configureRecieptLikeButton()
        setImageConstraints()
        setTitleLableConstraints()
        setRecieptLikeButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Like Button Defenition
    @objc func recieptLikeButtonPressed(sender: UIButton!) {
            print("______________----------_____________------------______________--------")
       }
    
    func set(recieptList: ResultModel) {
        recieptImageView.kf.setImage(with: URL(string: recieptList.image))
        //recieptImageView.image =
        recieptTitleLabel.text = recieptList.title
    }
    
    func configurRecieptImageView() {
        recieptImageView.layer.cornerRadius = 10
        recieptImageView.clipsToBounds = true
    }
    
    func configurRecieptNameLabel() {
        recieptTitleLabel.numberOfLines = 1
        recieptTitleLabel.adjustsFontSizeToFitWidth = false
    }
    
    func configureRecieptLikeButton() {
        recieptLikeButton.setImage(UIImage(systemName: K.systemHeartImage), for: .normal)
        recieptLikeButton.setAttributedTitle(nil, for: .normal)
        recieptLikeButton.addTarget(self, action: #selector(recieptLikeButtonPressed), for: .touchUpInside)
    }
    
    func setImageConstraints() {
        recieptImageView.translatesAutoresizingMaskIntoConstraints = false
        recieptImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        recieptImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        recieptImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        recieptImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setTitleLableConstraints() {
        recieptTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recieptTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 205).isActive = true
        recieptTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        recieptTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        recieptTitleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setRecieptLikeButtonConstraints() {
        recieptLikeButton.translatesAutoresizingMaskIntoConstraints = false
        recieptLikeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        recieptLikeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        recieptLikeButton.topAnchor.constraint(equalTo: topAnchor, constant: 205).isActive = true
        recieptLikeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
