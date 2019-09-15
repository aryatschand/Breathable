//
//  QuizViewController.swift
//  iOS Swift App
//
//  Created by Arya Tschand on 9/14/19.
//  Copyright © 2019 PEC. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var questions: [String] = ["What's your name?", "How old are you"]
    var questionNumber = 0
    var AnsOne: [String] = ["Arya", "17"]
    var AnsTwo: [String] = ["Lyndon", "18"]
    var AnsThree: [String] = ["Josh", "16"]
    var AnsFour: [String] = ["Varun", "15"]
    var answers: [Int] = [1, 3]
    var right: Int = 0
    
    @IBOutlet weak var questionlabel: UILabel!
    
    @IBOutlet weak var One: UIButton!
    
    @IBOutlet weak var Two: UIButton!
    
    @IBOutlet weak var Three: UIButton!
    
    @IBOutlet weak var Four: UIButton!
    
    @IBOutlet weak var reset: UIButton!
    
    @IBAction func Reset(_ sender: Any) {
        reset.isEnabled = false
        reset.isHidden = true
        questionNumber = 0
        One.isHidden = false
        Two.isHidden = false
        Three.isHidden = false
        Four.isHidden = false
        One.isEnabled = true
        Two.isEnabled = true
        Three.isEnabled = true
        Four.isEnabled = true
        update(number: questionNumber)
    }
    
    var alertController: UIAlertController?
    var alertTimer: Timer?
    var remainingTime = 0
    var baseMessage: String?
    
    @IBAction func OneClick(_ sender: Any) {
        if answers[questionNumber] == 1 {
            giveAlert(correct: true)
            right += 1
        } else {
            giveAlert(correct: false)
        }
        questionNumber += 1
        update(number: questionNumber)
    }
    
    @IBAction func TwoClick(_ sender: Any) {
        if answers[questionNumber] == 2 {
            giveAlert(correct: true)
            right += 1
        } else {
            giveAlert(correct: false)
        }
        questionNumber += 1
        update(number: questionNumber)
    }
    
    @IBAction func ThreeClick(_ sender: Any) {
        if answers[questionNumber] == 3 {
            giveAlert(correct: true)
            right += 1
        } else {
            giveAlert(correct: false)
        }
        questionNumber += 1
        update(number: questionNumber)
    }
    
    @IBAction func FourClick(_ sender: Any) {
        if answers[questionNumber] == 4 {
            giveAlert(correct: true)
            right += 1
        } else {
            giveAlert(correct: false)
        }
        questionNumber += 1
        update(number: questionNumber)
    }
    
    func update(number: Int) {
        if questions.count > questionNumber {
            questionlabel.text = questions[number]
            One.setTitle(AnsOne[number], for: .normal)
            Two.setTitle(AnsTwo[number], for: .normal)
            Three.setTitle(AnsThree[number], for: .normal)
            Four.setTitle(AnsFour[number], for: .normal)
        } else {
            One.isHidden = true
            Two.isHidden = true
            Three.isHidden = true
            Four.isHidden = true
            One.isEnabled = false
            Two.isEnabled = false
            Three.isEnabled = false
            Four.isEnabled = false
            questionlabel.text = "Score = \(right)/5. Reset to try again"
            reset.isEnabled = true
            reset.isHidden = false
            right = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update(number: questionNumber)
        reset.isEnabled = false
        reset.isHidden = true
    }
    
    func giveAlert (correct: Bool) {
        if correct == true {
            let alert = UIAlertController(title: "Correct!", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Continue", style: .cancel) { (action) in
            }
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Incorrect!", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Continue", style: .cancel) { (action) in
            }
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
