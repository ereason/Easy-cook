import UIKit
struct RecipeListModel {
    var results: [ResultModel]
    let offset, number, totalResults: Int
    
    init(data: Recipes) {
        self.results = []
        
        self.offset = data.offset
        self.number = data.number
        self.totalResults = data.totalResults
        data.results.forEach{
            self.results.append(ResultModel(data: $0))
        }
    }
}
struct ResultModel {
    let id: Int
    let title: String
    let image: String
    let imageType: String
    
    init(data: Result) {
        self.id = data.id
        self.title = data.title
        self.image = data.image.replacingOccurrences(of: "http:", with: "https:")
        self.imageType = data.imageType
    }
}
