//
//  MainViewController.swift
//  Trivia
//
//  Created by Raz on 11/04/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit



class MainViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answersButtons: [UIButton]!
    @IBOutlet weak var iDontKnowButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var missedLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    var currentQuestion: Int = -1
    var score: Int = 0
    var wrongAnswers = 0
    
    var myTimer = Timer()
    var progressBarCounter: Float = 0.0
    
    var questionsArray: [Question] = buildQuestionArray()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print(questionsArray.count)
        guard questionsArray.count > 0 else { return }
        configueButtons()
        view.isUserInteractionEnabled = true
        updateMissedLabel()
        scoreLabel.text = "Score: \(score)"
        setProgressBar()
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
        iDontKnowButton.layer.cornerRadius = 20
        addQuestionButton.layer.cornerRadius = 18
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        stopProgressBar()
        guard questionsArray.count > 0 else { return }
        progressBarCounter = 0.0
        if isItCorrect(tappedAnswer: sender.title(for: .normal)!, currectAnswer: questionsArray[currentQuestion].correctAnswer){
            sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.reloadGame()
                self.configureScore(correctAnswer: true)
            }
            
        } else{
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.wrongAnswers += 1
                self.wrongButtonTapped()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print("wrong answers: \(self.wrongAnswers)")
                self.configureScore(correctAnswer: false)
                if self.wrongAnswers < 3 {
                    self.reloadGame()
                }else{
                    self.wrongAnswers = 0
                    self.score = 0
                }
            }
        }
        
    }
    
    func isItCorrect(tappedAnswer: String, currectAnswer: String) -> Bool{
        return tappedAnswer == currectAnswer
    }
    
    func wrongButtonTapped(){
        for button in answersButtons{
            if isItCorrect(tappedAnswer: button.title(for: .normal) ?? "", currectAnswer: questionsArray[currentQuestion].correctAnswer){
                button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
        updateMissedLabel()
    }
    
    func updateMissedLabel(){
        missedLabel.text = "Missed: \(wrongAnswers)/3"
        
        if wrongAnswers == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showAlert(title: "Game Over", message: "Play Again?")
            }
        }
        
    }
    
    
    @IBAction func iDontKnowButtonTapped(_ sender: UIButton) {
        stopProgressBar()
        view.isUserInteractionEnabled = false
        for button in answersButtons{
            if isItCorrect(tappedAnswer: button.title(for: .normal) ?? "", currectAnswer: questionsArray[currentQuestion].correctAnswer){
                button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            else{
                button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.configureScore(correctAnswer: false)
            self.reloadGame()
        }
    }
    
    
    @IBAction func addQuestionButtonTapped(_ sender: UIButton) {
        stopProgressBar()
    }
    
    func reloadGame(){
        guard self.questionsArray.count > 0 else { return }
        self.questionsArray.remove(at: self.currentQuestion)
        checkEndOfQuestions()
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuestionSegue" {
            if let viewController = segue.destination as? AddQuestionViewController{
                viewController.addQuestionDelegate = self
                viewController.setProgressBarDelegate = self
            }
        }
    }
    
    func checkEndOfQuestions(){
        if questionsArray.count == 0{
            showAlert(title: "End of Questions", message: "Play again? 🙂")
        }
    }
    
    
    func showAlert(title: String, message: String){
        let alertConroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: {
            UIAlertAction in
            self.resetGame()
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            UIAlertAction in
            exit(0)
            
        })
        alertConroller.addAction(okButton)
        alertConroller.addAction(cancelButton)
        
        self.present(alertConroller, animated: true, completion: nil)
    }
    
    func resetGame(){
        questionsArray = buildQuestionArray()
        score = 0
        wrongAnswers = 0
        viewDidLoad()
    }
    
    func setProgressBar(){
        myTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            self.progressBarView.progress = self.progressBarCounter
            if Int(self.progressBarCounter) == 1 {
//                self.progressBarCounter = 0.0
//                timer.invalidate()
                self.stopProgressBar()
                self.iDontKnowButtonTapped(UIButton())
            }else{
                self.progressBarCounter += 0.001
            }
//            print(self.progressBarCounter)
        })
    }
    
    func stopProgressBar(){
        myTimer.invalidate()
        progressBarCounter = 0.0
    }
}


extension MainViewController: AddQuestionDelegate, SetProgressBarDelegate{
    func addQuestion(newQuestion: Question) {
        questionsArray.append(newQuestion)
        
    }
    
    func set() {
        setProgressBar()
    }

    
}


