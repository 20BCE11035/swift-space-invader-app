//
//  HomeView.swift
//  SpaceInvaderTest
//
//  Created by Muhammad Rezky on 13/05/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var gameController: GameController = GameController()
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.2)
                    Image("PlayerShip")
                    Text("Space\nInvader")
                        .font(.custom("VT323-Regular", size: 46))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 64)
                    NavigationLink( destination: GameView(gameController: gameController), isActive: $gameController.play){
                        EmptyView()
                    }
                    Button{
                        gameController.restart()
                        gameController.play.toggle()
                    } label: {
                        Text("Play Now ")
                            .font(.custom("VT323-Regular", size: 32))
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .border(.white)
                    }
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                .background(
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                Image("alien1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .position(x: 50, y: 170)
                Image("alien2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70)
                    .position(x: UIScreen.main.bounds.width-50, y: 100)
            }
            .ignoresSafeArea()
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
