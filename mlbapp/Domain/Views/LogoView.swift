//
//  TeamIconView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import SwiftUI

struct LogoView: View {
    
    @StateObject private var viewModel: LogoViewModel
    @EnvironmentObject private var logoService: MLBLogoService

    private let size: CGSize = CGSize(width: 46, height: 46)
    private let showLogo = true
    
    init(teamID: Int, teamAbbreviation: String) {
        _viewModel = StateObject(wrappedValue: LogoViewModel(teamID: teamID, abbreviation: teamAbbreviation))
    }
    
    var body: some View {
        Group {
            if showLogo {
                logo
            } else {
                Text(viewModel.abbreviation)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color(hex: viewModel.team.primaryColor))
                            .frame(width: size.width, height: size.height)
                    )
                    .frame(width: size.width, height: size.height)
            }
        }
        .onAppear {
            viewModel.logoService = logoService
            viewModel.loadLogoData()
        }
    }
    
    @ViewBuilder
    var logo: some View {
        if let logoData = viewModel.logoData {
            SVGView(data: logoData)
                .scaledToFit()//.aspectRatio(viewModel.team.logoAspectRatio, contentMode: .fit)
                .frame(width: size.width, height: size.height)
        } else {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: size.width, height: size.height)
        }
    }
}

struct TeamIconView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(teamID: 119, teamAbbreviation: "LAD")
    }
}
