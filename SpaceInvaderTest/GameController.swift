//
//  GameController.swift
//  SpaceInvaderTest
//
//  Created by Muhammad Rezky on 08/05/23.
//

import SwiftUI
import SpriteKit

class GameController: ObservableObject {
    @Published var scene = SKScene(fileNamed: "GameScene.sks")
    @Published var play : Bool = false
    @Published var gameOver: Bool = false
    @Published var life: Double = 3
    @Published var score: Int = 0
    @Published var weapon: Int = 0
    
    func restart() {
        scene  = SKScene(fileNamed: "GameScene.sks")
        score = 0
        life = 3
        weapon = 0
        gameOver = false
        
    }
    func respawn() {
        scene  = SKScene(fileNamed: "GameScene.sks")
        if let gameScene = scene as? GameScene {
            gameScene.controller = self
        }
        
    }
}
