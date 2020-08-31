//
//  TeamInformationViewController.swift
//  TBG2
//
//  Created by Kris Reid on 27/02/2020.
//  Copyright © 2020 Kris Reid. All rights reserved.
//

import UIKit
import CoreData

class TeamInformationViewController: UIViewController {
    
    @IBOutlet weak var tfSubs: UITextField!
    @IBOutlet weak var lblSubs: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    @IBAction func subsSavedTapped(_ sender: Any) {
        let subs = Double(tfSubs.text ?? "0.0")!
        save(subs: subs)
    }
    
    func save(subs: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: context)!
        let object = NSManagedObject(entity: entity, insertInto: context)
        
        object.setValue(subs, forKeyPath: "subs")

        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func subsStoredCheckTapped(_ sender: Any) {
        getData()
    }
    
    func getData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let subsDouble = result.value(forKey: "subs") as! Double
                    let subsString = String(format: "%.1f", subsDouble)
                    lblSubs.text = subsString
                }
            } else {
                print("No results")
            }
            
        } catch {
            print("Couldn't fetch results")
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                    do {
                        try context.save()
                        
                    } catch {
                        print("delete failed")
                    }
                }
            } else {
                print("No results")
            }
            
        } catch {
            print("Couldn't fetch results")
        }
    }

}
