//
//  Meal.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import Foundation

struct Dessert: Codable, Identifiable {
    
    //Changed the api string representation into a more intuitive string format
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
    
    let mealName: String
    let image: String
    let id: String
}


struct MealMenu: Codable {
    let meals: [Dessert]
}
