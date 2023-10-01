//
//  QuestionViewModel.swift
//  SoYouThinkYouKnowSwift
//
//  Created by Josh Flores on 9/28/23.
//

import Foundation
import Combine
import UIKit

class QuestionViewModel: ObservableObject {
    
    @Published var questionModel: [Result] = []
    @Published var answer: AnswerModel?
    var cancelable = Set<AnyCancellable>()
    @Published var score: Int = 0
    @Published var selectedCategory: String = "-" {
        didSet {
            print(selectedCategory)
        }
    }
    @Published var selectedDifficulty: String? = "-" {
        didSet {
            print(selectedDifficulty!)
        }
    }
    private var categories: [String: Int] = ["Sports 🏀": 21, "Animals 🦁" : 27, "Books 📖": 10,
                                                        "Film 🎥": 11, "Music 🎼": 12, "Vehicles 🚗": 28]
    
    
    init() {
        getData(completion: {})
    }
    
    func getData(completion: @escaping () -> Void) {
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(categories[selectedCategory] ?? 21)&difficulty=\(selectedDifficulty ?? String("medium"))&type=multiple") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: QuestionModel.self, decoder: JSONDecoder())
            
            .map { [weak self] questions in
                self?.questionModel = questions.results
                completion()
            }
            .catch {error -> Just<Void> in
                print("Error \(error)")
                completion()
                return Just(())
            }
            .sink(receiveValue: { _ in })
            .store(in: &cancelable)

    }
    
    func scoreKeeper() {
        score += 1
        
        
    }
    
}




