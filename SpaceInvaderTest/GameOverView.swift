//
//  GameOverView.swift
//  SpaceInvaderTest
//
//  Created by Muhammad Rezky on 09/05/23.
//

import SwiftUI
import SpriteKit

struct GameOverView: View {
    @ObservedObject var gameController: GameController
    
    var body: some View {
        VStack{
            Spacer().frame(height: UIScreen.main.bounds.height * 0.2)
            Text("GAME\nOVER")
                .font(.custom("VT323-Regular", size: 100))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
            HStack{
                Image("coin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                Spacer().frame(width: 16)
                Text("\(gameController.score)")
                    .font(.custom("VT323-Regular", size: 72))
                    .foregroundColor(Color.yellow)
            }.offset(CGSize(width: 0, height: -32))
            Spacer()
            Button{
                gameController.restart()
                gameController.gameOver = false
            } label: {
                Text("Restart")
                    .font(.custom("VT323-Regular", size: 60))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .border(.white)
            }
            Spacer().frame(height: 16)
            Button {
                gameController.play = false
            } label: {
                Text("back to home")
                    .font(.custom("VT323-Regular", size: 24))
                    .foregroundColor(Color.white)
            }
            Spacer().frame(height: 100)
            
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
        .background(
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .ignoresSafeArea()
//        VStack {
//            Text("Game Over")
//            Button{
//
//                gameController.restart()
//            } label: {
//                Text("Restart")
//            }
//        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(gameController: GameController())
    }
}
