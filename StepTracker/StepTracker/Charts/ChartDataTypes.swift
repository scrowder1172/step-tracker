//
// File: ChartDataTypes.swift
// Project: StepTracker
// 
// Created by SCOTT CROWDER on 10/23/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Foundation

struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
