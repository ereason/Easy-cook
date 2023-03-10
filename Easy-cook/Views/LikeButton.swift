import UIKit

class LikeButton: UIButton {
    
    static var subscribers = [Int: Set<LikeButton>]()
    static var store = UserDefaultsController()
    
    var itemId = 0
    
    init() {
        super.init(frame: .zero)
        tintColor = .redAccent
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setID(id: Int){
        itemId = id
        
        if  !LikeButton.subscribers.keys.contains(id) {
            LikeButton.subscribers[id] = Set<LikeButton>()
        }
        
        LikeButton.subscribers[id]!.insert(self)
        self.updateApperance()
    }
    
    func updateApperance() {
        
        if isLiked {
            
            LikeButton.subscribers[itemId]!.forEach({
                $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            })
        } else {
            
            LikeButton.subscribers[itemId]!.forEach({
                $0.setImage(UIImage(systemName: "heart"), for: .normal)
            })
        }
        
    }
    
    
    var isLiked: Bool {
        return LikeButton.store.getIds().contains(itemId)
    }
    
    @objc func buttonTapped() {
        var ids = LikeButton.store.getIds()
        if isLiked {
            print("remove")
            ids.remove(itemId)
            print(ids)
        } else {
            print("saving")
            ids.insert(itemId)
            print(ids)
        }
        
        LikeButton.store.saveFavoriteId(ids)
        updateApperance()
    }
    
    deinit {
        LikeButton.subscribers[itemId]!.remove(self)
        
        if LikeButton.subscribers[itemId]!.count == 0{
            LikeButton.subscribers.removeValue(forKey: itemId)
        }
    }
}
