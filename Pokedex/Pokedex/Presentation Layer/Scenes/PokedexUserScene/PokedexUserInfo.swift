//
//  PokedexUserInfo.swift
//  Pokedex
//
//  Created by durgesh-10379 on 28/09/21.
//

import UIKit

class PokedexUserInfo: UIView {
    
    
    func userInfo(with userInfo: AppUser) {
        guard let win = BattleStats.battleWin else { return }
        guard let lose = BattleStats.battleLose else { return }
        guard let draw = BattleStats.battleDraw else { return }
        guard let total = BattleStats.totalBattles else { return }
        
        imageInfoView.image = UIImage(named: "PokedexUserIcon")
        
        configureLabel(label: winLabel, title: "Battle Wins", details: "\(win)")
        configureLabel(label: loseLabel, title: "Battle Loses", details: "\(lose)")
        configureLabel(label: drawLabel, title: "Battle Draw", details: "\(draw)")
        configureLabel(label: totalBattlesLabel, title: "Total Battles", details: "\(total)")
    }
    
    
    let winLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let loseLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let drawLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let totalBattlesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let imageInfoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title):  ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.mainPink()]))
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black]))
        label.attributedText = attributedText
    }
    
    func configureUserComponents() {
        backgroundColor = .white
        self.layer.masksToBounds = true
        
        
        addSubview(imageInfoView)
        imageInfoView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        imageInfoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let separatorView = UIView()
        separatorView.backgroundColor = .mainPink()
        addSubview(separatorView)
        separatorView.anchor(top: imageInfoView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 1)
        
        addSubview(winLabel)
        winLabel.anchor(top: imageInfoView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(loseLabel)
        loseLabel.anchor(top: winLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        addSubview(drawLabel)
        drawLabel.anchor(top: loseLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(totalBattlesLabel)
        totalBattlesLabel.anchor(top: drawLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}
