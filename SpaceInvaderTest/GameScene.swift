//
//  GameScene.swift
//  SpaceInvaderTest
//
//  Created by Muhammad Rezky on 08/05/23.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var controller: GameController?

    var player = SKSpriteNode(imageNamed: "PlayerShip")
    var aliensArray = [SKNode]()
    var enemies = [SKNode]()

    
    var fireTexture = SKTexture(imageNamed: "fire")
    enum bitMask: UInt32 {
        case player = 0b1
        case fire = 0b100
        case alien = 0b10
        case alienFire = 0b1000
        case weapon = 0b10000
    }
    var fireTimer = 60
    
    
    
    
    
    func respawn(){
        controller?.respawn()
        
        self.view?.presentScene(controller?.scene)
        

    }

    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 750, height: 1334)
        scene?.scaleMode = .aspectFill
        
        physicsWorld.contactDelegate = self
        
        for node in self.children{
            if node.name == "alien"{
                aliensArray.append(node)
            }
        }
        
        addPlayer()
    }
    
    func fire(level: Int){
            switch level {
            case 1:
                fire(position: CGPoint(x: player.position.x + 25, y: player.position.y))
                fire(position: CGPoint(x: player.position.x, y: player.position.y))
                fire(position: CGPoint(x: player.position.x - 25, y: player.position.y))
            default:
                fire(position: player.position)
        }
    }
    
    
    func dropWeapon(position: CGPoint){
        let weapon = SKSpriteNode(imageNamed: "weapon1")
        weapon.position = position
        weapon.zPosition = 50
        weapon.physicsBody = SKPhysicsBody(rectangleOf: weapon.size)
        weapon.setScale(0.3)
        
        weapon.physicsBody?.affectedByGravity = false
        weapon.physicsBody?.allowsRotation = false
        weapon.physicsBody?.categoryBitMask = bitMask.weapon.rawValue
        weapon.physicsBody?.contactTestBitMask = bitMask.player.rawValue
        weapon.physicsBody?.collisionBitMask = bitMask.player.rawValue
        
        let weaponAction = SKAction.moveTo(y: -UIScreen.main.bounds.height/2, duration: 2)
        let removeAction =  SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([weaponAction, removeAction])
        weapon.run(sequence)
        addChild(weapon)
    }
    
    
    func fire(position: CGPoint){
        let fire = SKSpriteNode(imageNamed: "fire")
        fire.position = position
//        fire.position.x = player.position.x
//        fire.position.y = player.position.y + 5
        fire.zPosition = 50
        fire.physicsBody = SKPhysicsBody(texture: fireTexture, size: fire.size)
        fire.physicsBody?.affectedByGravity = false
        fire.physicsBody?.allowsRotation = false
        fire.physicsBody?.categoryBitMask = bitMask.fire.rawValue
        fire.physicsBody?.contactTestBitMask = bitMask.alien.rawValue
        fire.physicsBody?.collisionBitMask = bitMask.alien.rawValue
        
        
        let fireAction = SKAction.moveTo(y: 850, duration: 2)
        let removeAction =  SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([fireAction, removeAction])
        fire.run(sequence)
        addChild(fire)
        
    }
    
    func alienFire(){
        let alienFire = SKSpriteNode(imageNamed: "fire")
        
        let randomNumber: Int = Int (arc4random_uniform(UInt32 (aliensArray.count)))
        if (aliensArray.count < randomNumber) {
            let alien = aliensArray[randomNumber]
            
            alienFire.position = alien.position
            alienFire.zPosition = 50
            alienFire.physicsBody = SKPhysicsBody(texture: fireTexture, size: alienFire.size)
            alienFire.physicsBody?.affectedByGravity = false
            alienFire.physicsBody?.allowsRotation = false
            alienFire.physicsBody?.categoryBitMask = bitMask.alienFire.rawValue
            alienFire.physicsBody?.contactTestBitMask = bitMask.player.rawValue
            alienFire.physicsBody?.collisionBitMask = bitMask.player.rawValue
            
            

            
            let fireAction = SKAction.moveTo(y: -size.height, duration: 2)
            let removeAction =  SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([fireAction, removeAction])
            alienFire.run(sequence)
            addChild(alienFire)
        }
        
    }
    
    
    func addPlayer(){
        player.position = CGPoint(x: 0, y: -size.height/2 + 200)
        player.zPosition = 100
        player.setScale(0.4)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = bitMask.player.rawValue
        player.physicsBody?.contactTestBitMask = bitMask.alienFire.rawValue | bitMask.alien.rawValue
        player.physicsBody?.collisionBitMask = bitMask.alienFire.rawValue | bitMask.alien.rawValue
        
        
        addChild(player)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.position.x = location.x
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if self.nodes(at: location).contains(player) {
                fire(level: controller!.weapon)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody
        let contactB: SKPhysicsBody
        
        let randomAlienDroppedWeapon = Int (arc4random_uniform(UInt32 (aliensArray.count)))

        
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            contactA = contact.bodyA
            contactB = contact.bodyB
        } else {
            contactA = contact.bodyB
            contactB = contact.bodyA
        }
        
        if contactA.categoryBitMask == bitMask.player.rawValue && contactB.categoryBitMask == bitMask.alien.rawValue {
            print("end")
            controller?.gameOver = true
        }
        
        
        if contactA.categoryBitMask == bitMask.player.rawValue && contactB.categoryBitMask == bitMask.weapon.rawValue {
            print("weapon equipped")
            controller?.weapon = 1
        }
        
        if contactA.categoryBitMask == bitMask.player.rawValue && contactB.categoryBitMask == bitMask.alienFire.rawValue {
            particle(position: contactA.node!.position)
            controller?.life -= 0.5
        }
        
        if contactA.categoryBitMask == bitMask.alien.rawValue && contactB.categoryBitMask == bitMask.fire.rawValue{
            if(contactA.node != nil){
                particle(position: contactA.node!.position)
            }
            
            controller!.score += 1
            print(controller!.score)
            
            for node in aliensArray {
                if node == contactA.node {
                    if(randomAlienDroppedWeapon == aliensArray.firstIndex(of: node)){
                        dropWeapon(position: node.position)
                    }
                    aliensArray.remove(at: aliensArray.firstIndex(of: node)!)
                }
            }
            contactA.node?.removeFromParent()
            contactB.node?.removeFromParent()
        }
        
        
    }
    func particle(position: CGPoint){
        let particle = SKEmitterNode(fileNamed: "fireParticle.sks")
        particle?.position = position
        particle?.zPosition = 25
        particle?.setScale(0.5)
        
        addChild(particle!)
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        print(aliensArray.count, "count")
        if(aliensArray.count == 0){
            print("habis")
            respawn()
        }
        fireTimer -= 1
        if fireTimer == 0 {
            alienFire()
            fireTimer = 60
        }
        if(controller!.life < 0.0){
            controller?.gameOver = true
        }
    }
}
