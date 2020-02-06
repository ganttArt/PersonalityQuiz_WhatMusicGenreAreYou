//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Christopher Gantt on 2/5/20.
//  Copyright © 2020 Christopher Gantt. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    var questions: [Question] = [
        Question(text: "What is your volume knob set to?",
                 type: .ranged,
                 answers: [
                    Answer(text: "0", type: .jazz),
                    Answer(text: "Not Too loud", type: .songwriter),
                    Answer(text: "Some volume", type: .experimental),
                    Answer(text: "11", type: .metal)]),
        
        Question(text: "How do you listen to music",
                 type: .multiple,
                 answers: [
                    Answer(text: "With my lover", type: .songwriter),
                    Answer(text: "With a cocktail", type: .jazz),
                    Answer(text: "Beer in hand", type: .experimental),
                    Answer(text: "Head-Banging", type: .metal)]),
        
        Question(text: "Where do you play?",
                 type: .single,
                 answers: [
                    Answer(text: "Bar", type: .metal),
                    Answer(text: "Coffee Shop", type: .songwriter),
                    Answer(text: "Basement", type: .experimental),
                    Answer(text: "Swanky Party", type: .jazz)]),
        
        Question(text: "How about some Improv?",
                 type: .ranged,
                 answers: [
                    Answer(text: "No Way!", type: .metal),
                    Answer(text: "Just a little maybe", type: .songwriter),
                    Answer(text: "At least one improv solo", type: .jazz),
                    Answer(text: "More Please!", type: .experimental)]),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
            case singleButton1:
                answersChosen.append(currentAnswers[0])
            case singleButton2:
                answersChosen.append(currentAnswers[1])
            case singleButton3:
                answersChosen.append(currentAnswers[2])
            case singleButton4:
                answersChosen.append(currentAnswers[3])
            default:
                break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value *
            Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            singleStackView.isHidden = false
            updateSingleStack(using: currentAnswers)
        case .multiple:
            multipleStackView.isHidden = false
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            rangedStackView.isHidden = false
            updateRangedStack(using: currentAnswers)
            }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
}
