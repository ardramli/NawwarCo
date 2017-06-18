//
//  AddItemViewController.swift
//  NawwarCo
//
//  Created by ardMac on 14/06/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            imageView.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemColorTextField: UITextField!
    @IBOutlet weak var itemQuantityTextField: UITextField!

    
    let picker = UIImagePickerController()
    var ref: DatabaseReference!
    var itemID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        itemNameTextField.delegate = self
        itemColorTextField.delegate = self
        itemQuantityTextField.delegate = self
        
        ref = Database.database().reference()
        
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        handleCreateItem()
    }

    func imageTapped(){
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func handleCreateItem(){
        guard let name = itemNameTextField.text , let color = itemColorTextField.text, let quantity = Int(itemQuantityTextField.text!)
            else {
                return
            }
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("item_images").child("\(imageName).jpg")
        
        let itemRef = ref.childByAutoId()
        self.itemID = itemRef.key
        
        if let itemPhoto = self.imageView.image, let uploadData = UIImageJPEGRepresentation(itemPhoto, 0.1){
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error!)
                    
                    return
                }
                if let itemPhotoUrl = metadata?.downloadURL()?.absoluteString{
                    
                    let values = ["name" : name, "color" : color, "quantity" : quantity, "itemPhotoUrl" : itemPhotoUrl] as [String : Any]
                    self.registerItemIntoDatabaseWithUID(itemId: self.itemID, values: values as [String : AnyObject])
                    
                }
            })
        }
    }
    
    func registerItemIntoDatabaseWithUID(itemId : String, values: [String: Any]) {
        let itemReference = ref.child("items").child(itemId)
        itemReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
        })
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 49
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height - 49
            }
        }
    }

}

extension AddItemViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("User canceled out of picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker
        {
            imageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
