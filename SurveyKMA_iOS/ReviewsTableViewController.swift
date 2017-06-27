//
//  TableViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 25.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class ReviewTableCell: UITableViewCell {
    
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userName: UITextView!
    @IBOutlet weak var userPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
}


class ReviewsTableViewController: UITableViewController {

    var news = [CourseReview]()
    var ref: FIRDatabaseReference!
    var images = [UIImage?]()
    
    var strings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ReviewTableCell
        
        cell.selectionStyle = .none
        
        let new = news[indexPath.row]
        
        cell.dateLabel.text = new.date
        cell.reviewText.text = new.text
        
        self.ref = FIRDatabase.database().reference()
        
        self.ref.child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.key == new.userID){
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    let new = User()
                    print(dictionary)
                    new.setValuesForKeys(dictionary)
                    DispatchQueue.main.async(execute: {
                        cell.userName.text = new.name
                    })
                }}} ,withCancel: nil)
        
        //cell.userName.text = new.userID
        
        // Configure the cell...

        return cell
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
