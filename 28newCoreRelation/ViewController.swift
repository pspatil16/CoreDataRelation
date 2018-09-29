//
//  ViewController.swift
//  28newCoreRelation
//
//  Created by Mac on 28/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = delegate.persistentContainer.viewContext
        
        //For Stud1
        let stud1:Student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        stud1.firstName = "Poonam"
        stud1.lastName = "Patil"
        stud1.age = 24
        
        let course1:Course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: context)as! Course
        course1.courseName = "Ios"
        stud1.addToCourses(course1)
        
        let stud2:Student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        stud2.firstName = "Minal"
        stud2.lastName = "Borale"
        stud2.age = 25
        
        let course2:Course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: context)as! Course
        course2.courseName = "Android"
        stud2.addToCourses(course2)
        
        //Fetch
        let fetchRequest:NSFetchRequest<Student>=Student.fetchRequest()
        let namePredicate:NSPredicate=NSPredicate(format: "firstName=%@", "Poonam")
        fetchRequest.predicate = namePredicate
        
        do{
            let searchResult = try context.fetch(fetchRequest)
            print("total counts= \(searchResult.count)")
            
            for result in searchResult as  [Student]
            {
                print("First Name:\(String(describing: result.firstName))")
                print("Last Name:\(String(describing: result.lastName))")
                print("Age:\(result.age)")
                print("Course:\(String(describing: result.courses))")
            }
            context.delete(stud2)
            print("Stud2 deleted")
            do
            {
                try context.save()
                print("Insert Success:")
                
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        
        catch{
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

