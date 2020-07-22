//
//  NewGoalInputViewController.swift
//  AimHigh
//
//  Created by Jordy Vazquez on 6/14/20.
//  Copyright © 2020 Jordy Vazquez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class NewGoalInputViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameOfGoalTextField: UITextField!
    @IBOutlet weak var reasonsInputLabel: UILabel!
    @IBOutlet weak var addReasonWhyButton: UIButton!
    @IBOutlet weak var dateInputLabel: UILabel!
    @IBOutlet weak var newGoalDatePicker: UIDatePicker!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var reason1Input: UITextField!
    @IBOutlet weak var reason2Input: UITextField!
    @IBOutlet weak var reason3Input: UITextField!
    @IBOutlet weak var goalImageView: UIImageView!
    
    
    //    var goalInput: GoalInput?
    var ref: DatabaseReference?
    var goalInput: [GoalStructure] = []
    var db: Firestore! = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        newGoalDatePicker!.layer.borderWidth = 1
        newGoalDatePicker!.layer.cornerRadius = 5.0
        if traitCollection.userInterfaceStyle == .dark {
            newGoalDatePicker!.layer.borderColor = #colorLiteral(red: 0.2509999871, green: 0.523999989, blue: 0.8679999709, alpha: 1)
        } else if traitCollection.userInterfaceStyle == .light {
            newGoalDatePicker!.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        addReasonWhyButton.layer.borderWidth = 4
        addReasonWhyButton.layer.cornerRadius = 7
        addReasonWhyButton.layer.borderColor = #colorLiteral(red: 0, green: 0.1468918622, blue: 0.6164586544, alpha: 1)
        
        
        
        
        
        db = Firestore.firestore()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction =  UIAlertAction(title: "Camera", style: .default, handler: { action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in print("UserSelectedCamera")
            
        })
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
                
            })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.popoverPresentationController?.sourceView = sender as? UIView
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            goalImageView.image = selectedImage
            if let image = goalImageView.image,
                let data = image.pngData(),
                let newImageFromData = UIImage(data: data) {
                addImageButton.imageView?.image = newImageFromData
            }
            addImageButton.imageView?.image = selectedImage
            
            dismiss(animated: true) {
                print("View Updated")
            }
        }
    }
    
    
    @IBAction func AddReasonWhyButton(_ sender: Any) {
        unHiddeReasonsLable()
        reason1Input.textColor = UIColor.black
    }
    
    func unHiddeReasonsLable() {
        reason1Input.isHidden = !reason1Input.isHidden
        reason2Input.isHidden = !reason2Input.isHidden
        reason3Input.isHidden = !reason3Input.isHidden
    }
    
    @IBAction func saveButtonTapped(_ unwindSegue: UIStoryboardSegue) {
        
        goalDateFormatter.dateStyle = .full
        
        var ref: DocumentReference? = nil
        guard let imageString = self.goalImageView.image?.jpegData(compressionQuality: 0.1)?.base64EncodedString() else {
            return
        }
        let stringDate = goalDateFormatter.string(from: newGoalDatePicker.date)
        
        
        ref = db.collection("goals").addDocument(data: [
            "nameOfGoal": nameOfGoalTextField.text as? String,
            "reasonForGoal1": reason1Input.text as? String,
            "reasonForGoal2": reason2Input.text as? String,
            "reasonForGoal3": reason3Input.text as? String,
            "date": stringDate,
            "goalImage": imageString
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        performSegue(withIdentifier: "unwindToMainTableView", sender: self)
    }
    
}



