//
// File: ContentView.swift
// Project: StepTracker
// 
// Created by SCOTT CROWDER on 8/14/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Charts
import SwiftUI

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    
    var id: Self {
        return self
    }
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPrimingView: Bool = false
    @State private var isShowingPermissionPriminingSheet: Bool = false
    
    @State private var selectedStat: HealthMetricContext = .steps
    
    var isSteps: Bool {
        selectedStat == .steps
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20) {
                    
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    switch selectedStat {
                    case .steps:
                        StepBarChart(selectedStat: selectedStat, chartData: hkManager.stepData)
                        StepPieChart(chartData: ChartMath.averageWeekdayCount(for: hkManager.stepData))
                    case .weight:
                        WeightLineChart(selectedStat: selectedStat, chartData: hkManager.weightData)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .padding()
            .task {
//                await hkManager.addSimulatorData()
                await hkManager.fetchStepCount()
                await hkManager.fetchWeightsCount()
                isShowingPermissionPriminingSheet = !hasSeenPermissionPrimingView
            }
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionPriminingSheet) {
                // fetch health data
            } content: {
                HealthKitPrimingView(hasSeen: $hasSeenPermissionPrimingView)
            }

        }
        .tint(isSteps ? .pink : .indigo)
    }
    
    
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
