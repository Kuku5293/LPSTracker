//
//  Timer.swift
//  LPSTracker
//
//  Created by Krutika on 31/08/21.
//
import UIKit

class GlobalTimer: NSObject {
    static let sharedTimer: GlobalTimer = {
           let timer = GlobalTimer()
            return timer
        }()
    
    var internalTimer: Timer?
    var GPSTimer: Timer?
    
    func startTimer(){        
        if getTrackerStatus() == true {
            internalTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimerAction), userInfo: nil, repeats: true)
        } else {
            if internalTimer != nil {
                internalTimer?.invalidate()
            }
            internalTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimerAction), userInfo: nil, repeats: true)
            setTrackerStatus(started: true)
            saveTrackerStartTime(time: Date())
        }
    }
    
    func stopTimer(){
        saveTrackerEndTime(time: Date())
        if internalTimer != nil {
            internalTimer?.invalidate()
        }
        setTrackerStatus(started: false)
    }
    
    @objc func fireTimerAction(sender: AnyObject?){
        let start = getTrackerStartTime()
        let end = Date()
        let timespan = end.seconds(from: start)
        let userInfo = [TIME_SPAN: timespan]
        if internalTimer != nil {
            fireNotificationWith(name: NOTIFICATION_CURRENT_TIMER, userInfo: userInfo)
        }
        print(userInfo)
    }
}
