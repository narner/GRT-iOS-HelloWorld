//
//  TrainingViewController.swift
//  GRT-iOS-HelloWorld
//
//  Created by Nicholas Arner on 8/17/17.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import UIKit
import GRTiOS

class TrainingViewController: UIViewController {

    @IBOutlet var gestureSelector: UISegmentedControl!
    @IBOutlet var trainButton: UIButton!
    
    fileprivate let accelerometerManager = AccelerometerManager()
    fileprivate var currentFilePath: String!
    fileprivate var currentFileHandle: FileHandle?
    
    var trainButtonSelected:Bool = false
    var pipeline: GestureRecognitionPipeline?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        trainButton.addTarget(self, action:#selector(TrainBtnPressed(_:)), for: .touchDown);
        trainButton.addTarget(self, action:#selector(TrainBtnReleased(_:)), for: .touchUpInside);
        
        //Create an instance of a GRT pipeline
        self.pipeline = appDelegate.pipeline!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        accelerometerManager.stop()
    }
    
    func TrainBtnPressed(_ sender: Any) {
        trainButton.isSelected = true
        let gestureClass = self.gestureSelector.selectedSegmentIndex
        
        accelerometerManager.start( accHandler: { (x, y, z) -> Void in
            
            //Add the accellerometer data to a vector, which is how we'll store the classification data
            let vector = VectorFloat()
            vector.clear()
            vector.pushBack(x)
            vector.pushBack(y)
            vector.pushBack(z)
            
            print("x", x)
            print("y", y)
            print("z", z)
            print("Gesture class is %@", gestureClass);
            self.pipeline!.addSamplesToClassificationData(forGesture: UInt(gestureClass), vector)
        })
    }
    
    func TrainBtnReleased(_ sender: Any) {
        trainButton.isSelected = false
        accelerometerManager.stop()
    }
    
    @IBAction func savePipeline(_ sender: Any) {
        // Set URL for saving the pipeline to
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let pipelineURL = documentsUrl.appendingPathComponent("train.grt")
        
        // Remove the pipeline if it already exists
        let _ = try? FileManager.default.removeItem(at: pipelineURL)

        let pipelineSaveResult = self.pipeline?.save(pipelineURL)
        if !pipelineSaveResult! {
            let userAlert = UIAlertController(title: "Error", message: "Failed to save pipeline", preferredStyle: .alert)
            self.present(userAlert, animated: true, completion: { _ in })
            let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            userAlert.addAction(cancel)
        }
        
        // Save the training data as a CSV file
        let classificiationDataURL = documentsUrl.appendingPathComponent("trainingData.csv")

        let _ = try? FileManager.default.removeItem(at: classificiationDataURL)

        let classificationSaveResult = self.pipeline?.saveClassificationData(classificiationDataURL)
        
        if !classificationSaveResult! {
            let userAlert = UIAlertController(title: "Error", message: "Failed to save classification data", preferredStyle: .alert)
            self.present(userAlert, animated: true, completion: { _ in })
            let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            userAlert.addAction(cancel)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

