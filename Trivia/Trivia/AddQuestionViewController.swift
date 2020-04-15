//
//  AddQuestionViewController.swift
//  Trivia
//
//  Created by Raz on 11/04/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit

protocol AddQuestionDelegate {
    func addQuestion(newQuestion: Question)
}

protocol SetProgressBarDelegate {
    func set()
}


class AddQuestionViewController: UIViewController {
    
    var addQuestionDelegate: AddQuestionDelegate!
    var setProgressBarDelegate: SetProgressBarDelegate!
    
    //    let mainViewControllerSegue = "MainViewControllerSegue"
    var newQuestion: Question?
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var cancelButtonButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        sendButton.layer.cornerRadius = 20
        cancelButtonButton.layer.cornerRadius = 20
    }
    
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        if isAnyOfFieldsEmpty() {
            showAlert(title: "Empty Fields", message: "Please fill in all fields")
        }else{
            guard let userQuestion = questionTextField.text else { return }
            let userAnswerArray: [String] = [answer1TextField.text ?? "", answer2TextField.text ?? "", answer3TextField.text ?? "", answer4TextField.text ?? ""]
            guard let userCorrectAnswer = answer1TextField.text else { return }
            
            newQuestion = Question(question: userQuestion, answers: userAnswerArray, correctAnswer: userCorrectAnswer)
            guard newQuestion != nil else { return }
            addQuestionDelegate.addQuestion(newQuestion: newQuestion!)
            setProgressBarDelegate.set()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func isAnyOfFieldsEmpty() -> Bool{
        return questionTextField.text == "" || answer1TextField.text == "" || answer2TextField.text == "" || answer3TextField.text == "" || answer4TextField.text == ""
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        setProgressBarDelegate.set()
    }
    
    func showAlert(title: String, message: String){
        let alertConroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: {
            UIAlertAction in
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
            self.setProgressBarDelegate.set()
            
        })
        alertConroller.addAction(okButton)
        alertConroller.addAction(cancelButton)
        
        self.present(alertConroller, animated: true, completion: nil)
    }
    
    
}





extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
