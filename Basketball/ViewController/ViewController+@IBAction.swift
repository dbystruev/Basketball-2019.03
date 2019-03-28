//
//  ViewController+@IBAction.swift
//  Basketball
//
//  Created by Denis Bystruev on 25/03/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

extension ViewController {
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        
        if !hoopAdded {
            
            let location = sender.location(in: sceneView)
            let results = sceneView.hitTest(location, types: [.existingPlaneUsingExtent])
            guard let result = results.first else { return }
            addHoop(result: result)
            
        } else {
            
            addBasketball()
            
        }
        
    }
}
