//
//  Coordinator.swift
//  Udemyproject1
//
//  Created by Sabrina on 8/29/23.
//

import Foundation
import ARKit
import RealityKit
import Combine

class Coordinator: NSObject {
    
    //weak because dont want to create a reference, or retain an actual view created in content view
    weak var view: ARView?
    var cancellable: AnyCancellable?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        //decorate w property wrapper hat of obj c bc when registering handle
        //tap uses selective base registrator, part of obj c language
        
        //get access to view on which you're tapping
        guard let view = self.view else {return}
        
        let tapLocation = recognizer.location(in: view)
        
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
            
            let anchor = AnchorEntity(raycastResult: result)
            
            cancellable = ModelEntity.loadAsync(named: "teapot")
                .sink { loadCompletion in
                    if case let .failure(error) = loadCompletion {
                        print("Unable to load model \(error)")
                    }
                    
                    self.cancellable?.cancel()
                    
                } receiveValue: { entity in
                    anchor.addChild(entity)
                }
        
            view.scene.addAnchor(anchor)
            
            
            
        }
        
        
    }
    
}
