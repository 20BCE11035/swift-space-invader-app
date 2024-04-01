//
//  GameView.swift
//  SpaceInvaderTest
//
//  Created by Muhammad Rezky on 13/05/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameController: GameController
    var body: some View {
        NavigationView{
            if(!gameController.gameOver){
                PlayView(gameController: gameController)
                
            } else {
                GameOverView(gameController: gameController)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
