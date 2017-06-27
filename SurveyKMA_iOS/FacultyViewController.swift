//
//  FacultyViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 27.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class FacultyViewController: UIViewController {
    @IBOutlet weak var facultyName: UILabel!
    @IBOutlet weak var facultyImage: UIImageView!
    @IBOutlet weak var facultyAbout: UITextView!

    var ref: FIRDatabaseReference!
    var courses = [Course]()
    var lectors = [Lector]()
    var currentFaculty = Faculty()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        facultyName.text = currentFaculty.name
        facultyAbout.text = currentFaculty.about
        
        if let newImageURL = currentFaculty.img {
            let url = URL(string: newImageURL)
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    //let im = UIImage(data: data!)
                    //self.images.append(im)
                    self.facultyImage.image = UIImage(data: data!)
                })
                
            }).resume()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CoursesFromFaculty" {
            
            let coursesCollectionViewController = segue.destination as? CoursesCollectionViewController
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("courses").child("301").observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let new = Course()
                        new.setValuesForKeys(dictionary)
                        self.courses.append(new)
                        coursesCollectionViewController?.courses = self.courses
                        coursesCollectionViewController?.collectionView?.reloadData()
                    }} ,withCancel: nil)
            })
        }
        
        if segue.identifier == "LectorsSugueFromFaculty" {
            
            let lectorsCollectionViewController = segue.destination as? LectorsCollectionViewController
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("teachers").child("301").observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let lector = Lector()
                        lector.setValuesForKeys(dictionary)
                        self.lectors.append(lector)
                        lectorsCollectionViewController?.lectors = self.lectors
                        lectorsCollectionViewController?.collectionView?.reloadData()
                    }} ,withCancel: nil)
            })
        }
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
