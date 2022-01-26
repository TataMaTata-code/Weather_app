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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cityNameOrTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    var didSelectedRow: (()->())?
    private var skView: SKView { backgroundView as! SKView }
    private var scene = SKScene()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView?.frame = backgroundView?.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)) ?? CGRect()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSkView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        scene.removeAllChildren()
    }
    
    private func addSkView() {
        let skView = SKView(frame: self.frame)
        backgroundView = skView
    }
    
    func configBackground(fileName: String, color: String) {
        scene = SKScene(size: self.frame.size)
        skView.addCornerRadius(contentView: skView, cornerRadius: skView.frame.height / 6.5, borderWidth: 0, color: .clear)
        skView.presentScene(scene)
        
        guard let node = SKSpriteNode(fileNamed: fileName) else { return }
        node.position = CGPoint(x: self.frame.width + 100,
                                y: self.frame.height)
        scene.backgroundColor = UIColor(hex: color) ?? .white
        scene.addChild(node)
    }
    
    @IBAction func actionShowWeather(_ sender: Any) {
        didSelectedRow?()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentLocationTableViewCell", bundle: nil)
    }
}
