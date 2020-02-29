//
//  FirstViewController.swift
//  Convert
//
//  Created by Nishanthan Baskaran on 2/29/20.
//  Copyright © 2020 Nishanthan Baskaran. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    
    var pay: Double = 0
    var noOfYe: Int = 0
    var intresRate: Double = 0
    var loanAmm: Double = 0
    
    @IBOutlet weak var payment: UITextField!
    
    @IBOutlet weak var noOyYears: UITextField!
    
    @IBOutlet weak var intrestRate: UITextField!
    
    
    @IBOutlet weak var loanAmmount: UITextField!
    
    
    let appDelegate: AppDelegate? = nil
//    let context
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

getAllMortages()
        
    }
    
    
    
    func saveNewMortage(payment: Double, noOfYears: Int, loanAmmount: Double, intrestRate: Double) -> Bool  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Mortage", in: context)
        let newMortage = NSManagedObject(entity: entity!, insertInto: context)
        
        newMortage.setValue(payment, forKey: "payment")
        newMortage.setValue(noOfYears, forKey: "noOfYears")
        newMortage.setValue(loanAmmount, forKey: "loanAmmount")
        newMortage.setValue(intrestRate, forKey: "intrestRate")

        do {
            try context.save()
            return true
        } catch {
            print("Faild to save")
            return false
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        pay = Double(payment.text!) ?? 0
        noOfYe = Int(noOyYears.text!) ?? 0
        intresRate = Double(intrestRate.text!) ?? 0
        loanAmm = Double(loanAmmount.text!) ?? 0
        
        if (saveNewMortage(payment: pay, noOfYears: noOfYe, loanAmmount: loanAmm , intrestRate: intresRate)) {
            print("Saved Success")
        } else {
            print("Not Success")
        }
    }
    
    func getAllMortages() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Mortage")

        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "loanAmmount") as! Double)
                print(data.value(forKey: "payment") as! Double)
                print(data.value(forKey: "noOfYears") as! Int)
                print(data.value(forKey: "intrestRate") as! Double)
          }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    @IBAction func historyBtnPress(_ sender: Any) {
        getAllMortages()
    }
    
}

