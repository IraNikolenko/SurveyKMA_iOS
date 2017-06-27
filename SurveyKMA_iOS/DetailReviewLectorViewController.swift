//
//  DeatilReviewLectorViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 27.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Cosmos

class DetailReviewLectorViewController: UIViewController {

    @IBOutlet weak var lectorName: UILabel!
    @IBOutlet weak var competency: CosmosView!
    @IBOutlet weak var justice: CosmosView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var quality: CosmosView!
    
    var currentReview : LectorReview!
    var lectorname: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lectorName.text = lectorname
        competency.rating = currentReview.competency as! Double
        competency.settings.updateOnTouch = false
        justice.rating = currentReview.justiceAssessment as! Double
        justice.settings.updateOnTouch = false
        reviewText.text = currentReview.text
        quality.rating = currentReview.qualityOfTeaching as! Double
        quality.settings.updateOnTouch = false
        
        // Do any additional setup after loading the view.
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
