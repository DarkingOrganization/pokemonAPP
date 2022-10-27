//
//  GradieteModel.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 27/10/22.
//

import UIKit

struct GradieteModel {
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.init(named: "greenCustom")?.cgColor ?? "green",
            UIColor.init(named: "blueCustom")?.cgColor ?? "blue"
        ]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
}
