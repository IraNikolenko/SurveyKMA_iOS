//
//  NewCourseReviewViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 27.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class NewCourseReviewViewController: UIViewController {

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var difficulty: CosmosView!
    @IBOutlet weak var interest: CosmosView!
    @IBOutlet weak var usefulness: CosmosView!
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var currentCourseName = String()
    var courseKey: String!
    
    let newCourse = CourseReview()
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.addTarget(self, action: #selector(setupComplete), for: .touchUpInside)
        courseName.text = currentCourseName
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupComplete(){
        
        if(reviewText.text == nil || reviewText.text == ""){
            let alert = UIAlertController(title: "Validate", message: "Будь ласка, напишіть відгук!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //get current date
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        let currentDate = formatter.string(from: date)
        
        ref = FIRDatabase.database().reference()
        
        
        
        newCourse.userID = FIRAuth.auth()?.currentUser?.uid
        newCourse.difficulty = difficulty.rating as NSNumber
        newCourse.date = currentDate
        newCourse.interest = interest.rating as NSNumber
        newCourse.usefulness = usefulness.rating as NSNumber
        newCourse.text = reviewText.text
        
        let values:[String:Any] = ["usefulness":newCourse.usefulness!, "date":newCourse.date!, "difficulty":newCourse.difficulty!,"interest":newCourse.interest!, "text":newCourse.text!, "userID":self.newCourse.userID!]
        
        self.addNewIntoDatabase(values: values)
        
    }
    
    private func addNewIntoDatabase(values:[String:Any]){
        
        let ref = FIRDatabase.database().reference().child("reviews").child("courses").child(courseKey)
        let childRef = ref.childByAutoId()
        childRef.updateChildValues(values)
        
        navigationController?.popViewController(animated: true)
        
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
