//
//  ViewController.swift
//  MemeMe
//
//  Created by Dandre Ealy on 12/7/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate  {
    
    
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var galleryButton: UIToolbar!
    @IBOutlet weak var memeImageView: UIImageView!
    
    
    var textAttributes:[String:Any] = [
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeWidthAttributeName: -1] as [String : Any]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        buttomTextField.delegate = self
        setTextField(topTextField)
        setTextField(buttomTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickFromGallery(_ sender: Any) {
        imagePickerProcess(.photoLibrary)
    }
    @IBAction func pickFromCamera(_ sender: Any) {
        imagePickerProcess(.camera)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        
        let ac = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        ac.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            } else {
                print(error as Any)
            }
        }
        present(ac, animated: true, completion: nil)
    }
    
    
    var meme = Meme()
    
    
    func save() {
        meme = Meme(topTextField: topTextField.text, bottomTextField: buttomTextField.text, originalImage:  memeImageView.image, memedImage: generateMemedImage())
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:  .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if buttomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if buttomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    func generateMemedImage() -> UIImage {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.galleryButton.isHidden = true
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.galleryButton.isHidden = false
        
        return memedImage
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.contentMode = .scaleAspectFit
            memeImageView.image = imagePicked
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerProcess(_ chosenSource: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = chosenSource
        present(imagePicker, animated: true, completion: nil)
}
    
    func setTextField(_ textField: UITextField) {
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = .center
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

