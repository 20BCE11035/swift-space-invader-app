//
//  ContentView.swift
//  SpaceInvaderTest
//
//  Created by Muhammad Rezky on 08/05/23.
//

import SpriteKit
import ARKit

import SwiftUI


struct PlayView: View {
    @ObservedObject var gameController:GameController
    var body: some View {
        ZStack(alignment: .top){
            SpriteView(scene: gameController.scene!)
                .ignoresSafeArea()
                .onAppear{
                    // add gameController to controller inside game
                    if let gameScene = gameController.scene as? GameScene {
                        gameScene.controller = gameController
                    }
                }
            HStack{
                HStack{
                    Image("coin")
                    Text("\(gameController.score)")
                        .foregroundColor(.white)
                }
                Spacer()
                if(gameController.life >= 0){
                    HStack {
                        ForEach(0..<Int(gameController.life), id: \.self) { _ in
                            Image( "heart-full")
                        }
                        if gameController.life.truncatingRemainder(dividingBy: 1) == 0.5 {
                            Image("heart-half")
                        }
                        ForEach(0..<Int(3-gameController.life), id: \.self) { _ in
                            Image("heart-empty")
                        }
                    }
                }
            }.padding(16)
                .padding(.top, 32)
            
        }
        
        .ignoresSafeArea()
        
    }
    
}

//struct PlatView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayView(gameController: GameController())
//    }
//}
