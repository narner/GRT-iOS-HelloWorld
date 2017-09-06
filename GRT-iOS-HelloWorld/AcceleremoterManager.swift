//
//  CoreMotionManager.swift
//  WatchGRT
//
//  Created by M J on 02/12/15.
//  Copyright © 2015 jahnen. All rights reserved.
//  Modified by Nick Arner
//

import Foundation
import CoreMotion

class AccelerometerManager {
    private let motionManager = CMMotionManager()
    private let motionQueue = OperationQueue()
    
    init() {
        motionQueue.name = "CoreMotion"
        
        motionManager.accelerometerUpdateInterval = 1/60.0
    }
    
    func start(accHandler: @escaping (_ x: Double, _ y: Double, _ z: Double) -> Void) {
        let handler: CMAccelerometerHandler  = {(data: CMAccelerometerData?, error: Error?) -> Void in
            guard let acceleration = data?.acceleration else {
                print("Error: data is nil: \(String(describing: error))")
                return
            }
            
            accHandler(acceleration.x, acceleration.y, acceleration.z)
        } 
        motionManager.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
    }
    
    func stop() {
        motionManager.stopAccelerometerUpdates()
    }
}
