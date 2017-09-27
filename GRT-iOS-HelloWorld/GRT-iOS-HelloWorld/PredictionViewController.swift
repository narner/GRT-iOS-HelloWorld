
//
//  PredictionViewController.swift
//  GRT-iOS-HelloWorld
//
//  Created by Nicholas Arner on 8/22/17.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import Foundation
import UIKit
import GRTiOS

class PredictionViewController: UIViewController {
    
    @IBOutlet var gestureOneCountLabel: UILabel!
    @IBOutlet var gestureTwoCountLabel: UILabel! 
    @IBOutlet var gestureThreeCountLabel: UILabel!
    
    var gestureOneCount: UInt = 0
    var gestureTwoCount: UInt = 0
    var gestureThreeCount: UInt = 0
    
    fileprivate let accelerometerManager = AccelerometerManager()

    var currentClassLabel = 0 as UInt
    var labelUpdateTime = Date.timeIntervalSinceReferenceDate
    let vector = VectorDouble()
    var pipeline: GestureRecognitionPipeline?
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.pipeline = appDelegate.pipeline!

        initPipeline()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        accelerometerManager.stop()
    }
    
    func initPipeline(){
        
        //Load the GRT pipeline and the training data files from the documents directory
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let pipelineURL = documentsUrl.appendingPathComponent("train.grt")
        let classificiationDataURL = documentsUrl.appendingPathComponent("trainingData.csv")

        let pipelineResult:Bool = pipeline!.load(pipelineURL)
        let classificationDataResult:Bool = pipeline!.loadClassificationData(classificiationDataURL)
        
        if pipelineResult == false {
            let userAlert = UIAlertController(title: "Error", message: "Couldn't load pipeline", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            userAlert.addAction(cancel)
            self.present(userAlert, animated: true, completion: { _ in })
        }
        
        if classificationDataResult == false {
            let userAlert = UIAlertController(title: "Error", message: "Couldn't load classification data", preferredStyle: .alert)
            self.present(userAlert, animated: true, completion: { _ in })
            let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            userAlert.addAction(cancel)
        }
        
        //If the files have been loaded successfully, we can train the pipeline, and then start real-time gesture prediction
        else if (classificationDataResult && pipelineResult) {
            pipeline?.train()
            performGesturePrediction()
        }
    }
    
    func performGesturePrediction() {
        accelerometerManager.start { (x, y, z) -> Void in
            self.vector.clear()
            self.vector.pushBack(x)
            self.vector.pushBack(y)
            self.vector.pushBack(z)
            //Use the incoming accellerometer data to predict what the performed gesture class is
            self.pipeline?.predict(self.vector)

            DispatchQueue.main.async {
                self.updateGestureCountLabels(gesture: (self.pipeline?.predictedClassLabel)!)
                print("PRECITED GESTURE", self.pipeline?.predictedClassLabel ?? 0);
            }
        }
    }
    
    func updateGestureCountLabels(gesture: UInt){
        
        if gesture == 0 {
            //do nothing
        } else if (gesture == 1){
            gestureOneCount = gestureOneCount + 1
            let gestureOneCountVal = String(gestureOneCount)
            gestureOneCountLabel.text = ("Gesture 1 count: " + gestureOneCountVal)
        } else if (gesture == 2){
            gestureTwoCount = gestureTwoCount + 1
            let gestureTwoCountVal = String(gestureTwoCount)
            gestureTwoCountLabel.text = ("Gesture 2 count: " + gestureTwoCountVal)
        } else if (gesture == 3){
            gestureThreeCount = gestureThreeCount + 1
            let gestureThreeCountVal = String(gestureThreeCount)
            gestureThreeCountLabel.text = ("Gesture 3 count: " + gestureThreeCountVal)
        }
        
    }

}
