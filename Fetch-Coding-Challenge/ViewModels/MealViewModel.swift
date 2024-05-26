//
//  ModelViewModel.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchMeals()
    }
    
    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            
            //Subscribe to the publisher on the background thread
            .subscribe(on: DispatchQueue.global(qos: .background))
        
            //Render the UI on the main thread
            .receive(on: DispatchQueue.main)
        
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            
            //Decode the data using the standard JSONDecoder
            .decode(type: MealMenu.self, decoder: JSONDecoder())
        
            //Since the meals are nested one level within, we will need to transform the data to only include array of meals
            .map({ mealMenu in
                return mealMenu.meals
            })
        
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Successfully fetched data.")
                case .failure(let error):
                    print("Unable to fetch data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] receivedItems in
                self?.meals = receivedItems
            }
        
            .store(in: &cancellables)

    }
}
