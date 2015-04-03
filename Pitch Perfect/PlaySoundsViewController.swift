//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marvin T. on 4/2/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            var filePathURL = NSURL(fileURLWithPath: filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
        } else {
            println("empty filepath")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playSlowAudio(sender: UIButton) {
        // play audio slooowly here.
        audioPlayer.play()
    }
}
