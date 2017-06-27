//
//  MainScreenViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 25.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class MainScreenViewController: UIViewController {

    var ref: FIRDatabaseReference!
    var courses = [Course]()
    var coursesKeys = [String]()
    var lectors = [Lector]()
    var lectorKeys = [String]()
    var faculties = [Faculty]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(MainScreenViewController.handleLogout))
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func handleLogout() {
        
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError {
            print(logoutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CourseSegue" {
            
            let coursesCollectionViewController = segue.destination as? CoursesCollectionViewController
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("courses").child("301").observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let new = Course()
                        var key = String()
                        key = snapshot.key
                        self.coursesKeys.append(key)
                        new.setValuesForKeys(dictionary)
                        self.courses.append(new)
                        coursesCollectionViewController?.courses = self.courses
                        coursesCollectionViewController?.coursesKeys = self.coursesKeys
                        coursesCollectionViewController?.collectionView?.reloadData()
                    }} ,withCancel: nil)
            })
        }
        
        if segue.identifier == "LectorSegueFromMain" {
            
            let lectorsCollectionViewController = segue.destination as? LectorsCollectionViewController
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("teachers").child("301").observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let lector = Lector()
                        var key = String()
                        key = snapshot.key
                        lector.setValuesForKeys(dictionary)
                        self.lectors.append(lector)
                        self.lectorKeys.append(key)
                        lectorsCollectionViewController?.lectors = self.lectors
                        lectorsCollectionViewController?.lectorKeys = self.lectorKeys
                        lectorsCollectionViewController?.collectionView?.reloadData()
                    }} ,withCancel: nil)
            })
        }
        
        if segue.identifier == "FacultySegueFromMain" {
            
            let facultiesCollectionViewController = segue.destination as? FacultyCollectionViewController
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("faculties").observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let faculty = Faculty()
                        print(dictionary)
                        faculty.setValuesForKeys(dictionary)
                        self.faculties.append(faculty)
                        facultiesCollectionViewController?.faculties = self.faculties
                        facultiesCollectionViewController?.collectionView?.reloadData()
                    }} ,withCancel: nil)
            })
        }
        
    }
    

}
