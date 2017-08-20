//
//  ViewController.swift
//  GRT-iOS-HelloWorld
//
//  Created by Nicholas Arner on 8/17/17.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import UIKit
import GRTiOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadTrainingData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadTrainingData(){
        
        let path = Bundle.main.url(forResource: "Pipeline", withExtension: "grt")
        
        let pipeline = GestureRecognitionPipeline()
        let test:Bool = pipeline.load(path)
        print(test)
    }
 

}

