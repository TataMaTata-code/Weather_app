//
//  CurrentLocationTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/01/22.
//

import UIKit
import SpriteKit

class CurrentLocationTableViewCell: UITableViewCell {
    
    static let identifier = "CurrentLocationTableViewCell"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    func configBackgroud(fileName: String, color: String) {
        var skView: SKView { skView as! SKView }
        let scene = SKScene(size: skView.frame.size)
        skView.presentScene(scene)
        
        guard let node = SKSpriteNode(fileNamed: fileName) else { return }
        node.position = CGPoint(x: skView.frame.width + 100,
                                y: skView.frame.height + 30)
        scene.backgroundColor = UIColor(hex: color) ?? .white
        
        scene.addChild(node)
    }
    
    private func config() {
        contentView.addCornerRadius(contentView: self, cornerRadius: 15, borderWidth: 0, color: .clear)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentLocationTableViewCell", bundle: nil)
    }
}
