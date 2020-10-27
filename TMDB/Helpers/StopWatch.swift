//
//  StopWatch.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import Foundation

struct StopWatch {

    var totalSeconds: Int

    var years: Int {
        return totalSeconds / 31536000
    }

    var days: Int {
        return (totalSeconds % 31536000) / 86400
    }

    var hours: Int {
        return (totalSeconds % 86400) / 3600
    }

    var minutes: Int {
        return (totalSeconds % 3600) / 60
    }

    var seconds: Int {
        return totalSeconds % 60
    }

    //simplified to what OP wanted
    var hoursMinutesAndSeconds: (hours: Int, minutes: Int, seconds: Int) {
        return (hours, minutes, seconds)
    }
}
