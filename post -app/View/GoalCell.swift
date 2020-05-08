//
//  GoalCell.swift
//  post -app
//
//  Created by Sarthak Jha  on 23/04/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
   let goalsVC = GoalsVC()
    
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    var goalIsCompleted: Bool = false
    func configureCell(goal:Goal) {
        self.goalDescriptionLabel.text = goal.goalDescription
        self.goalProgressLabel.text = String(goal.goalProgress)
        self.goalTypeLabel.text = goal.goalType         //raw value is value in ""
        
        if goal.goalProgress == goal.goalCompletionValue {
            completionView.isHidden = false
//calling commented function below causes crash (index out of range)
            
           // deleteGoalAfterCompletion(arrayIndex: goalsVC.GIndexpath)
            
        } else {
            completionView.isHidden = true
        }
    }
    
    //calling function below causes crash (index out of range)
    func deleteGoalAfterCompletion(arrayIndex: Int) {
    guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goalsVC.goals[arrayIndex])
        do{
            try managedContext.save()
        } catch {
            print("couldnt delete this fuck :- \(error.localizedDescription)")
        }
        

    }
}
