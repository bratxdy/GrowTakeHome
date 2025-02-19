//
//  SessionWaitingRoomView.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct SessionWaitingRoomView: View {
    @ObservedObject var viewModel: SessionCoordinatorViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isAvailable {
                Text("Provider is in the session")
                    .font(.system(size: 34))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 90)
                
                Button {
                    withAnimation {
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
            } else {
                Text("Waiting for provider...")
                    .font(.system(size: 34))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 16)
                
                Text("When they come online, you’ll be redirected to the session automatically")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.isAvailable ? Color.lavender : Color.mintGreen)
    }
}

#Preview("Not available") {
    SessionWaitingRoomView(viewModel: SessionCoordinatorViewModel(initialState: .session, isAvailable: false, task: .constant(MyTask(numberOfBreaths: 9, moodChoices: [], unlockedDate: .now, completedDate: nil, moodChoice: nil))))
}

#Preview("Available") {
    SessionWaitingRoomView(viewModel: SessionCoordinatorViewModel(initialState: .session, isAvailable: true, task: .constant(MyTask(numberOfBreaths: 9, moodChoices: [], unlockedDate: .now, completedDate: nil, moodChoice: nil))))
}
