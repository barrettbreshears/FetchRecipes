//
//  MealsViewModel.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import Foundation
import Combine

@MainActor
class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String?
    @Published var selectedMeal: Meal?
    private var apiService: APIService = APIService()
    
    func selectMeal(meal: Meal) {
        selectedMeal = meal
    }
    
    func loadMeals() async {
        do {
            let fetchedMeals = try await apiService.fetchMeals()
            // Sort the meals alphabetically by their name
            self.meals = fetchedMeals.sorted(by: { $0.strMeal < $1.strMeal })
        } catch {
            // Handle and present error information to the user
            self.errorMessage = error.localizedDescription
        }
    }
}
