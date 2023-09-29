//
//  FirstView.swift
//  SoYouThinkYouKnowSwift
//
//  Created by Josh Flores on 9/28/23.
//

import UIKit
import Combine

class FirstView: UIViewController {
   
    private var vm = QuestionViewModel()
    
    private var mainTitle: UILabel = {
        let title = UILabel()
        title.text = "So You Think You Know?!"
        title.font = .systemFont(ofSize: 40, weight: .heavy)
        title.numberOfLines = 0
        title.textAlignment = .center
        
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 2, height: 2)
        title.layer.shadowRadius = 4
        title.layer.shadowOpacity = 0.5
        
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private func mainTitleConstraint() {
        let leading = mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let top = mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        let width = mainTitle.widthAnchor.constraint(equalToConstant: 350)
        let heigth = mainTitle.heightAnchor.constraint(equalToConstant: 350)
        
        NSLayoutConstraint.activate([leading, top, width, heigth])
        
    }
    
    private var startButton: UIButton = {
        let start = UIButton()
        start.setTitle("Start", for: .normal)
        start.layer.cornerRadius = 7
        start.backgroundColor = .systemGray
        start.setTitleColor(.black, for: .normal)
        start.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        start.translatesAutoresizingMaskIntoConstraints = false
        return start
    }()
    
    @objc func startQuiz() {
        let main = MainView(vm: vm)
        
        self.vm.selectedCategory = selectedCategory.text!
        self.vm.score = 0
        self.navigationController?.pushViewController(main, animated: true)

        
    }
    
    private func startButtonConstraint() {
        let center = startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150)
        let bottom = startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        let width = startButton.widthAnchor.constraint(equalToConstant: 100)
        let heigth = startButton.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([center, bottom, width, heigth])
        
    }
    
    private var quizCategory: UIButton = {
        
        let categoryButton = UIButton()
        categoryButton.setTitle("Category", for: .normal)
        categoryButton.setTitleColor(UIColor.blue, for: .normal)
        categoryButton.titleLabel?.textAlignment = .right
        categoryButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        categoryButton.addAction(UIAction(title: "", handler: { _ in
            print("category")
        }), for: .touchUpInside)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        return categoryButton
    }()
    
    private func quizCategoryConstraint() {
        let leading = quizCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let top = quizCategory.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 20)
        let width = quizCategory.widthAnchor.constraint(equalToConstant: 150)
        let heigth = quizCategory.heightAnchor.constraint(equalToConstant: 80)
        
        NSLayoutConstraint.activate([leading, top, width, heigth])
        
    }
    
    @objc private func chooseCategory() -> UIMenu {

            let category = UIMenu(title: "", options: .displayInline, children: [
                UIAction(title: "🏀 Sports") { _ in
                    self.vm.selectedCategory = "Sports 🏀"
                    
                },
                UIAction(title: "🦁 Animals") { _ in
                    self.vm.selectedCategory = "🦁 Animals"
                    self.selectedCategory.text = self.vm.selectedCategory
                    
                },
                UIAction(title: "📖 Books") { _ in
                    self.vm.selectedCategory = "📖 Books"
                    self.selectedCategory.text = self.vm.selectedCategory
                },
                UIAction(title: "🎥 Film") { _ in
                    self.vm.selectedCategory = "🎥 Film"
                    self.selectedCategory.text = self.vm.selectedCategory
                },
                UIAction(title: "🎼 Music") { _ in
                    self.vm.selectedCategory = "🎼 Music"
                    self.selectedCategory.text = self.vm.selectedCategory
                },
                UIAction(title: "🚗 Vehicles") { _ in
                    self.vm.selectedCategory = "🚗 Vehicles"
                    self.selectedCategory.text = self.vm.selectedCategory
                }
            ])
            return category
    }
    
    private var selectedCategory: UILabel = {
        
        var selected = UILabel()
        
        selected.font = .systemFont(ofSize: 20, weight: .medium)
        selected.textColor = .black
        selected.textAlignment = .right
        
        selected.translatesAutoresizingMaskIntoConstraints = false
        return selected
    }()
    
    private func selectedCategoryConstraint() {
        let leading = selectedCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let top = selectedCategory.topAnchor.constraint(equalTo: quizCategory.bottomAnchor, constant: 0)
        let width = selectedCategory.widthAnchor.constraint(equalToConstant: 150)
        let heigth = selectedCategory.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([leading, top, width, heigth])
        
    }
    
    private var quizDifficulty: UIButton = {
        let categoryButton = UIButton()
        categoryButton.setTitle("Difficulty", for: .normal)
        categoryButton.setTitleColor(UIColor.blue, for: .normal)
        categoryButton.titleLabel?.textAlignment = .right
        categoryButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        categoryButton.addAction(UIAction(title: "", handler: { _ in
            print("difficulty")
        }), for: .touchUpInside)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        return categoryButton
    }()
    
    private func quizDifficultyConstraint() {
        let leading = quizDifficulty.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let top = quizDifficulty.topAnchor.constraint(equalTo: selectedCategory.bottomAnchor)
        let width = quizDifficulty.widthAnchor.constraint(equalToConstant: 150)
        let heigth = quizDifficulty.heightAnchor.constraint(equalToConstant: 80)
        
        NSLayoutConstraint.activate([leading, top, width, heigth])
        
    }
    
    @objc private func chooseDifficulty() -> UIMenu {
        let difficulties = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Easy") { _ in
                self.vm.selectedDifficulty = "easy"
                self.selectedDifficulty.text = "Easy"
            },
            UIAction(title: "Medium") { _ in
                self.vm.selectedDifficulty = "medium"
                self.selectedDifficulty.text = "Medium"
            },
            UIAction(title: "Hard"){ _ in
                self.vm.selectedDifficulty = "hard"
                self.selectedDifficulty.text = "Hard"
            }
        ])
        return difficulties
        
    }

    private var selectedDifficulty: UILabel = {
        
        var selected = UILabel()
        
        selected.font = .systemFont(ofSize: 20, weight: .medium)
        selected.textColor = .black
        selected.textAlignment = .right
        
        selected.translatesAutoresizingMaskIntoConstraints = false
        return selected
    }()
    
    private func selectedDifficultyConstraint() {
        let leading = selectedDifficulty.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let top = selectedDifficulty.topAnchor.constraint(equalTo: quizDifficulty.bottomAnchor, constant: 0)
        let width = selectedDifficulty.widthAnchor.constraint(equalToConstant: 150)
        let heigth = selectedDifficulty.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([leading, top, width, heigth])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        self.view.addSubview(mainTitle)
        self.view.addSubview(startButton)
        self.view.addSubview(quizCategory)

        self.view.addSubview(selectedCategory)
        selectedCategory.text = vm.selectedCategory
        
        self.startButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        self.quizCategory.menu = chooseCategory()
        self.quizDifficulty.menu = chooseDifficulty()
        
        self.view.addSubview(quizDifficulty)
        self.view.addSubview(selectedDifficulty)
        selectedDifficulty.text = vm.selectedDifficulty
       
        mainTitleConstraint()
        quizCategoryConstraint()
        selectedCategoryConstraint()
        quizDifficultyConstraint()
        selectedDifficultyConstraint()
        startButtonConstraint()
        
    }
    
    
}


