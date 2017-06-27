//
//  NewLectorReviewViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 27.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class NewLectorReviewViewController: UIViewController {

    @IBOutlet weak var competency: CosmosView!
    @IBOutlet weak var justiceAssessment: CosmosView!
    @IBOutlet weak var lectorName: UILabel!
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var qualityOfTeaching: CosmosView!
    @IBOutlet weak var addButton: UIButton!
    
    var currentLector = String()
    
    let newLector = LectorReview()
    var ref: FIRDatabaseReference!
    var lectorKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.addTarget(self, action: #selector(setupComplete), for: .touchUpInside)
        lectorName.text = currentLector
        
        self.navigationItem.title = "ДОДАЙТЕ НОВИЙ ВІДГУК"
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
        
        self.newLector.userID = FIRAuth.auth()?.currentUser?.uid
        newLector.competency = competency.rating as NSNumber
        newLector.date = currentDate
        newLector.justiceAssessment = justiceAssessment.rating as NSNumber
        newLector.qualityOfTeaching = qualityOfTeaching.rating as NSNumber
        newLector.text = reviewText.text
    
        let values:[String:Any] = ["competency":newLector.competency!, "date":newLector.date!, "justiceAssessment":newLector.justiceAssessment!,"qualityOfTeaching":newLector.qualityOfTeaching!, "text":newLector.text!, "userID":self.newLector.userID!]
            
            self.addNewIntoDatabase(values: values)
        
    }
    
    private func addNewIntoDatabase(values:[String:Any]){
        
        let ref = FIRDatabase.database().reference().child("reviews").child("teachers").child(lectorKey)
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
