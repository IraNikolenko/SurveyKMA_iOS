//
//  ViewController.swift
//  KMALife
//
//  Created by 1  on 2/2/17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class CourseReviewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UITextView!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var reviewDate: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    func setupViews(){
        
        backgroundColor = .white

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CoursesReviewTableController: UITableViewController {
    
    let cellId = "courseReviewCell"
    var news = [CourseReview]()
    var ref: FIRDatabaseReference!
    var images = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        UINavigationBar.appearance().tintColor = .white
        navigationItem.title = "НОВИНИ"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "NEW", style: .plain, target: self, action: #selector(addNew))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(CoursesReviewTableController.handleLogout))
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
        tableView.register(CourseReviewCell.self, forCellReuseIdentifier: cellId)
        
        tableView?.backgroundColor = UIColor.white
        
        //get current date
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year:Int =  components.year!
        let month:Int = components.month!
        
        let yearString:String = String(year)
        let monthString: String = String(month)
        
        print(yearString)
        print(monthString)
        
        ref = FIRDatabase.database().reference()
        
        ref.child("reviews").child("courses").child("301c06").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                let new = CourseReview()
                new.setValuesForKeys(dictionary)
                self.news.append(new)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }} ,withCancel: nil)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
    
    func handleLogout() {
        
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        navigationController?.pushViewController(loginController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ TableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseReviewCell
        
        let new = news[indexPath.row]
        
        cell.reviewDate.text = "ajkshdkad"
        cell.reviewText.text = new.text
        cell.userName.text = new.userID
        
//                if(images[indexPath.row] == nil){
//                    cell.newPicture.image = images[indexPath.row]
//                    return cell
//                }else
//        if let newImageURL = new.image {
//            let url = URL(string: newImageURL)
//            
//            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                if error != nil {
//                    print(error ?? "")
//                    return
//                }
//                
//                DispatchQueue.main.async(execute: {
//                    let im = UIImage(data: data!)
//                    self.images.append(im)
//                    cell.newPicture.image = UIImage(data: data!)
//                })
//                
//            }).resume()
//        }
        
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 600
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = OpenNewController()
//        
//        let new: CourseReview
//        new = news[indexPath.row]
//        
//        vc.descriptions = new.text
//        vc.headline = new.headline
//        vc.imageUrl = new.image
//        vc.likes = new.likes
//        vc.author = new.author
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addNew() {
//        let newNewController = NewNewController()
//        navigationController?.pushViewController(newNewController, animated: true)
    }
    
}
