//
//  ViewController.swift
//  Pong
//
//  Created by vojta on 05.03.2022.
//

import Cocoa

class ViewController: NSViewController {
    
    var scene = SceneView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scene)
        NSLayoutConstraint.activate([
            scene.rightAnchor.constraint(equalTo: view.rightAnchor),
            scene.topAnchor.constraint(equalTo: view.topAnchor),
            scene.leftAnchor.constraint(equalTo: view.leftAnchor),
            scene.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
