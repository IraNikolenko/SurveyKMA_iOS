//
//  LectorsCollectionViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 25.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "LectorCell"

class LectorCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lectorName: UITextView!
    @IBOutlet weak var lectorPhoto: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
}

class LectorsCollectionViewController: UICollectionViewController {

    var lectors = [Lector]()
    var lectorKeys = [String]()
    var coursesKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return lectors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LectorCollectionCell
    
        let lector = lectors[indexPath.row]
        
        cell.lectorName.text = lector.name
        
        if let newImageURL = lector.img {
            let url = URL(string: newImageURL)
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    //let im = UIImage(data: data!)
                    //self.images.append(im)
                    cell.lectorPhoto.image = UIImage(data: data!)
                })
                
            }).resume()
        }
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LectorReviewViewController") as! LectorReviewViewController
        controller.currentLector = lectors[indexPath.row]
        controller.lectorKey = self.lectorKeys[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        //self.present(controller, animated: true, completion: nil)
    }
    
    
    
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

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
