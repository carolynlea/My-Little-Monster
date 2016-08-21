//
//  MonsterImg.swift
//  MyLittleMonster
//
//  Created by Carolyn Lea on 8/21/16.
//  Copyright © 2016 Carolyn Lea. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView
{
    var chosenMonster:Int?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        playIdleAnimation()
        //playLeftMonsterIdleAnimation()
        //playRightMonsterIdleAnimation()
    }
    
    func playIdleAnimation()
    {
        //NSUserDefaults.standardUserDefaults().integerForKey("chosenMonster")
        
        if chosenMonster == 0
        {
            playLeftMonsterIdleAnimation()
        }
        else if chosenMonster == 1
        {
            playRightMonsterIdleAnimation()
        }
    }
    
    func playLeftMonsterIdleAnimation()
    {
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        self.image = UIImage(named: "idle1.png")
        
        for var x = 1; x <= 4; x += 1
        {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playRightMonsterIdleAnimation()
    {
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        self.image = UIImage(named: "pink_idle1.png")
        
        for var x = 1; x <= 4; x += 1
        {
            let img = UIImage(named: "pink_idle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation()
    {
        if chosenMonster == 0
        {
            playLeftMonsterDeathAnimation()
        }
        else if chosenMonster == 1
        {
            playRightMonsterDeathAnimation()
        }
    }
    
    func playLeftMonsterDeathAnimation()
    {
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        self.image = UIImage(named: "dead5.png")
        
        for var x = 1; x <= 5; x += 1
        {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    func playRightMonsterDeathAnimation()
    {
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        self.image = UIImage(named: "pink_dead3.png")
        
        for var x = 1; x <= 3; x += 1
        {
            let img = UIImage(named: "pink_dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    
    
    
    
    
    
    
    
    
    
}