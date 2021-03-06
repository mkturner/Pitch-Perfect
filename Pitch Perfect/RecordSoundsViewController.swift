//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marvin T. on 4/1/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

//import necessary frameworks
import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    //declare some outlets to use for manipulating the app
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    //create object for the recorder
    var audioRecorder:AVAudioRecorder!
    
    //create object to save audio
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Enter code to be run RIGHT before view appears (show/hide)
        tapToRecord.hidden = false
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // hide text "Tap to Record..."
        tapToRecord.hidden = true
        
        // Show text "recording in progress"
        recordingInProgress.hidden = false
        stopButton.hidden = false
        pauseButton.hidden = false
        pauseButton.enabled = true
        resumeButton.hidden = false
        resumeButton.enabled = false
        recordButton.enabled = false
        
        // print info to console, tell what's happening
        println("in recordAudio")
        
        // Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        /* Use current Date-Time to format a file name for the recording
            should be unique identifier.
        Combine dirPath and recordingName to get complete filePath.
        Print filePath to console to verify.
        */
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath!)
        
        // Create a recording session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // Final setup, begin recording
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self // make this class the delegate of AVAudioRecorder
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    @IBAction func pauseAudio(sender: UIButton) {
        audioRecorder.pause()
        resumeButton.enabled = true
        pauseButton.enabled = false
    }
    
    @IBAction func resumeAudio(sender: UIButton) {
        audioRecorder.record()
        pauseButton.enabled = true
        resumeButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
            // Step 1 - Save recorded audio
            recordedAudio = RecordedAudio(raurl: recorder.url, ratitle: recorder.url.lastPathComponent)
            // Step 2 - Perform segue to transition to next  screen
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func doneRecording(sender: UIButton) {
        // Hide "recording in progress"
        recordingInProgress.hidden = true
        recordButton.enabled = true
        // Stop Recording
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        println("done recording\n")
    }
}

