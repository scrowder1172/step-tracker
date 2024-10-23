//
// File: Ext+HealthKitManager.swift
// Project: StepTracker
// 
// Created by SCOTT CROWDER on 9/12/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
//
// This extension is only used to load mock data into the simulator.
// In order to run this code, uncomment the line below from DashboardView:
//                await hkManager.addSimulatorData()
//


import Foundation
import HealthKit

extension HealthKitManager {
    func addSimulatorData() async {
        var mockSamples: [HKQuantitySample] = []
        
        do {
            for i in 0..<28 {
                guard let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now) else { return }
                guard let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate) else { return }
                
                mockSamples.append(generateRandomStepData(startDate: startDate, endDate: endDate))
                mockSamples.append(generateRandomWeightData(startDate: startDate, endDate: endDate, dayCount: i))
            }
            
            try await store.save(mockSamples)
            print("✅ Dummy data sent up")
        } catch {
            print("Error generating sample step data: \(error.localizedDescription)")
        }
    }
    
    func generateRandomStepData(startDate: Date, endDate: Date) -> HKQuantitySample {
        let trackingType: HKQuantityType = HKQuantityType(.stepCount)
        let randomSteps: Double = Double.random(in: 4_000...20_000)
        let stepQuantity: HKQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: randomSteps)
        
        return HKQuantitySample(type: trackingType, quantity: stepQuantity, start: startDate, end: endDate)
    }
    
    func generateRandomWeightData(startDate: Date, endDate: Date, dayCount: Int) -> HKQuantitySample {
        let trackingType: HKQuantityType = HKQuantityType(.bodyMass)
        let randomWeight: Double = Double.random(in: (160 + Double(dayCount / 3))...(165 + Double(dayCount / 3)))
        let weightQuantity: HKQuantity = HKQuantity(unit: .pound(), doubleValue: randomWeight)
        
        return HKQuantitySample(type: trackingType, quantity: weightQuantity, start: startDate, end: endDate)
    }
}
