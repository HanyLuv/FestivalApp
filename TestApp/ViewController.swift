//
//  ViewController.swift
//  TestApp
//
//  Created by hany on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    var park = Park(filename: "MagicMountain")
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

}


extension ViewController: MKMapViewDelegate{
    
}
