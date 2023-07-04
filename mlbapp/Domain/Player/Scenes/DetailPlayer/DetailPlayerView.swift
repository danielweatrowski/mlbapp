//
//  DetailPlayerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import SwiftUI

struct DetailPlayerView: View {
    
    @ObservedObject var viewModel: DetailPlayerViewModel
    var interactor: DetailPlayerBusinessLogic
    
    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                Spacer()
                    .frame(width: 50, height: 50)
                
                AsyncImage(url: viewModel.headShotURL) { image in
                    image.resizable()
                } placeholder: {
                    PlayerHeadshotPlaceholder()
                }
                .frame(width: 150, height: 225)
                .cornerRadius(10)
                
                Text(viewModel.number)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 50, height: 50)
                    .background(Color(hex: viewModel.teamColorAsHex))
                    .cornerRadius(25)
            }
            
            Text(viewModel.fullName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(viewModel.nickname)
                .foregroundColor(.secondary)
                .font(.headline)
        }
        .onAppear() {
            interactor.getPlayer(request: DetailPlayer.Request())
        }
    }
}

struct DetailPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailPlayerViewModel()
        let presenter = DetailPlayerPresenter(viewModel: viewModel)
        let interactor = DetailPlayerInteractor(personID: 571448, presenter: presenter)
        DetailPlayerView(viewModel: viewModel, interactor: interactor)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
