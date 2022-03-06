//
//  MainWindow.swift
//  Pong
//
//  Created by vojta on 05.03.2022.
//

import Cocoa

class MainWindow: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
    }

    override func keyDown(with event: NSEvent) {
        NotificationCenter.default.post(name: .keyDOWN, object: event.keyCode)
    }
    
    override func keyUp(with event: NSEvent) {
        NotificationCenter.default.post(name: .keyUP, object: event.keyCode)

    }
    
}
