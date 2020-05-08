//
//  CreateGoalVC.swift
//  post -app
//
//  Created by Sarthak Jha  on 24/04/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController,UITextViewDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .ShortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortTermButton.buttonSelectedColor()
        longTermButton.unselectedButton()
        goalTextView.delegate = self
        
         // Do any additional setup after loading the view.
    }
    
    @IBAction func backbuttonPressed(_ sender: UIButton) {
        dismissDetail()
    }
    @IBAction func longTermButtonPressed(_ sender: UIButton) {
        goalType = .longTerm
        longTermButton.buttonSelectedColor()
        shortTermButton.unselectedButton()
        
    }
    @IBAction func shortTermButtonPressed(_ sender: UIButton) {
        goalType = .ShortTerm
        shortTermButton.buttonSelectedColor()
        longTermButton.unselectedButton()
        

    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if goalTextView.text != "" && goalTextView.text != "What's your Goal ?" {
            if let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC{
                finishGoalVC.initData(description: goalTextView.text, type: goalType)
                presentDetail(finishGoalVC)
                
            } else {
//                let alertController = UIAlertController(title: "empty text field", message:
//                               "enter your goal to continue", preferredStyle: UIAlertController.Style.alert)
//                           alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
//                self.present(alertController, animated: true, completion: nil)
//                print("beep")
                
                //above code not displaying
                return
            }
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
   
    
   

}
