//
//  GoalsVC.swift
//  post -app
//
//  Created by Sarthak Jha  on 23/04/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit
import CoreData

//this instantiates App Delegate. this will be used for core data purpose
//it is publically declared i.e can be used in all VCs
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    var deletedGoal = Goal()
   // let goalCell = GoalCell()
   @IBOutlet weak var undoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var goals: [Goal] = []
   // var deletedGoals: [Goal] = []
    var GIndexpath = IndexPath()
    override func viewWillAppear(_ animated: Bool) {
        
        fetchData { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                    
                } else {
                    tableView.isHidden = true
                }
            }
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        undoView.isHidden = true
        //  let goal = Goal()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let createGoalVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC") {
            presentDetail(createGoalVC)
        }
        else {
            
            return
        }
        
    }
//  //  @IBAction func undoButtonPressed(_ sender: UIButton) {
//      resaveDataAfterUndo()
//        fetchData { (complete) in
//            if complete {
//                if goals.count >= 1 {
//                    tableView.isHidden = false
//
//                } else {
//                    tableView.isHidden = true
//                }
//            }
//        }
//        tableView.reloadData()
//        print("------------------------------------")
//        print(goals)
//        print("------------------------------------")
//        print(" ")
//
//        print(" ")
//
//
//    }
    
}

extension GoalsVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell {
            let goal = goals[indexPath.row]
            cell.configureCell(goal: goal)
            //to access enum use .longTerm or .shortTerm
            return cell
        } else {
            return GoalCell()
        }
        }
            
            
        
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.GIndexpath = indexPath
            self.deletedGoal = self.goals[indexPath.row]
            self.deleteGoal(indexPath: indexPath)
            self.fetchData { (complete) in
                if complete {
                    if self.goals.count >= 1 {
                        tableView.isHidden = false
                        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                        print(self.goals)
                        print("+++++++++++++++++++++++++++++++++++")
                    } else {
                        tableView.isHidden = true
                    }
                }
                tableView.deleteRows(at: [indexPath], with: .automatic)
//self.undoView.isHidden = false
            }}
        let addAction = UITableViewRowAction(style: .normal, title: "Add 1") { (rowAction, indexPath) in
            self.setProgress(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return [deleteAction,addAction]
    }
}

extension GoalsVC {

    func setProgress(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let goal = goals[indexPath.row]
        if goal.goalCompletionValue > goal.goalProgress {
            goal.goalProgress += 1
            print("goal progress added! ")
        } else {
            return
        }
        do {
            try managedContext.save()
            print("goal progress saved! ")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    func deleteGoal(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
               print(deletedGoal)
        print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
        managedContext.delete(goals[indexPath.row])
        do{
            try managedContext.save()
            print("successfully removed goal. ")
        } catch{
            print("goal remove error.")
            print(error.localizedDescription)
        }
        
    }
    func fetchData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")   //inside <> is VERY IMPORTANT
        do{
            goals = try managedContext.fetch(fetchRequest)
            print("data fetched.")
            completion(true)
            
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
        
    }
    func resaveDataAfterUndo() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        var goal = Goal(context: managedContext)
        goal = deletedGoal
//        goal.goalDescription = deletedGoal.goalDescription
//        goal.goalType = deletedGoal.goalType
//        goal.goalProgress = deletedGoal.goalProgress
//        goal.goalCompletionValue = deletedGoal.goalCompletionValue
        do {
            try managedContext.save()
            print("data is resaved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
