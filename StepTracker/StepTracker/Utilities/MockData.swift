//
// File: MockData.swift
// Project: StepTracker
// 
// Created by SCOTT CROWDER on 10/24/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Foundation

struct MockData {
    static var steps: [HealthMetric] {
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
    
    static var weights: [HealthMetric] {
        var array: [HealthMetric] = []
        
        for i in 0..<28 {
            let metric: HealthMetric = HealthMetric(
                date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                value: .random(in: (160 + Double(i/3)...165 + Double(i/3)))
            )
            
            array.append(metric)
        }
        
        return array
    }
    
    static var weightDiffs: [WeekdayChartData] {
        var array: [WeekdayChartData] = []
        
        for i in 0..<7 {
            let diff: WeekdayChartData = WeekdayChartData(
                date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                value: .random(in: -3...3)
            )
            
            array.append(diff)
        }
        
        return array
    }
}
