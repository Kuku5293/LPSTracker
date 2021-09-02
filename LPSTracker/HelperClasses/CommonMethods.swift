//
//  CommonMethods.swift
//  LPSTracker
//
//  Created by Krutika on 31/08/21.
//

import Foundation

///Return tracker status running true/false
func getTrackerStatus() -> Bool {
    return UserDefaults.standard.bool(forKey: TRCAKER_STARTED)
}

///Set tracker status started true/false
func setTrackerStatus(started: Bool) {
    UserDefaults.standard.set(started, forKey: TRCAKER_STARTED)
}

///Save trcaker starting time
func saveTrackerStartTime(time: Date) {
    UserDefaults.standard.set(time, forKey: TRCAKER_START_TIME)
}

///Return tracker start time
///Default current time
func getTrackerStartTime() -> Date {
    guard let time = UserDefaults.standard.value(forKey: TRCAKER_START_TIME) as? Date else { return Date() }
    return time
}

///Save trcaker end time
func saveTrackerEndTime(time: Date) {
    UserDefaults.standard.set(time, forKey: TRCAKER_END_TIME)
}

///Return tracker end time
///Default current time
func getTrackerEndTime() -> Date {
    guard let time = UserDefaults.standard.value(forKey: TRCAKER_END_TIME) as? Date else { return Date() }
    return time
}

///Fire notification
public func fireNotificationWith(name: Notification.Name, userInfo: [AnyHashable: Any]) {
    NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
}

///Display timer countdown 
func timeFormatted(_ totalSeconds: Int) -> String {
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    let hours: Int = (totalSeconds / 3600)
    return String(format: TRACKER_DISPLAY_FORMAT, hours, minutes, seconds)
}
