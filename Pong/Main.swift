//
//  Main.swift
//  Pong
//
//  Created by vojta on 05.03.2022.
//

import Foundation
import AppKit

final class Main {
    
    private var scene: SceneView
    
    public init(scene: SceneView, gameType: GameType) {
        self.scene = scene
        
        let height = 100.0
        let width = 25.0
        
        player1 = Player(x: 50, y: (scene.bounds.height - height) / 2 , height: height, width: width)
        player2 = Player(x: 50, y: (scene.bounds.height - height) / 2 , height: height, width: width)
        
        self.gameType = gameType
        
        dx = speed
        dy = speed
        
        NotificationCenter.default.addObserver(forName: .keyDOWN, object: nil, queue: .main) { [weak self] notification in
            guard let self = self else { return }
            guard let object = notification.object as? UInt16 else { return }
            let speed = self.speed
            switch object {
            case 126:  self.player2.dy = speed
            case 125:  self.player2.dy = -speed
            case 13: if gameType == .playerVSplayer { self.player1.dy = speed }
            case 1: if gameType == .playerVSplayer { self.player1.dy = -speed }
            case 49: if self.gameover { self.resetPositions() }
            default: break
            }
        }
        
        NotificationCenter.default.addObserver(forName: .keyUP, object: nil, queue: .main) { [weak self] notification in
            guard let self = self else { return }
            guard let object = notification.object as? UInt16 else { return }
            switch object {
            case 126:  self.player2.dy = 0
            case 125:  self.player2.dy = 0
            case 13: if gameType == .playerVSplayer { self.player1.dy = 0 }
            case 1: if gameType == .playerVSplayer { self.player1.dy = 0 }
            default: break
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resetPositions()
        }
    }
    
    public var puck = Puck(x: 1, y: 0, radius: 15)
    
    private var position: CGFloat {
        (scene.bounds.height - 100) / 2
    }
    
    private var dy = 0.0
    private var dx = 0.0
    
    public var player1: Player
    public var player2: Player
    
    private var gameType: GameType
    
    private var gameover = false
    
    private var prevStart: Start = .player1
    
    private func resetPositions() {
        if prevStart == .player2 {
            prevStart = .player1
            puck = Puck(x: scene.bounds.maxX - (puck.radius + 20), y: 0, radius: 15)
            dx = -speed
        }else{
            prevStart = .player2
            puck = Puck(x: 1, y: 0, radius: 15)
            dx = speed
        }
        
        player1.y = position
        player2.y = position
        
        dy = speed
        
        multiplier = 1.0
        
        gameover = false
        
        main()
    }
    
    private var speed = 3.0
    
    private var multiplier = 1.0
    
    private func main() {
        
        if puck.x < 0 {
            print("player2 wins")
            player2.score += 1
            gameover = true
            return
        }

        if puck.x > scene.bounds.maxX - puck.radius {
            print("player1 wins")
            player1.score += 1
            gameover = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.002) {
            self.main()
        }
        
        
        if gameType == .playerVSbot {
            if puck.y > player1.y {
                player1.dy = speed
            }else if puck.y < player1.y {
                player1.dy = -speed
            }
        }
        
        let range1 = (50)...(50 + player1.width)
        let range2 = (scene.bounds.maxX - puck.radius - (50 + player2.width))...(scene.bounds.maxX - puck.radius - 50)
        
        if range1.contains(puck.x) && touching(player1) {
            dx = speed
            multiplier = setTheMultiplier(player1)
            dy = -speed * multiplier
        }else if range2.contains(puck.x) && touching(player2) {
            dx = -speed
            multiplier = setTheMultiplier(player2)
            dy = -speed * multiplier
        }
        
        if puck.y < 0 {
            dy = -dy
        }else if puck.y > scene.bounds.maxY - puck.radius {
            dy = -dy
        }
            
        puck.x += dx
        puck.y += dy
        
        player1.y += player1.dy
        
        player2.x = scene.bounds.width - (50 + player2.width)
        player2.y += player2.dy
        
        scene.needsDisplay = true
    }
    
    private func touching(_ player: Player) -> Bool {
        let minY = player.y - puck.radius
        let maxY = player.y + player.height
        let range = minY...maxY
        return range.contains(puck.y)
    }
    
    private func setTheMultiplier(_ player: Player) -> CGFloat {
        let playerCenter = player.y + player.height / 2
        let puckCenter = puck.y + puck.radius / 2
        
        return (playerCenter - puckCenter) / 40
    }
    
}
