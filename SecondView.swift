//
//  SecondView.swift
//  FirebaseLogin
//
//  Created by Ali Al sharefi on 27/04/2020.
//  Copyright © 2020 Ali Al sharefi. All rights reserved.
//

import UIKit

class SecondView: UIViewController,UIImagePickerControllerDelegate {

    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = imagePicker as? UIImagePickerControllerDelegate & UINavigationControllerDelegate//assign the object from this class to handle image picking return
        config()

    }
    
    @IBAction func photoBtnPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary // what type of task: camera or photoalbum
        imagePicker.allowsEditing = true //should the user be able to zoom in before getting the image
        present(imagePicker, animated: true,completion: nil)
    }
    
    @IBAction func videoBtnPressed(_ sender: Any) {
        imagePicker.mediaTypes = ["Public.movie"] //will launch the video in the camera app
        imagePicker.videoQuality = .typeMedium //sets the quality level
        launchCamera()
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true,completion: nil)
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        launchCamera()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //print("Returned from image picking")
        
        if let url = info[.mediaURL] as? URL{ //this will only be true if theres is a video
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path){
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil) //minimal version of save
            }
        }else{ //if we have an image
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doGo(_ sender: Any) {
        let s = myTextField.text!
        let s2 = NSAttributedString(string: s, attributes:
            [.font:UIFont(name: "Georgia", size: 100)!,
             .foregroundColor: UIColor.yellow])
        let sz = imageView.image!.size
        let r = UIGraphicsImageRenderer(size:sz)
        imageView.image = r.image {
            _ in
            imageView.image!.draw(at:.zero)
            s2.draw(at: CGPoint(x:30, y:sz.height-150))
    }
}
    
    @IBAction func doRevert(_ sender: Any) {
        config()
    }
    

        
    func config() {
        imageView.image = UIImage(named:"nice.jpg")
    }
    
    
    @IBAction func savePhoto(_ sender: Any) {
        let imageData = imageView.image!.pngData()
        let compresedImage = UIImage(data: imageData!)
        
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }

}

