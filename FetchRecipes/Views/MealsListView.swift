//
//  MealsListView.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import SwiftUI

struct MealListView: View {
    @StateObject var viewModel: MealsViewModel = MealsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.meals) { meal in
                        HStack {
                            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                image.resizable()
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .redacted(reason: .placeholder)
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            
                            Text(meal.strMeal)
                            
                            Spacer()
                        }.padding([.leading, .trailing], 10)
                        .onTapGesture {
                            viewModel.selectMeal(meal: meal)
                        }
                    }
                }
            }
            .navigationTitle("Dessert Meals")
        }
        .sheet(item: $viewModel.selectedMeal) { meal in
            MealDetailView(meal: $viewModel.selectedMeal)
        }
        .alert("Error", isPresented: Binding<Bool>.constant($viewModel.errorMessage.wrappedValue != nil), actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        })
        .onAppear {
            Task{
                await viewModel.loadMeals()
            }
        }
        
    }
}

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
