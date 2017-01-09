//
//  DetailViewController.swift
//  CountdownDaysApp
//
//  Created by JScharm on 12/15/16.
//  Copyright © 2016 JScharm. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    
    @IBOutlet weak var daysTillLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myButton: UIButton!

    var detailItem : CountdownClass!
    let imagePicker = UIImagePickerController()
    let currentDate = NSDate()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = detailItem.name
        imagePicker.delegate = self
        
        // Initialize Date components
        var comp = NSDateComponents()
        comp.year = 2016
        comp.month = 12
        comp.day = 19 + Int(detailItem.days)!
        
        // Get NSDate given the above date components
        let date = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: comp as DateComponents)
        daysTillLabel.text = "\(date)"
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton)
    {
        myButton.alpha = 0
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        imagePicker.dismiss(animated: true) { () -> Void in
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.myImageView.image = selectedImage
        }
        
    }
        
}
