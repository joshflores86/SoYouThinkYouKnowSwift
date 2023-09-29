//
//  MainView.swift
//  SoYouThinkYouKnowSwift
//
//  Created by Josh Flores on 9/28/23.
//

import UIKit
import Combine

class MainView: UIViewController {
    
    private var vm: QuestionViewModel
    
    init(vm: QuestionViewModel){
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cancelable: AnyCancellable?
    var answer: AnswerModel?
    var index: Int = 0
    var buttonTitles: [String] = []
    var choiceButton: [UIButton] = []
    var selectedButton = AnswerModel(answer: "", isCorrect: false)
    var testChoices: [AnswerModel] = []
    var readyForResults: Bool = false
    
    
    var questionLabel: UILabel = {
        
        var questions = UILabel()
        
        questions.textAlignment = .center
        questions.font = .systemFont(ofSize: 25, weight: .bold)
        questions.translatesAutoresizingMaskIntoConstraints = false
        questions.numberOfLines = 0
        
        return questions
    }()
    
    func questionLabelContraint() {
        let leading = questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let top = questionLabel.topAnchor.constraint(equalTo: newTitle.bottomAnchor, constant: 10)
        let width = questionLabel.widthAnchor.constraint(equalToConstant: 350)
        let height = questionLabel.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([leading, top, width, height])
    }
    
    var choices: [UIButton] = {
        
        var answers = [UIButton]()
        
        
        
        return answers
    }()
    
    var newTitle: UILabel = {
        let title = UILabel()
        title.text = "So You Think You Know?!"
        title.font = .systemFont(ofSize: 25, weight: .bold)
        title.numberOfLines = 0
        /* title.layer.shadowOpacity = 0.8
         title.shadowOffset = CGSize(width: 5, height: 5)*/
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func newTitleConstraint() {
        let leading = newTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let bottom = newTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 25)
        let width = newTitle.widthAnchor.constraint(equalToConstant: 175)
        let height = newTitle.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([leading, bottom, width, height])
    }
    
    var progressLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func progresLabelConstraint() {
        let leading = progressLabel.leadingAnchor.constraint(equalTo: newTitle.trailingAnchor, constant: 20)
        let bottom = progressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        let width = progressLabel.widthAnchor.constraint(equalToConstant: 175)
        let height = progressLabel.heightAnchor.constraint(equalToConstant: 20)
        
        NSLayoutConstraint.activate([leading, bottom, width, height])
    }
    
    func setTitle() {/* if let navigationBar = navigationController?.navigationBar {
                      let titleAttributes: [NSAttributedString.Key: Any] = [
                      .font: UIFont.systemFont(ofSize: 30, weight: .heavy),
                      .foregroundColor: UIColor.black
                      ]
                      navigationBar.titleTextAttributes = titleAttributes
                      }*/}
    
    var nextButton: UIButton = {
        var next = UIButton()
        next.setTitle("NEXT", for: .normal)
        next.backgroundColor = .blue
        next.layer.cornerRadius = 10
        next.translatesAutoresizingMaskIntoConstraints = false
        
        
        return next
    }()
    
    func nextButtonConstraint() {
        let leading = nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150)
        let bottom = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        let width = nextButton.widthAnchor.constraint(equalToConstant: 100)
        let height = nextButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([leading, bottom, width, height])
    }
    
    func updateUI() {
        if index < vm.questionModel.count  {
            questionLabel.text = vm.questionModel[index].formattedQuestion
            self.progressLabel.text =  "\(self.index + 1) out of 10"
            var topAnchor = questionLabel.bottomAnchor
            removeAllItems()
            testChoiceArray()
            
            for choice in testChoices {
                let allChoices = UIButton()
                allChoices.translatesAutoresizingMaskIntoConstraints = false
                allChoices.setTitle(choice.answer, for: .normal)
                allChoices.addTarget(self, action: #selector(selectedAnswer), for: .touchUpInside)
                allChoices.backgroundColor = .blue
                allChoices.layer.cornerRadius = 10
                self.view.addSubview(allChoices)
                
                NSLayoutConstraint.activate([
                    allChoices.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    allChoices.widthAnchor.constraint(equalToConstant: 360),
                    allChoices.heightAnchor.constraint(equalToConstant: 50),
                    allChoices.topAnchor.constraint(equalTo: topAnchor, constant: 10)
                ])
                
                topAnchor = allChoices.bottomAnchor
                
                buttonTitles.append((allChoices.titleLabel?.text)!)
                
                choices.append(allChoices)
                
            }
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        //       self.title = "SO YOU THINK YOU KNOW"
        //       setTitle()
        view.backgroundColor = .systemMint
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        
        self.view.addSubview(questionLabel)
        self.view.addSubview(nextButton)
        self.view.addSubview(newTitle)
        self.view.addSubview(progressLabel)
        
        progresLabelConstraint()
        newTitleConstraint()
        questionLabelContraint()
        nextButtonConstraint()
        
        vm.getData {
            self.updateUI()
            
        }
    }
    
    
    
    @objc func nextQuestion() {
        if index >= 9 {
            let resultsView = ResultsView()
            resultsView.vm = vm
            self.navigationController?.pushViewController(resultsView, animated: true)
        }
        if index >= 8 {
            index += 1
            updateUI()
        }else{
            index += 1
            updateUI()
        }
    }
    
    @objc func selectedAnswer(_ sender: UIButton) {
        
        if let selection = choices.firstIndex(of: sender) {
            selectedButton = testChoices[selection]
            if selectedButton.isCorrect {
                sender.backgroundColor = .green
                disableButtons()
                vm.scoreKeeper()
                print(vm.score)
            }else{
                sender.backgroundColor = .red
                if let correctIndex =  testChoices.firstIndex(where: { $0.isCorrect }){
                    let correctButton = choices[correctIndex]
                    correctButton.backgroundColor = .green
                }
                disableButtons()
            }
            
        }
    }
    
    func testChoiceArray() {
        testChoices.append(contentsOf: vm.questionModel[index].choices)
    }
    
    func removeAllItems() {
        buttonTitles.removeAll()
        choices.removeAll()
        testChoices.removeAll()
    }
    
    func disableButtons() {
        for button in choices {
            button.isEnabled = false
        }
    }
    
}

