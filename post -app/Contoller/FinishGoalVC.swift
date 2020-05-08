//
//  FinishGoalVC.swift
//  post -app
//
//  Created by Sarthak Jha  on 27/04/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit
import CoreData
class FinishGoalVC: UIViewController {
    
    var goalDescription: String!
    var goalType: GoalType!
    
    
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.text = ""
        pointsTextField.placeholder = "0"
        
    }
    func initData(description: String, type:GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    @IBAction func createGoalButtonPressed(_ sender: UIButton) {
        if pointsTextField.text != "" {
            self.saveDataToCore { (finished) in
                if finished{
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    //dismisses to root view controller
                } else {
                    return
                }
            }
        }
        
    }
    @IBAction func finishBackButtonPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    func saveDataToCore(completion: ( _ finished: Bool) -> Void ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext) //instantiating core data object
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("data is saved. ")
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            print("data could'nt be saved. ")
            completion(false)
        }
    }
}

 
