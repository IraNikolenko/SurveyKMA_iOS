//
//  CoursesCollectionViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 26.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CourseCell"

class CourseCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var courseName: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
}

class CoursesCollectionViewController: UICollectionViewController {
    
    var courses = [Course]()
    var coursesKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CourseCollectionCell
        
        let course = courses[indexPath.row]
        //cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showDetail)))
        cell.courseName.text = course.name
        
        return cell
    }
    
    func showDetail(_ row: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CourseReviewViewController") as! CourseReviewViewController
        print(row)
        let courseToPresent = courses[row]
        
        controller.currentCourse = courseToPresent
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CourseReviewViewController") as! CourseReviewViewController
        
        let courseToPresent = courses[indexPath.row]
        
        controller.courseKey = self.coursesKeys[indexPath.row]
        controller.currentCourse = courseToPresent
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        
//    }
    
}

//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//
//
//        }
//    }

// MARK: UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 
 */


