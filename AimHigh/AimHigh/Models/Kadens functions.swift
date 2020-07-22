//// LoginViewController.swift
//// PackingCapstone
////
//// Created by Kaden Storrs on 6/18/20.
//// Copyright © 2020 Kaden Storrs. All rights reserved.
////
//import UIKit
//import Firebase
//import FirebaseFirestore
//import FirebaseStorage
//class SignUpUserViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
//    @IBOutlet weak var userNameTextField: UITextField!
//    @IBOutlet weak var emailTextFIeld: UITextField!
//    @IBOutlet weak var passwordTextFIeld: UITextField!
//    @IBOutlet weak var profileImageView: UIImageView!
//    @IBOutlet weak var addProfileImageButton: UIButton!
//
//    let storageRef = Storage.storage().reference()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        profileImageView.layer.cornerRadius = (profileImageView.bounds.width / 2)
//        profileImageView.layer.borderColor = UIColor(red: 0.42, green: 0.34, blue: 0.48, alpha: 1.0).cgColor
//        profileImageView.layer.borderWidth = 2.5
//        // Do any additional setup after loading the view.
//    }
//    //
//    //  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    //
//    //      if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//    //        profileImageView.image = selectedImage
//    //        if let image = profileImageView.image,
//    //          let data = image.pngData(),
//    //          let newImageFromData = UIImage(data: data) {
//    //          addProfileImageButton.imageView?.image = newImageFromData
//    //        }
//    //        addProfileImageButton.imageView?.image = selectedImage
//    //        pill?.image = selectedImage.pngData()
//    //        addPhotoButton.imageView?.image = selectedImage
//    //        dismiss(animated: true) {
//    //  //        self.updateView()
//    //          print(“view updated”)
//    //        }
//    //
//    //      }
//    //    }
//    @IBAction func profilePicImageButtonTapped(_ sender: Any) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        let cancelAction = UIAlertAction(title: “Cancel”, style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let cameraAction = UIAlertAction(title: “Camera”, style: .default, handler: { action in imagePicker.sourceType = .camera
//                self.present(imagePicker, animated: true, completion: nil)
//            })
//            alertController.addAction(cameraAction)
//        }
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let photoLibraryAction = UIAlertAction(title: “Photo Library”, style: .default, handler: { action in imagePicker.sourceType = .photoLibrary
//                self.present(imagePicker, animated: true, completion: nil)
//            })
//            alertController.addAction(photoLibraryAction)
//        }
//        present(alertController, animated: true, completion: nil)
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            profileImageView.image = selectedImage
//            if let image = profileImageView.image,
//                let data = image.pngData(),
//                let newImageFromData = UIImage(data: data) {
//                addProfileImageButton.imageView?.image = newImageFromData
//            }
//            addProfileImageButton.imageView?.image = selectedImage
//            //      pill?.image = selectedImage.pngData()
//            addProfileImageButton.imageView?.image = selectedImage
//            dismiss(animated: true) {
//                //        self.updateView()
//                print(“view updated”)
//            }
//        }
//    }
//    static func fetchUserImage() {
//    }
//    @IBAction func registerButtonTapped() {
//        guard let email = emailTextFIeld.text,
//            let password = passwordTextFIeld.text,
//            let username = userNameTextField.text else { return }
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            if error != nil {
//                print(error)
//                return
//            } else {
//                let randomID = UUID.init().uuidString
//                guard let imageData = self.profileImageView.image?.jpegData(compressionQuality: 1.0) else { return }
//                if let userData = user {
//                    print(userData.user.email)
//                    let storageProfileRef = self.storageRef.child(“ProfileImages/\(randomID).jpeg”)
//                    let metaData = StorageMetadata()
//                    metaData.contentType = “image/jpg”
//                    storageProfileRef.putData(imageData, metadata: metaData) { (storageMetaData, error) in
//                        if error != nil {
//                            print(error)
//                        }
//                        storageProfileRef.downloadURL { (url, error) in
//                            if let error = error {
//                                print(error.localizedDescription)
//                            } else {
//                                guard let url = url,
//                                    let uid = user?.user.uid else { return }
//                                var inputData: [String: Any] = [
//                                “userName”: username as String,
//                                “email”: email as String,
//                                “userId”: uid as String,
//                                “profileImageURL”: url.absoluteString as String
//                                ]
//                                self.registerUserIntoDatabase(values: inputData)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        Auth.auth().signIn(withEmail: email, password: password)
//    }
//    private func registerUserIntoDatabase(values: [String: Any]) {
//        Firestore.firestore().collection(“Users”).addDocument(data: values).collection(“Trips”)
//    }
//    @IBAction func unwindToSignUpVC(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source as! NewTripViewController
//        performSegue(withIdentifier: “logoutUserSegue”, sender: nil)
//    }
//}
