//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Marvin T. on 4/1/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // TODO: Show text "recording in progress"
        recordingInProgress.hidden = false
        // TODO: Record the user's voice
        println("in recordAudio")
    }

    @IBAction func doneRecording(sender: UIButton) {
        // TODO: Hide "recording in progress"
        recordingInProgress.hidden = true
        // TODO: Save and store Recorded audio
    }
}

