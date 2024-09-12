//
// File: HealthKitManager.swift
// Project: StepTracker
// 
// Created by SCOTT CROWDER on 8/14/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Foundation
import HealthKit
import Observation

@Observable
class HealthKitManager {
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
    
    
}
