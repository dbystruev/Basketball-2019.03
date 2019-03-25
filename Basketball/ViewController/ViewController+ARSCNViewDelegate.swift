//
//  ViewController+ARSCNViewDelegate.swift
//  Basketball
//
//  Created by Denis Bystruev on 25/03/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import ARKit

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else { return }
        node.addChildNode(createWall(anchor: anchor))
    }
    
}
