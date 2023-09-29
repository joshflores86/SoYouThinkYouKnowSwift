//
//  QuestionModel.swift
//  SoYouThinkYouKnowSwift
//
//  Created by Josh Flores on 9/28/23.
//

import Foundation

// MARK: - QuestionModel
class QuestionModel: Codable {
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(results: [Result]) {
        self.results = results
    }
}

// MARK: - Result
class Result: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    var formattedQuestion: String {
        do {
            let formattedString = try NSAttributedString(markdown: question)
            let attributedString = formattedString.string
            return attributedString
        }catch{
            fatalError("Failed in formatting question \(error)")
            
        }
    }
    
    var choices: [AnswerModel] {
        do{
            let correctChoice = [AnswerModel(answer: correctAnswer, isCorrect: true)]
            let incorrectChoice =  incorrectAnswers.map { answers in
                AnswerModel(answer: answers, isCorrect: false)
            }
            let allChoices = correctChoice + incorrectChoice
            
            return allChoices.shuffled()
        }catch{
            fatalError("Error during gathering answers \(error)")
        }
    }

    init(category: String, type: String, difficulty: String, question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}

enum Category: String, Codable {
    case vehicles = "Vehicles"
}

enum Difficulty: String, Codable {
    case medium = "medium"
}

enum TypeEnum: String, Codable {
    case multiple = "multiple"
}
















