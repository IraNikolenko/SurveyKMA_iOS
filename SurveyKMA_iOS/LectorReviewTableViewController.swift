//
//  LectorReviewTableViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 27.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class LectorReviewTableCell: UITableViewCell{
    
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UITextView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
}

class LectorReviewTableViewController: UITableViewController {

    var news = [LectorReview]()
    var ref: FIRDatabaseReference!
    var images = [UIImage?]()
    
    var currentLectorName: String!
    var strings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.backgroundColor = UIColor.white

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectorReviewCell", for: indexPath) as! LectorReviewTableCell

        cell.selectionStyle = .none
        
        let new = news[indexPath.row]
        
        print(new.date)
        
        cell.dateLabel.text = new.date
        cell.reviewText.text = new.text
        
        self.ref = FIRDatabase.database().reference()
        
        self.ref.child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.key == new.userID){
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    let new = User()
                    new.setValuesForKeys(dictionary)
                    DispatchQueue.main.async(execute: {
                        cell.userName.text = new.name
                    })
                }}} ,withCancel: nil)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailReviewLectorViewController") as! DetailReviewLectorViewController
        
        let reviewToPresent = news[indexPath.row]
        
        //controller.courseKey = self.coursesKeys[indexPath.row]
        controller.currentReview = reviewToPresent
        controller.lectorname = currentLectorName
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
