//
//  AddItemViewController.swift
//  Collector
//
//  Created by Steven Lerner on 2/28/18.
//  Copyright © 2018 Steven Lerner. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = choosenImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.title = titleTextField.text
            
           if let image = itemImageView.image {
               if let imageData = UIImagePNGRepresentation(image) {
                    item.image = imageData
                }
            }
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    
}
