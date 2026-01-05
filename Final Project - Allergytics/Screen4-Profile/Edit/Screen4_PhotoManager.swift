//
//  PhotoManager.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/19/25.
//

import UIKit
import PhotosUI

extension Screen4_editVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            if let image = info[.editedImage] as? UIImage{
                self.screen4EditUI.profileImageButton.setImage(
                    image.withRenderingMode(.alwaysOriginal),
                    for: .normal
                )
                self.pickerImage = image
            }else{
                print("Camera image was not loaded correctly")
            }
        }
}

extension Screen4_editVC: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.screen4EditUI.profileImageButton.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickerImage = uwImage
                        }
                    }
                })
            }
        }
    }
}
