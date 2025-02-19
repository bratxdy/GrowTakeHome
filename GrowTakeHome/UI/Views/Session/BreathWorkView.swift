//
//  BreathWorkView.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct BreathWorkView: View {
    @ObservedObject var viewModel: SessionCoordinatorViewModel
    
    @State var scaleAmount = 0.25
    
    var body: some View {
        VStack(spacing: 8) {
            makeBreathLabels()
            
            makeBreathPulseView()
            
            Spacer()
            
            if viewModel.isAvailable {
                makeJoinSessionView()
            }
        }
        .onReceive(viewModel.timer) { _ in
            viewModel.numberOfBreaths -= 1
            if viewModel.numberOfBreaths == 0 {
                viewModel.timer.upstream.connect().cancel()
                viewModel.state = .waiting
            }
        }
        .padding(.top, 64)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.beige)
    }
    
    @ViewBuilder func makeBreathLabels() -> some View {
        Text("Breathe for")
            .font(.system(size: 34, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .center)
        
        Text("\(viewModel.numberOfBreaths)")
            .font(.system(size: 60, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 24)
    }
    
    @ViewBuilder func makeBreathPulseView() -> some View {
        Circle()
            .fill(Color.lavender)
            .frame(width: 200, height: 200)
            .scaleEffect(scaleAmount)
            .animation(.easeInOut(duration: SessionCoordinatorViewModel.Constants.inhaleExhaleDuration / 2).repeatForever(autoreverses: true), value: scaleAmount)
            .onAppear {
                withAnimation {
                    scaleAmount = 1.0
                }
            }
    }
    
    @ViewBuilder func makeJoinSessionView() -> some View {
        Text("Provider is in the session")
            .font(.title3)
        
        Button {
            withAnimation {
                viewModel.timer.upstream.connect().cancel()
                viewModel.state = .session
            }
        } label: {
            Text("Join Now")
                .foregroundStyle(Color.charcoal)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
        }
        .background(
            RoundedRectangle(
                cornerRadius: 12,
                style: .continuous
            )
            .fill(Color.mintGreen)
        )
    }
}

#Preview("Is not available") {
    BreathWorkView(viewModel: SessionCoordinatorViewModel(initialState: .breathWork, isAvailable: false, task: .constant(MyTask(numberOfBreaths: 9, moodChoices: [], unlockedDate: .now, completedDate: nil, moodChoice: nil))))
}

#Preview("Is available") {
    BreathWorkView(viewModel: SessionCoordinatorViewModel(initialState: .breathWork, isAvailable: true, task: .constant(MyTask(numberOfBreaths: 9, moodChoices: [], unlockedDate: .now, completedDate: nil, moodChoice: nil))))
}
