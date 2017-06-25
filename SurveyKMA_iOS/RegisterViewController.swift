//
//  RegisterViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 11.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var yearOfStudyTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var yearOfGratuationTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        passwordTextField.isSecureTextEntry = true
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        self.userPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addMainImage)))
        
    }

    func signIn(){
        let registerController = RegisterViewController()
        //self.navigationController?.pushViewController(registerController, animated: true)
        self.present(registerController, animated: true, completion: nil)
    }
    
    func handleRegister(){
        
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("\(imageName).png")
        var imageUrl: String = ""
        
        if(self.userPhoto.image != nil){
            if let uploadData = UIImagePNGRepresentation(self.userPhoto.image!){
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil{
                        print(error ?? "")
                        return
                    }
                    
                    if let dishImageUrl = metadata?.downloadURL()?.absoluteString{
                        imageUrl = dishImageUrl
                    }
                })
            }}else {
            imageUrl = ""
        }
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else{
                print("Form not valid")
                return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user:FIRUser?, error) in
            if error != nil {
                print (error ?? "")
                return
            }
        
            guard let uid = user?.uid else{
                return
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://tophick-698df.firebaseio.com/")
            let values = ["name": name, "email": email, "settings":"", "bookmarks":"", "likes":"", "surname":"", "pictureURL":imageUrl, "language":"en"]
            let usersReference = ref.child("users").child(uid)
            usersReference.updateChildValues(values, withCompletionBlock:{(err,ref) in
                
                if err != nil{
                    print(err ?? "")
                    return
                }
                //let mainView = NewsController()
                //self.navigationController?.pushViewController(mainView, animated: true)
            })
        })
    }
    
    func addMainImage(){
        print("djkhf")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            userPhoto.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
