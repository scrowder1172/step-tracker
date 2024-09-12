//
// File: HealthMetric.swift
// Project: StepTracker
// 
// Created by SCOTT CROWDER on 9/12/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Foundation

struct HealthMetric: Identifiable {
    let id: UUID = UUID()
    let date: Date  // x-axis
    let value: Double  // y-axis
    
    static var mockData: [HealthMetric] {
        var array: [HealthMetric] = []
        
        for i in 0..<28 {
            let metric: HealthMetric = HealthMetric(
                date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                value: .random(in: 4_000...20_000)
            )
            
            array.append(metric)
        }
        
        return array
    }
}
