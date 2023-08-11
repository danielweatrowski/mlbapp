//
//  SVGView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/12/23.
//

import SwiftUI
import Common

struct SVGView: UIViewRepresentable {
    
    let data: Data
    let size: CGSize = CGSize(width: 36, height: 36)
    
    func makeUIView(context: Context) -> UIImageView {
        let svg = SVG(data)
        let imageView = UIImageView(image: svg?.image())
        
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
           
        return imageView
    }
 
    func updateUIView(_ uiView: UIImageView, context: Context) {}
}
