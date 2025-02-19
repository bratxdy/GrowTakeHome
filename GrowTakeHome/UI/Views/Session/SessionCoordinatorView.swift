//
//  SessionCoordinatorView.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct SessionCoordinatorView: View {
    @StateObject var viewModel: SessionCoordinatorViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .initial, .loading:
                makeLoadingState()
            case .breathWork:
                BreathWorkView(viewModel: viewModel)
            case .waiting:
                SessionWaitingRoomView(viewModel: viewModel)
            case .session:
                SessionView(viewModel: viewModel)
            case .moodSelection:
                MoodSelectionView(viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .background(Color.beige)
        .task {
            guard viewModel.state == .initial else { return }
            await viewModel.loadProviderStatus()
        }
    }
    
    @ViewBuilder func makeLoadingState() -> some View {
        VStack {
            Spacer()
            
            ProgressView()
            
            Spacer()
        }
    }
}
