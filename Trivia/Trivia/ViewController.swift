//
//  ViewController.swift
//  Trivia
//
//  Created by Raz on 11/04/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answersButtons: [UIButton]!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var addQuestionButton: UIButton!
    
    
    var currentQuestion: Int = -1
    var score: Int = 0
    
    var questionsArray: [Question] = [
        Question(question: "What is the biggest mainland?", answers: ["Europe", "Asia", "Africa", "America"], correctAnswer: "Asia"),
//        Question(question: "Who is the king of all animals?", answers: ["Cat 🐱", "Tiger 🐅", "Lion 🦁","Whale 🐋"], correctAnswer: "Lion 🦁"),
//        Question(question: "What is the capital of France?", answers: ["Nice", "Lyon", "Strasbourg","Paris"], correctAnswer: "Paris"),
//        Question(question: "How many legs does a chicken have? 🐓", answers: ["2", "3", "4","8"], correctAnswer: "2"),
//        Question(question: "How many stars appear on the American Flag? 🇺🇸", answers: ["10", "50", "25","100"], correctAnswer: "50"),
//        Question(question: "How many legs does a spider have? 🕷", answers: ["10", "2", "8","4"], correctAnswer: "8"),
//        Question(question: "What color do you get when you combine yellow and blue? ", answers: ["Green", "Purple", "Pink","Black"], correctAnswer: "Green"),
//        Question(question: "Which Disney movie is Elsa in?", answers: ["Frozen", "The Little Mermaid", "Aladdin","Beauty and the Beast"], correctAnswer: "Frozen"),
//        Question(question: "What do bees make? 🐝", answers: ["Honey","Milk","Water","Eggs"], correctAnswer: "Honey"),
//        Question(question: "How many days are in a year?", answers: ["365","7","30","180"], correctAnswer: "365"),
//        Question(question: "What kind of animal was Abu in Aladdin? ", answers: ["Monkey","Lion","Elephant","Fox"], correctAnswer: "Monkey"),
//        Question(question: "How many colors are in a rainbow? 🌈", answers: ["Five","Eight","Seven","Ten"], correctAnswer: "Seven"),
//        Question(question: "Who painted the Mona Lisa? 👨🏻‍🎨", answers: ["Leonardo DaVinci","Vincent van Gogh","Michelangelo","Salvador Dalí"], correctAnswer: "Leonardo DaVinci"),
//        Question(question: "What is the seventh month of the year?", answers: ["July","January","March","August"], correctAnswer: "July"),
//        Question(question: "Which British band recorded \"Another Brick In the Wall\"?", answers: ["Pink Floyd", "The Beatles", "The Rolling Stones", "Led Zepplin"], correctAnswer: "Pink Floyd"),
//        Question(question: "In which English city is Buckingham palace located? 🏰", answers: ["London","Manchester","Birmingham","Liverpool"], correctAnswer: "London"),
//        Question(question: "In what year the industrial revolution started? 🏗", answers: ["1760","1960","1996","1320"], correctAnswer: "1760"),
//        Question(question: "What is the first letter in the Greek alphabet? 📝", answers: ["alpha", "beta", "pi","omega"], correctAnswer: "alpha")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(questionsArray.count)
        guard questionsArray.count > 0 else { return }
        configueButtons()
        view.isUserInteractionEnabled = true
        
    }
    
    func configueButtons(){
        let randomNumber = Int.random(in: 0 ..< questionsArray.count)
        currentQuestion = randomNumber
        questionLabel.text = questionsArray[randomNumber].question
        let answersArray = questionsArray[randomNumber].answers.shuffled()
        
        for (i, button) in answersButtons.enumerated(){
            button.setTitle(answersArray[i], for: .normal)
            button.layer.cornerRadius = 25
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        hintButton.layer.cornerRadius = 20
        addQuestionButton.layer.cornerRadius = 18
    }
    
    
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard questionsArray.count > 0 else { return }
        if isItCorrect(tappedAnswer: sender.title(for: .normal)!, currectAnswer: questionsArray[currentQuestion].correctAnswer){
            sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            view.isUserInteractionEnabled = false
            configureScore(correctAnswer: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.reloadGame()
            }
            
        } else{
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            configureScore(correctAnswer: false)
        }
    }
    
    func isItCorrect(tappedAnswer: String, currectAnswer: String) -> Bool{
        return tappedAnswer == currectAnswer
    }
    
    
    @IBAction func hintButtonTapped(_ sender: UIButton) {
        view.isUserInteractionEnabled = false
        for button in answersButtons{
            if isItCorrect(tappedAnswer: button.title(for: .normal) ?? "", currectAnswer: questionsArray[currentQuestion].correctAnswer){
                button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            else{
                button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
        configureScore(correctAnswer: false)
        configureScore(correctAnswer: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.reloadGame()
        }
    }
    
    func reloadGame(){
        guard self.questionsArray.count > 0 else { return }
        self.questionsArray.remove(at: self.currentQuestion)
        self.viewDidLoad()
    }
    
    func configureScore(correctAnswer: Bool){
        if correctAnswer{
            score += 1
        } else{
            score -= 1
        }
        if score < 0 { score = 0 }
        scoreLabel.text = "Score: \(score)"
    }
    
}

extension MainViewController: AddQuestionDelegate{
    func addQuestion(newQuestion: Question) {
//        questionsArray.append(newQuestion)
        print("inside View Controller, new Question is: \(newQuestion)")
    }
    
    
}
