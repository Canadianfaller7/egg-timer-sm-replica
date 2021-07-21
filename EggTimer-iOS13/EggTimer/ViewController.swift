//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
    @IBOutlet weak var progressBar: UIProgressView!
    
    // just a code so we can change the title label later
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // this is a dictionary containing the minutes it takes to cook each egg
    let eggTimes = [
        "Soft": 300, "Medium": 420, "Hard": 720
    ]
    
    var totalTime = 0
    var secondsPassed = 0
    
    
    // this is a timer var that we will use a little bit below
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // makes it so when we click a new button it will stop the other timer and then run the new one without
        timer.invalidate()
        
        // here we are having hardness = one of the 3 buttons that gets pressed and to print its current title like "Soft" or "Medium"
        let hardness = sender.currentTitle!
        
        // here secondsRemaining equals the dictionary with the result from the code above which will tell us which button was pressed and it will tell us the Int value inside the button that was pressed in seconds
        totalTime = eggTimes[hardness]!
        
        // this will reset the progress bar back down to 0
        progressBar.progress = 0.0
        
        // this resets the seconds passed back to 0
        secondsPassed = 0
        
        // this resets the label again for you
        titleLabel.text = hardness
        
        // don't need to understand all of this but this is the code to get a timer. the timeInterval is wanting us to know how many seconds it should run so here every second and the repeats is true because we want the timer to keep counting down
        
        // setting this code to the timer var above
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    // the @objc lets us use this timer code that was originally for object-c without our code having an error.
    @objc func updateCounter() {
        
        // this is saying if secondsPassed is less than totalTime to run the precentageProgress secondsPassed divded by totalTime
        if secondsPassed < totalTime {
            
            // this takes the secondsPassed and will count up towards the totalTime
            secondsPassed += 1// by moving this above the code below it actually makes it so we can have the timer go all the way to the totalTime and not stopping short as it would if it were below
          
            // this is what will show our percentage bar go up
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            // this says once the timer is done counting print DONE!
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            func playSound() {
            
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
           
            do{
                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try! AVAudioSession.sharedInstance().setActive(true)
                
                player = try! AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
                
                player.play() } }
            playSound()
        }
    }
}
