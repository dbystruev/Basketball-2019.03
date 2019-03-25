//
//  ViewController+Methods.swift
//  Basketball
//
//  Created by Denis Bystruev on 25/03/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import ARKit

extension ViewController {
    
    func createWall(anchor: ARPlaneAnchor) -> SCNNode {
        
        let extent = anchor.extent
        let width = CGFloat(extent.x)
        let height = CGFloat(extent.z)
        
        let node = SCNNode(geometry: SCNPlane(width: width, height: height))
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        node.eulerAngles.x = -.pi / 2
        node.name = "Wall"
        node.opacity = 0.25
        
        return node
    }
    
    func addHoop(result: ARHitTestResult) {
        let scene = SCNScene(named: "art.scnassets/Hoop.scn")!
        
        guard let node = scene.rootNode.childNode(withName: "Hoop", recursively: false) else {
            return
        }
        
        node.simdTransform = result.worldTransform
        node.eulerAngles.x -= .pi / 2
        
        sceneView.scene.rootNode.enumerateChildNodes { node, _ in
            if node.name == "Wall" {
                node.removeFromParentNode()
            }
        }
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
}
