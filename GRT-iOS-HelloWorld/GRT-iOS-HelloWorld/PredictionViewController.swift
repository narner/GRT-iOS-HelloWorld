
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
    
    @IBOutlet var predictedGestureLabel: UILabel!
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
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let pipelineURL = documentsUrl.appendingPathComponent("train.grt")
        let classificiationDataURL = documentsUrl.appendingPathComponent("trainingData.csv")

        let pipelineResult:Bool = pipeline!.load(pipelineURL)
        let classificationDataResult:Bool = pipeline!.loadClassificationData(classificiationDataURL)
        
        if pipelineResult == false {
            //present alert saying pipeline couldn't load file
            let userAlert = UIAlertController(title: "Error", message: "Couldn't load pipeline", preferredStyle: .alert)
            self.present(userAlert, animated: true, completion: { _ in })
        }
        
        if classificationDataResult == false {
            let userAlert = UIAlertController(title: "Error", message: "Couldn't load classification data", preferredStyle: .alert)
            self.present(userAlert, animated: true, completion: { _ in })
        }
        
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
            self.pipeline?.predict(self.vector)

            let predictedClass = String(describing: self.pipeline?.predictedClassLabel .hashValue)
            self.predictedGestureLabel.text = predictedClass
            print("PRECITED CLASS", self.pipeline?.predictedClassLabel ?? 0);
        }
    }

}
