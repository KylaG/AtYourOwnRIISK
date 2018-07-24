//
//  ViewController.swift
//  TesterPhotonConnection
//
//  Created by ETC 2018 on 7/23/18.
//  Copyright © 2018 ETC 2018. All rights reserved.
//

import UIKit
import ParticleSDK

class ViewController: UIViewController {

    @IBOutlet weak var tvocLabel: UILabel!
    @IBOutlet weak var coHead: UILabel!
    @IBOutlet weak var tvocHead: UILabel!
    @IBOutlet weak var coLabel: UILabel!
    var tvocVal : Int = 0
    var coVal : Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cloud = SparkCloud.sharedInstance()
        
        cloud.login(withUser: "yourEmail", password: "yourPassword") { (error) in
            if(error != nil){
                print(error.debugDescription)
            } else {
                print("loggedIn!!")
                        self.tvocLabel.text = ""
                cloud.getDevices({ (devices, error) in
                    // print(devices?.first?.id)
                    //important for KYLA
                    //devices?.first?.getVariable(variableName;"something", completion: <#T##((Any?, Error?) -> Void)?##((Any?, Error?) -> Void)?##(Any?, Error?) -> Void#>)
                    cloud.subscribeToAllEvents(withPrefix: "tVOC", handler: { (event :SparkEvent?, error : Error?) in
                        if let _ = error {
                            print ("could not subscribe to events")
                        } else {
                            DispatchQueue.main.async(execute: {
                                if let tvoc = event?.data as? String {
                                        self.tvocLabel.text = "\(tvoc)"
                                }
                            })
                        }
                                
                
                        
                    })
            
                cloud.subscribeToAllEvents(withPrefix: "CO2", handler: { (event :SparkEvent?, error : Error?) in
                    if let _ = error {
                        print ("could not subscribe to events")
                    } else {
                        DispatchQueue.main.async(execute: {
                            if let hum = event?.data as? String {
                               // if(hum.contains("%")){
                                    self.coLabel.text = "\(hum)"
                                //}
                            }
                            
                            print("got co2 event with data \(event?.data)")
                        })
                    }
                })
                
              /*
                cloud.subscribeToAllEvents(withPrefix: "altitude", handler: { (event :SparkEvent?, error : Error?) in
                    if let _ = error {
                        print ("could not subscribe to events")
                    } else {
                        DispatchQueue.main.async(execute: {
                            self.altLb.text = event?.data as! String + " ft"
                            //print("got alt event with data \(event?.data)")
                        })
                    }
                })
                */
                
            })
        }
    }
   // _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(), userInfo: nil, repeats: true)
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}

