//
//  SceneView.swift
//  Pong
//
//  Created by vojta on 05.03.2022.
//

import Cocoa

class SceneView: NSView {
    
    var main: Main!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        main = Main(scene: self, gameType: .playerVSbot)
    }
    
    let color: NSColor = .green
    let bgColor: NSColor = .black
    
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        let context = NSGraphicsContext.current?.cgContext
        
        context?.setFillColor(bgColor.cgColor)
        context?.fill(bounds)
        
        context?.setFillColor(color.cgColor)
        
        //context?.fill(CGRect(x: main.puck.x, y: main.puck.y, width: main.puck.radius, height: main.puck.radius))
        context?.fillEllipse(in: CGRect(x: main.puck.x, y: main.puck.y, width: main.puck.radius, height: main.puck.radius))
        
        context?.fill(CGRect(x: main.player1.x, y: main.player1.y, width: main.player1.width, height: main.player1.height))
                
        context?.fill(CGRect(x: main.player2.x, y: main.player2.y, width: main.player2.width, height: main.player2.height))
        
        context?.fill(CGRect(x: bounds.midX - 1, y: bounds.minY, width: 2, height: bounds.height))
        
        for point in 0..<main.player1.score {
            context?.fill(CGRect(x: 50 + CGFloat(point) * 25, y: bounds.maxY - 100, width: 10, height: 50))
        }
        
        for point in 0..<main.player2.score {
            context?.fill(CGRect(x: bounds.maxX - 50 - CGFloat(point) * 25, y: bounds.maxY - 100, width: 10, height: 50))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
