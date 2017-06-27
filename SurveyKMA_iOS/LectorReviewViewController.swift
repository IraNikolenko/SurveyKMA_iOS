//
//  LectorReviewViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 27.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class LectorReviewViewController: UIViewController {

    @IBOutlet weak var lectorName: UITextView!
    @IBOutlet weak var lectorAbout: UITextView!
    
    var lectorKey: String?
    var ref: FIRDatabaseReference!
    var reviews = [LectorReview]()
    var courses = [Course]()
    var coursesKeys = [String]()
    var currentLector: Lector?
    var department: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        UINavigationBar.appearance().tintColor = .white
        navigationItem.title = "Reviews"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .plain, target: self, action: #selector(LectorReviewViewController.addReview))
        
        lectorName.text = currentLector?.name
        lectorAbout.text = currentLector?.about
        
    }

    func addReview() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewLectorReviewViewController") as! NewLectorReviewViewController
        
        controller.currentLector = (self.currentLector?.name!)!
        controller.lectorKey = self.lectorKey
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviewsSegueFromLectorReview" {
            
            let coursesReviewTableController = segue.destination as? LectorReviewTableViewController
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("reviews").child("teachers").child(self.lectorKey!).observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let new = LectorReview()
                        new.setValuesForKeys(dictionary)
                        self.reviews.append(new)
                        coursesReviewTableController?.news = self.reviews
                        coursesReviewTableController?.currentLectorName = self.currentLector?.name
                        coursesReviewTableController?.tableView.reloadData()
                    }} ,withCancel: nil)
            })
        }
        
        if segue.identifier == "CoursesSegueFromLectorReview" {
            
            let coursesCollectionViewController = segue.destination as? CoursesCollectionViewController
            
            let a:Int
            a = ((self.currentLector?.courses?.count)!-1)
            
            
            
            DispatchQueue.main.async(execute: {
                self.ref = FIRDatabase.database().reference()
                for i in 0...a{
                self.ref.child("courses").child("301").observe(.childAdded, with: { (snapshot) in
                    if (snapshot.key == self.currentLector?.courses?[i] as! String){
                    if let dictionary = snapshot.value as? [String:AnyObject] {
                        let new = Course()
                        new.setValuesForKeys(dictionary)
                        self.courses.append(new)
                        self.coursesKeys.append(self.currentLector?.courses?[i] as! String)
                        coursesCollectionViewController?.coursesKeys = self.coursesKeys
                        coursesCollectionViewController?.courses = self.courses
                        coursesCollectionViewController?.collectionView?.reloadData()
                        }}} ,withCancel: nil)
                }})
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
