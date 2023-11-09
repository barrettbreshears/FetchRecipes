//
//  APIService.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import Foundation

class APIService {
    
    // Fetch meals
    func fetchMeals() async throws -> [Meal] {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
        return mealsResponse.meals
    }
    
    // Fetch meal details
    func fetchMealDetails(id: String) async throws -> MealDetailResponse {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetail = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return mealDetail
    }
}
