//
//  drawViewController.swift
//  StreetART
//
//  Created by George Allard on 23/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit

class drawViewController: UIViewController {

    @IBOutlet weak var toolIcon: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    var red:CGFloat = 0.0
    var green:CGFloat = 0.0
    var blue:CGFloat = 0.0
    var brushSize:CGFloat = 5.0
    var opacityValue:CGFloat = 1.0
    
    var tool:UIImageView!
    var isDrawing = true
    var selectedImage:UIImage!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tool = UIImageView()
        tool.frame = CGRect(x: self.view.bounds.size.width, y: self.view.bounds.size.height, width: 38, height: 38)
        tool.image = #imageLiteral(resourceName: "Paintbrush")
        self.view.addSubview(tool)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(fromPoint:CGPoint,toPoint:CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        tool.center = toPoint
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }

    @IBAction func reset(_ sender: Any) {
        
             self.imageView.image = nil

    }
    
    
    @IBAction func save(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Pick your option", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Pick an image", style: .default, handler: { (_) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Save your drawing", style: .default, handler: { (_) in
            if let image = self.imageView.image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func erase(_ sender: Any) {
        
        
        if (isDrawing) {
            (red,green,blue) = (1,1,1)
            tool.image = #imageLiteral(resourceName: "icons8-erase_filled")
            toolIcon.setImage(#imageLiteral(resourceName: "Paintbrush"), for: .normal)
            
        } else {
            (red,green,blue) = (0,0,0)
            tool.image = #imageLiteral(resourceName: "Paintbrush")
            toolIcon.setImage(#imageLiteral(resourceName: "icons8-erase_filled"), for: .normal)
        }
        
        isDrawing = !isDrawing
        
    }

    @IBAction func setting(_ sender: Any) {
}


    @IBAction func coloursPicked(_ sender: Any) {
        
        
        if (sender as AnyObject).tag == 0 {
            (red,green,blue) = (1,0,0)
        } else if (sender as AnyObject).tag == 1 {
            (red,green,blue) = (0,1,0)
        } else if (sender as AnyObject).tag == 2 {
            (red,green,blue) = (0,0,1)
        } else if (sender as AnyObject).tag == 3 {
            (red,green,blue) = (1,0,1)
        } else if (sender as AnyObject).tag == 4 {
            (red,green,blue) = (1,1,0)
        } else if (sender as AnyObject).tag == 5 {
            (red,green,blue) = (0,1,1)
        } else if (sender as AnyObject).tag == 6 {
            (red,green,blue) = (1,1,1)
        } else if (sender as AnyObject).tag == 7 {
            (red,green,blue) = (0,0,0)
        }


}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    let settingsViewController = segue.destination as! settingsViewController
    settingsViewController.delegate = self
    settingsViewController.red = red
    settingsViewController.green = green
    settingsViewController.blue = blue
    settingsViewController.brushSize = brushSize
    settingsViewController.opacityValue = opacityValue

        }
    }

extension drawViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate, settingsViewControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // We got the user's image
            self.selectedImage = imagePicked
            self.imageView.image = selectedImage
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func settingsViewControllerDidFinish(_ settingsViewController: settingsViewController) {
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        self.brushSize = settingsViewController.brushSize
        self.opacityValue = settingsViewController.opacityValue
        
    }
}


















