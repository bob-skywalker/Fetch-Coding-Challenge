//
//  Meal.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import Foundation

struct Dessert: Codable, Identifiable, Hashable {
    
    init(dessertName: String, image: String, id: String) {
        self.dessertName = dessertName
        self.image = image
        self.id = id
    }
    
    //Changed the api string representation into a more intuitive string format
    enum CodingKeys: String, CodingKey {
        case dessertName = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
    
    let dessertName: String
    let image: String
    let id: String
    

}


struct MealMenu: Codable {
    let meals: [Dessert]
}
