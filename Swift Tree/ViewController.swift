//
//  ViewController.swift
//  Swift Tree
//
//  Created by Skyler Arnold on 12/17/15.
//  Copyright © 2015 Skyler Arnold. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var treeView: TreeView!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var angleLabel: UILabel!
    
    var depth: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let lineLengthConstant = 50
    

    @IBAction func angleValueChanged(sender: UIStepper) {
        self.treeView.angleVar = sender.value
        self.angleLabel.text = "\(sender.value)"
        self.treeView.setNeedsDisplay()
    }
    
    @IBAction func depthValueChanged(sender: UIStepper) {
        self.treeView.depthToDrawTo = Int(sender.value)
        self.depthLabel.text = "\(sender.value)"
        self.treeView.setNeedsDisplay()
        
//        self.treeView.drawRect(treeView.frame)
    }
}

