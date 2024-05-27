//
//  DessertDetailViewModel.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//
import Combine
import Foundation


class DessertDetailViewModel: ObservableObject {
    @Published var dessertDetail: DessertInfo?
    var cancellables: Set<AnyCancellable> = []
    
    func fetchDessertDetail(with dessertId: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessertId)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: DessertDetail.self, decoder: JSONDecoder())
            .map { $0.meals.first }
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    print("Successfully received dessert details!")
                case .failure(let error):
                    print("Unable to fetch dessert details: \(error.localizedDescription)")
                    
                }
            }) { [weak self] receivedItem in
                self?.dessertDetail = receivedItem
            }
            .store(in: &cancellables)
    }
    
}
