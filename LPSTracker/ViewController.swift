//
//  ViewController.swift
//  LPSTracker
//
//  Created by Krutika on 31/08/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var btnTracker: UIButton!
    @IBOutlet weak var btnTimeBar: UIButton!
    @IBOutlet weak var btnTrackerWidthConstraint: NSLayoutConstraint!
    
    //MARK: - App cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTimerBar()
    }

    //MARK: - IBAction methods
    @IBAction func btnTrackerTapped(_ sender: Any) {
        let alert = UIAlertController(title: MSG_START_TRACKER, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: START, style: .default, handler: { [self] _ in
            startTracker()
        }))
        alert.addAction(UIAlertAction(title: CANCEL, style: .default, handler: { [self] _ in
            view.endEditing(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnTimebarTapped(_ sender: Any) {
        let alert = UIAlertController(title: MSG_STOP_TRACKER, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: STOP, style: .default, handler: { [self] _ in
            stopTracker()
        }))
        alert.addAction(UIAlertAction(title: CANCEL, style: .default, handler: { [self] _ in
            view.endEditing(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Custom methods
extension ViewController {
    private func setupTimerBar() {
        if getTrackerStatus() == false {
            btnTrackerWidthConstraint.constant = 80
            btnTimeBar.isHidden = true
        } else {
            btnTrackerWidthConstraint.constant = 0
            btnTimeBar.isHidden = false
            if GlobalTimer.sharedTimer.internalTimer == nil {
                GlobalTimer.sharedTimer.startTimer()
            }
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showTrackedTime),
            name: NOTIFICATION_CURRENT_TIMER,
            object: nil)
    }
    
    @objc func showTrackedTime(notification: Notification) {
        let userinfo = (notification.userInfo ?? [:]) as Dictionary
        let timeSpan = userinfo[TIME_SPAN] as? Int
        
        let title = timeFormatted(timeSpan ?? 0)
        UIView.setAnimationsEnabled(false)
        btnTimeBar.setTitle(title, for: .normal)
        UIView.setAnimationsEnabled(true)
    }
    
    private func startTracker() {
        btnTrackerWidthConstraint.constant = 0
        btnTimeBar.isHidden = false
        GlobalTimer.sharedTimer.startTimer()
    }
    
    private func stopTracker() {
        btnTrackerWidthConstraint.constant = 80
        btnTimeBar.isHidden = true
        GlobalTimer.sharedTimer.stopTimer()
    }
}
