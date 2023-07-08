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
