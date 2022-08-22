//
//  LogsModel.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-08.
//

import Foundation


struct LogsDBModel {
    var name: String
    var rideFromTo :String
    var ridePassenger: String
    var rideDescription: String
    var rideTime: String
    var contact: String
    // id which is set from firebase to uniquely identify it
    var uniqueId:String
}
