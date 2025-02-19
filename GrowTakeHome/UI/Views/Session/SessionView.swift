//
//  SessionView.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var viewModel: SessionCoordinatorViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("In session")
                .font(.system(size: 34))
            
            Button {
                withAnimation {
                    viewModel.state = .moodSelection
                }
            } label: {
                Text("Exit")
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
            }
            .background(
                RoundedRectangle(
                    cornerRadius: 12,
                    style: .continuous
                )
                .fill(Color.black)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mintGreen)
    }
}
