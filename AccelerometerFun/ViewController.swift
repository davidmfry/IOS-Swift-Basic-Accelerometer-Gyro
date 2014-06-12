//
//  ViewController.swift
//  AccelerometerFun
//
//  Created by David Fry on 6/10/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//
// Most of the ideas for this comes from http://nscookbook.com/2013/03/ios-programming-recipe-19-using-core-motion-to-access-gyro-and-accelerometer/
// Coverted it into Swift
// Credit: Joe Hoffman 

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    let motionManager = CMMotionManager()
    
    @IBOutlet var accX : UILabel = nil
    @IBOutlet var accY : UILabel = nil
    @IBOutlet var accZ : UILabel = nil
    
    @IBOutlet var maxAccX : UILabel = nil
    @IBOutlet var maxAccY : UILabel = nil
    @IBOutlet var maxAccZ : UILabel = nil
    
    @IBOutlet var rotX : UILabel = nil
    @IBOutlet var rotY : UILabel = nil
    @IBOutlet var rotZ : UILabel = nil
    
    @IBOutlet var maxRotX : UILabel = nil
    @IBOutlet var maxRotY : UILabel = nil
    @IBOutlet var maxRotZ : UILabel = nil
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(accelerometerData: CMAccelerometerData!, error:NSError!)in
                self.outputAccelerationData(accelerometerData.acceleration)
                if error
                {
                    println("\(error)")
                }
            })
        
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(gyroData: CMGyroData!, error: NSError!)in
                self.outputRotationData(gyroData.rotationRate)
                if error
                {
                    println("\(error)")
                }
            })
        

        
    }

    @IBAction func resetButtonPressed(sender : AnyObject)
    {
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
    }
    
    func outputAccelerationData(acceleration:CMAcceleration)
    {
        // Swift does not have string formation yet
        accX.text = NSString(format:"%.4f", acceleration.x)
        
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        accY.text = NSString(format:"%.4f", acceleration.y)
        
        if acceleration.y > currentMaxAccelY
        {
            currentMaxAccelY = acceleration.y
        }
        
        accZ.text = NSString(format:"%.4f", acceleration.z)
        
        if acceleration.z > currentMaxAccelZ
        {
            currentMaxAccelZ = acceleration.z
        }
        
        maxAccX.text = NSString(format:"%.4f", currentMaxAccelX)
        maxAccY.text = NSString(format:"%.4f", currentMaxAccelY)
        maxAccZ.text = NSString(format:"%.4f", currentMaxAccelZ)
        
    }
    
    func outputRotationData(rotation:CMRotationRate)
    {
        rotX.text = NSString(format:"%.4f", rotation.x)
        if fabs(rotation.x) > fabs(currentMaxRotX)
        {
            currentMaxRotX = rotation.x
        }
        
        rotY.text = NSString(format:"%.4f", rotation.y)
        if fabs(rotation.y) > fabs(currentMaxRotY)
        {
            currentMaxRotY = rotation.y
        }
        rotZ.text = NSString(format:"%.4f", rotation.z)
        if fabs(rotation.z) > fabs(currentMaxRotZ)
        {
            currentMaxRotZ = rotation.z
        }
        
        maxRotX.text = NSString(format:"%.4f", currentMaxRotX)
        maxRotY.text = NSString(format:"%.4f", currentMaxRotY)
        maxRotZ.text = NSString(format:"%.4f", currentMaxRotZ)
    }

}

