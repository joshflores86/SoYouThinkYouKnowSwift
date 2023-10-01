//
//  ResultsView.swift
//  SoYouThinkYouKnowSwift
//
//  Created by Josh Flores on 9/28/23.
//

import UIKit

class ResultsView: UIViewController {
    lazy var vm = QuestionViewModel()

    lazy var seeResults: UILabel = {
        
        let results = UILabel()
        results.textAlignment = .center
        results.numberOfLines = 0
        results.font = .systemFont(ofSize: 30, weight: .bold)
        results.translatesAutoresizingMaskIntoConstraints = false
        return results
    }()
        
    lazy var backHome: UIButton = {
        let home = UIButton()
        home.setTitle("Start Over", for: .normal)
        home.setTitleColor(.black, for: .normal)
        home.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        home.backgroundColor = .systemMint
        home.layer.cornerRadius = 10
        

        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()

    @objc func returnHome() {
        print(navigationController!.viewControllers)
        

        self.navigationController?.popToRootViewController(animated: true)
                
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
        
        self.view.addSubview(seeResults)
        self.seeResults.text = "Your score is \n \(vm.score) out of \(vm.questionModel.count)"
        self.view.addSubview(backHome)
        self.navigationItem.hidesBackButton = true
        self.backHome.addTarget(self, action: #selector(returnHome), for: .touchUpInside)
        
        backHomeButtonConstraint()
        resultConstraint()
        self.vm.getData {
            
        }
    }
    func resultConstraint() {
        let leading = seeResults.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let top = seeResults.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        let width = seeResults.widthAnchor.constraint(equalToConstant: 300)
        let height = seeResults.heightAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([leading, top, width, height])
    }

    func backHomeButtonConstraint() {
        let leading = backHome.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        let top = backHome.topAnchor.constraint(equalTo: seeResults.bottomAnchor, constant: 200)
        let width = backHome.widthAnchor.constraint(equalToConstant: 150)
        let height = backHome.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([leading, top, width, height])
    }
    
}

