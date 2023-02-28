//
//  UserSettings.swift
//  Easy cook
//
//  Created by Sergey Azimov on 28.02.2023.
//

import Foundation

struct IdRecipes:Codable {
    var id: Int
}


final class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    private let idFavorite = "idFavorite"
    private let defaults = UserDefaults.standard
    
    var arrayFavoriteRecipesId:[IdRecipes]{
        get {
            if let data = defaults.value(forKey: idFavorite) as? Data {
                return try! PropertyListDecoder().decode([IdRecipes].self, from: data)
            } else {
                return [IdRecipes]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: idFavorite)
            }
        }
        
    }
    
    //add Id to array
    func addRecipeId(id:Int) {
        let idAdress = IdRecipes(id: id)
        arrayFavoriteRecipesId.insert(idAdress, at: 0)
    }
    
    func removeRecipeId(indexPath: Int) {
        if !arrayFavoriteRecipesId.isEmpty {
            arrayFavoriteRecipesId.remove(at: indexPath)
        } else {
            print("You don't have a value in array")
        }
    }
}
