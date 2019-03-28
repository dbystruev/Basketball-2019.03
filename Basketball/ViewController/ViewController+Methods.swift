//
//  ViewController+Methods.swift
//  Basketball
//
//  Created by Denis Bystruev on 25/03/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import ARKit

extension ViewController {
    
    // MARK: - Adding objects
    func addBasketball() {
        guard let frame = sceneView.session.currentFrame else { return }
        
        let ball = SCNNode(geometry: SCNSphere(radius: 0.25))
        ball.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/basketball.png")
        
        let shape = SCNPhysicsShape(node: ball, options: [
            SCNPhysicsShape.Option.collisionMargin: 0.01
        ])
        let body = SCNPhysicsBody(type: .dynamic, shape: shape)
        ball.physicsBody = body
        
        let transform = frame.camera.transform
        ball.simdTransform = transform
        
        let power = Float(10)
        let cameraTransform = SCNMatrix4(transform)
        
        var force = SCNVector3()
        force.x = -cameraTransform.m31 * power
        force.y = -cameraTransform.m32 * power
        force.z = -cameraTransform.m33 * power
        
        ball.physicsBody?.applyForce(force, asImpulse: true)
        
        sceneView.scene.rootNode.addChildNode(ball)
    }
    
    
    func addHoop(result: ARHitTestResult) {
        let scene = SCNScene(named: "art.scnassets/Hoop.scn")!
        
        guard let node = scene.rootNode.childNode(withName: "Hoop", recursively: false) else {
            return
        }
        
        let shape = SCNPhysicsShape(node: node, options: [
            SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron
        ])
        node.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        
        node.simdTransform = result.worldTransform
        node.eulerAngles.x -= .pi / 2
        
        sceneView.scene.rootNode.enumerateChildNodes { node, _ in
            if node.name == "Wall" {
                node.removeFromParentNode()
            }
        }
        
        hoopAdded = true
        sceneView.scene.rootNode.addChildNode(node)
    }
    
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
    
}
