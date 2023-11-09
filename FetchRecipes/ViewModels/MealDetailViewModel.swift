//
//  MealDetailViewModel.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//
import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var errorMessage: String?
    private var apiService: APIService = APIService()
    let mealID: String
    
    init(mealID: String) {
        self.mealID = mealID
    }
    
    func loadMealDetails() async{
        do {
            let details = try await apiService.fetchMealDetails(id: mealID)
            DispatchQueue.main.async {
                self.mealDetail = details.meals.first
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
