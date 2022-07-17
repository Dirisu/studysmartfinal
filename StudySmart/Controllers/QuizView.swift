//
//  QuizView.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import UIKit
import FirebaseAuth

class QuizView : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var gameModels = [Question]()
    var currentQuestion : Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        table.delegate =  self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question) {
        titleLabel.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: { $0.text == answer.text}) && answer.correct
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question) {
            
            // correct
            if let index = gameModels.firstIndex(where: {$0.text == question.text}) {
                
                showAlert(message: "Right", title: "Answer Correct")
                
                if index < (gameModels.count - 1) {
                    
                    let nextQuestion = gameModels[index + 1]
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                    
                } else {
                    
                    showAlert(message: "Done", title: "Congrats")
                }
            }
        } else {
            
            showAlert(message: "Wrong", title: "Incorrect Answer")
        }
    }
    
    func showAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    // Questions section
    private func setupQuestions() {
        gameModels.append(Question(text: "How many types of integers are in Swift?", answers: [
                Answer(text: "2", correct: false),
                Answer(text: "3", correct: true),
                Answer(text: "1", correct: false),
                Answer(text: "4", correct: false)
        ]))
        
        gameModels.append(Question(text: "What are the disadvantages of Swift?", answers: [
                Answer(text: "Poor interoperability with third-party tools and IDEs", correct: false),
                Answer(text: "Lack of support for earlier iOS versions", correct: false),
                Answer(text: "Both of these", correct: true),
                Answer(text: "None of the above", correct: false)
        ]))
        
        gameModels.append(Question(text: "Numbers with decimal values or fractional components are called?", answers: [
                Answer(text: "Decimal number", correct: false),
                Answer(text: "Integer number", correct: false),
                Answer(text: "Fractions", correct: false),
                Answer(text: "Floating numbers", correct: true)
        ]))
        
        gameModels.append(Question(text: "What statement can be used to stop the execution of a loop, if, or switch statement?", answers: [
                Answer(text: "Break", correct: true),
                Answer(text: "Stop", correct: false),
                Answer(text: "Execute", correct: false),
                Answer(text: "Block", correct: false)
        ]))
        
        gameModels.append(Question(text: "What does the question mark (?) indicate A particular property is", answers: [
                Answer(text: "Necessary", correct: false),
                Answer(text: "Question", correct: false),
                Answer(text: "Optional", correct: true),
                Answer(text: "Maybe", correct: false)
        ]))
        
        gameModels.append(Question(text: "What are the features of Swift Programming?", answers: [
                Answer(text: "Arrays and integers are checked for overflow", correct: false),
                Answer(text: "Switch function can be used instead of using “if” statement", correct: false),
                Answer(text: "It eliminates the classes that are in an unsafe mode", correct: false),
                Answer(text: "All of the above", correct: true)
        ]))
        
        gameModels.append(Question(text: "What Is Bundle In IOS", answers: [
                Answer(text: "It Is Folder With .app Extension", correct: true),
                Answer(text: "It Is A Class", correct: false),
                Answer(text: "It Is Used To Send Data", correct: false),
                Answer(text: "All of the above", correct: false)
        ]))
        
        gameModels.append(Question(text: "What are the advantages of Swift?", answers: [
                Answer(text: "Swift is fast", correct: false),
                Answer(text: "Swift is safe", correct: false),
                Answer(text: "Swift is an open source", correct: false),
                Answer(text: "All of the above", correct: true)
        ]))
        
        gameModels.append(Question(text: "We Can Return Multiple Values In Swift From Function By Using?", answers: [
                Answer(text: "Array", correct: false),
                Answer(text: "Tuple", correct: true),
                Answer(text: "Void", correct: false),
                Answer(text: "Return", correct: false)
        ]))
        
        gameModels.append(Question(text: "Which Of The Following Is Incorrect Data Type In SWIFT ?", answers: [
                Answer(text: "Var", correct: false),
                Answer(text: "Char", correct: true),
                Answer(text: "Double", correct: false),
                Answer(text: "Int", correct: false)
        ]))
        
        gameModels.append(Question(text: "IOS stands for?" , answers: [
                Answer(text: "Internetwork Operating System", correct: false),
                Answer(text: "IPhone Operating System", correct: true),
                Answer(text: "Internet Operating System", correct: false),
                Answer(text: "None Of Them", correct: false)
        ]))

        gameModels.append(Question(text: "What IDE is used in Swift" , answers: [
                Answer(text: "Swiftc", correct: false),
                Answer(text: "Gas", correct: false),
                Answer(text: "Xcode", correct: true),
                Answer(text: "VSCode" , correct: false)
        ]))

        gameModels.append(Question(text: "What is used to create mutable objects" , answers: [
                Answer(text: "Let", correct: false),
                Answer(text: "Var", correct: true),
                Answer(text: "Const", correct: false),
                Answer(text: "Mut" , correct: false)
        ]))

        gameModels.append(Question(text: "What is used to create constants" , answers: [
                Answer(text: "Let", correct: true),
                Answer(text: "Var", correct: false),
                Answer(text: "Const", correct: false),
                Answer(text: "Mut" , correct: false)
        ]))

        gameModels.append(Question(text: "Which of the following is incorrect Value Type in SWIFT?", answers: [
                Answer(text: "Double", correct: false),
                Answer(text: "Character", correct: false),
                Answer(text: "Enum", correct: false),
                Answer(text: "Class", correct: true)
        ]))

        gameModels.append(Question(text: "First IOS was written in?" , answers: [
                Answer(text: "1874", correct: false),
                Answer(text: "1986", correct: true),
                Answer(text: "1886", correct: false),
                Answer(text: "1974", correct: false)
        ]))

        gameModels.append(Question(text: "Swift is which kind of language?" , answers: [
                Answer(text: "Type safe language", correct: false),
                Answer(text: "Scripting language", correct: false),
                Answer(text: "Object oriented programming language", correct: false),
                Answer(text: "All of the above", correct: true)
        ]))

        gameModels.append(Question(text: "...... keyword in swift used to initialize the variable?" , answers: [
                Answer(text: "nil", correct: true),
                Answer(text: "null", correct: false),
                Answer(text: "NIL", correct: false),
                Answer(text: "NULL", correct: false)
        ]))

        gameModels.append(Question(text: "Which of the following framework is not used in IOS?" , answers: [
                Answer(text: "Foundation Framework", correct: false),
                Answer(text: "AppKit Framework", correct: true),
                Answer(text: "UIKit Framework", correct: false),
                Answer(text: "CoreMotion Framework", correct: false)
        ]))


        gameModels.append(Question(text: "What are the features of Swift Programming?" , answers: [
                Answer(text: "Variables are always initialized before use", correct: false),
                Answer(text: "It eliminates entire classes of unsafe code", correct: false),
                Answer(text: "Arrays and integers are checked for overflow", correct: false),
                Answer(text: "All of the above", correct: true)
        ]))

    }
    
}
