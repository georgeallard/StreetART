//
//  settingsViewController.swift
//  StreetART
//
//  Created by George Allard on 23/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit

protocol settingsViewControllerDelegate:class {
    func settingsViewControllerDidFinish(_ settingsViewController: settingsViewController)

}

class settingsViewController: UIViewController {
    
    @IBOutlet weak var BrushSizeLabel: UILabel!
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var red:CGFloat = 0.0
    var green:CGFloat = 0.0
    var blue:CGFloat = 0.0
    var brushSize:CGFloat = 5.0
    var opacityValue:CGFloat = 1.0
    
    var delegate:settingsViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        drawPreview(red: red, green: green, blue: blue)
        
        redSlider.value = Float(red)
        redLabel.text = String(Int(redSlider.value * 255))
        
        greenSlider.value = Float(green)
        greenLabel.text = String(Int(greenSlider.value * 255))
        
        blueSlider.value = Float(blue)
        blueLabel.text = String(Int(blueSlider.value * 255))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func dismiss(_ sender: Any) {
        
        if delegate != nil {
            delegate?.settingsViewControllerDidFinish(self)
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func brushSizeChanged(_ sender: Any) {
    }

    
    
    @IBAction func opacityChanged(_ sender: Any) {
    }
    
    

    @IBAction func redSliderChanged(_ sender: Any) {
        
        let slider = sender as! UISlider
        red = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(slider.value * 255))"
        
    }
    
    
    
    @IBAction func greenSliderChanged(_ sender: Any) {
        
        let slider = sender as! UISlider
        green = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(slider.value * 255))"
    }

    
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        
        let slider = sender as! UISlider
        blue = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(slider.value * 255))"
    }
    
    
    func drawPreview (red:CGFloat,green:CGFloat,blue:CGFloat) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacityValue).cgColor)
        context?.setLineWidth(brushSize)
        context?.setLineCap(CGLineCap.round)
        
        context?.move(to: CGPoint(x:70, y:70))
        context?.addLine(to: CGPoint(x: 70, y: 70))
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }

    
    
    
    
}
