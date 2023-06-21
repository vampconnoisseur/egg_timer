//
//  ViewController.swift
//  Egg Timer
//
//  Created by Jaiditya Batra on 21/06/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            progressBar.progress = 0
        }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        progressBar.progress = 0
        
        textLabel.text = "Cookin it \(hardness)..."
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerAction(){
        if secondsPassed < totalTime{
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
            if(secondsPassed == totalTime){
                textLabel.text = "Done."
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
        else{
            timer.invalidate()
        }
    }
}

