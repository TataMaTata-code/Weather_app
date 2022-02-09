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
    @IBOutlet weak var containerView: UIView!
    
    var didSelectedRow: (()->())?
    private var skView: SKView { backgroundView as! SKView }
    private var scene = SKScene()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configBackgroundView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSkView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        scene.removeAllChildren()
    }
    
    private func configBackgroundView() {
        let cornerRadius: CGFloat = 18

        backgroundView?.addCornerRadius(contentView: backgroundView ?? UIView(), cornerRadius: cornerRadius)
        backgroundView?.frame = backgroundView?.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)) ?? CGRect()
    }
    
    private func addSkView() {
        let skView = SKView(frame: self.frame)
        backgroundView = skView
    }
    
    func configurateBackground(with model: BackgroundModel) {
        scene = SKScene(size: self.frame.size)
//        skView.addCornerRadius(contentView: skView, cornerRadius: cornerRadius)
        skView.presentScene(scene)
       
        let beginColor = UIColor(hex: model.beginColor) ?? .clear
        let endColor = UIColor(hex: model.endColor) ?? .clear
        
        let texture = SKTexture(image: imageWithGradient(from: beginColor, to: endColor, with: self.frame))
        let background = SKSpriteNode(texture: texture)
        background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        scene.addChild(background)
        
        if let node = SKSpriteNode(fileNamed: model.node) {
            node.position = CGPoint(x: self.frame.width + 80,
                                    y: self.frame.height)
            scene.addChild(node)
        }
        
        if let node2 = SKSpriteNode(fileNamed: model.secondNode) {
            node2.position = CGPoint(x: -self.frame.width,
                                     y: self.frame.height)
            scene.addChild(node2)
        }
    }
    
    private func imageWithGradient(from beginColor: UIColor, to endColor: UIColor, with frame: CGRect) -> UIImage {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = [beginColor.cgColor, endColor.cgColor]
        UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height))
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage()}
        layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    @IBAction func actionShowWeather(_ sender: Any) {
        didSelectedRow?()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentLocationTableViewCell", bundle: nil)
    }
}
