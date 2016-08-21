//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Carolyn Lea on 8/20/16.
//  Copyright © 2016 Carolyn Lea. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var penalty1Image: UIImageView!
    @IBOutlet weak var penalty2Image: UIImageView!
    @IBOutlet weak var penalty3Image: UIImageView!
    
    @IBOutlet weak var restartButton: UIButton!
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        startGame()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject)
    {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        print("item dropped on character")
        
        if currentItem == 0
        {
            sfxHeart.play()
        }
        else
        {
            sfxBite.play()
        }
    }
    
    func startTimer()
    {
        if timer != nil
        {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState()
    {
        if !monsterHappy
        {
            penalties += 1
            sfxSkull.play()
            
            if penalties == 1
            {
                penalty1Image.alpha = OPAQUE
                penalty2Image.alpha = DIM_ALPHA
            }
            else if penalties == 2
            {
                penalty2Image.alpha = OPAQUE
                penalty3Image.alpha = DIM_ALPHA
            }
            else if penalties >= 3
            {
                penalty3Image.alpha = OPAQUE
            }
            else
            {
                penalty1Image.alpha = DIM_ALPHA
                penalty2Image.alpha = DIM_ALPHA
                penalty3Image.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES
            {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)
        
        if rand == 0
        {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        }
        else
        {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver()
    {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        restartButton.hidden = false
    }
    @IBAction func restartButtonTapped(sender: AnyObject)
    {
        restartGame()
    }
    
    func startGame()
    {
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1Image.alpha = DIM_ALPHA
        penalty2Image.alpha = DIM_ALPHA
        penalty3Image.alpha = DIM_ALPHA
        
        restartButton.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do
        {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")
            let url = NSURL(fileURLWithPath: resourcePath!)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
        
        
        startTimer()
    }
    
    func restartGame()
    {
        penalties = 0
        monsterImg.playIdleAnimation()
        startGame()
    }

}

