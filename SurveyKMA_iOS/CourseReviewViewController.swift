//
//  CourseReviewViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 25.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class CourseReviewViewController: UIViewController {

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var aboutCourse: UITextView!
    @IBOutlet weak var creditsAndHours: UILabel!
    
    var courseKey: String?
    var ref: FIRDatabaseReference!
    var reviews = [CourseReview]()
    var lectors = [Lector]()
    var lectorKeys = [String]()
    var currentCourse: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        UINavigationBar.appearance().tintColor = .white
        navigationItem.title = "Reviews"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .plain, target: self, action: #selector(LectorReviewViewController.addReview))
        
        if(currentCourse == nil){
            currentCourse = Course()
        currentCourse?.about = "Сучасні методи розробки програмного забезпечення, здатного налаштовуватися на нові умови і вимоги, що виникають під час його експлуатації. Розробка обґрунтованої ієрархії класів і об'єктів, визначення методів класу і службових функцій, обґрунтування інтерфейсу та його розмежування з реалізацією. Важливим аспектом ієрархії слугує обґрунтування співвідношення між агрегацією і успадкуванням, зокрема розмежування успадкування інтерфейсу й успадкування реалізації. Віртуальні функції і різні методи реалізації поліморфізму. Типові патерни проектування та інші засоби підвищення надійності програмного коду. Вивчення курсу супроводжується розробкою навчальних програмних проектів."
        currentCourse?.credits = 4.5
        currentCourse?.hours = 150
        currentCourse?.name = "Методи об`єктно-орієнтованого програмування"
        let lect = NSArray()
        lect.adding(Lector())
        currentCourse?.teachers = lect
        }
        courseName.text = currentCourse?.name
        aboutCourse.text = currentCourse?.about
        creditsAndHours.text = "credits: " + (currentCourse?.credits?.stringValue)!  + "; hours: " + (currentCourse?.hours?.stringValue)!
        
    }
    
    func addReview() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewCourseReviewViewController") as! NewCourseReviewViewController
        
        controller.currentCourseName = (self.currentCourse?.name!)!
        controller.courseKey = self.courseKey
        
        navigationController?.pushViewController(controller, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CourseReviewsSegue" {
            
            let coursesReviewTableController = segue.destination as? ReviewsTableViewController
        
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("reviews").child("courses").child(self.courseKey!).observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let new = CourseReview()
                        new.setValuesForKeys(dictionary)
                        self.reviews.append(new)
                        coursesReviewTableController?.news = self.reviews
                        coursesReviewTableController?.tableView.reloadData()
                    }} ,withCancel: nil)
            })
        }
        if segue.identifier == "LectorsSegue" {
            
            let lectorsCollectionView = segue.destination as? LectorsCollectionViewController
            
            let a:Int
            a = ((self.currentCourse?.teachers?.count)!-1)
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                for i in 0...a{
                self.ref.child("teachers").child("301").observe(.childAdded, with: { (snapshot) in
                    if (snapshot.key == self.currentCourse?.teachers?[i] as! String){
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let new = Lector()
                        new.setValuesForKeys(dictionary)
                        self.lectors.append(new)
                        self.lectorKeys.append(self.currentCourse?.teachers?[i] as! String)
                        lectorsCollectionView?.lectorKeys = self.lectorKeys
                        lectorsCollectionView?.lectors.append(new)
                        lectorsCollectionView?.collectionView?.reloadData()
                        }}} ,withCancel: nil)
                }})
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
