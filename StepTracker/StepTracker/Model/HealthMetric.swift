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
    
    
}
