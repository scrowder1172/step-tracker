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
    
    func fetchStepCount() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        
        guard let endDate = calendar.date(byAdding: .day, value: 1, to: today) else { return }
        guard let startDate = calendar.date(byAdding: .day, value: -28, to: endDate) else { return }
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sampleType: HKQuantityType = HKQuantityType(.stepCount)
        let samplePredicate = HKSamplePredicate.quantitySample(type: sampleType, predicate: queryPredicate)
        
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate,
            options: .cumulativeSum,
            anchorDate: endDate,
            intervalComponents: .init(day: 1)
        )
        
        do {
            let stepCounts = try await stepsQuery.result(for: store)
            
            for steps in stepCounts.statistics() {
                print("Steps: \(steps.startDate) - \(steps.endDate) => \(steps.sumQuantity()!)")
            }
        } catch {
            print("Error getting step counts: \(error.localizedDescription)")
        }
    }
    
    func fetchWeightsCount() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        
        guard let endDate = calendar.date(byAdding: .day, value: 1, to: today) else { return }
        guard let startDate = calendar.date(byAdding: .day, value: -28, to: endDate) else { return }
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sampleType: HKQuantityType = HKQuantityType(.bodyMass)
        let samplePredicate = HKSamplePredicate.quantitySample(type: sampleType, predicate: queryPredicate)
        
        let weightsQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate,
            options: .mostRecent,
            anchorDate: endDate,
            intervalComponents: .init(day: 1)
        )
        
        do {
            let weightCounts = try await weightsQuery.result(for: store)
            
            for weights in weightCounts.statistics() {
                print("Weight: \(weights.startDate) => \(weights.mostRecentQuantity()!.doubleValue(for: .pound()))")
            }
        } catch {
            print("Error getting step counts: \(error.localizedDescription)")
        }
    }
}
