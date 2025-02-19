//
//  MoodSelectionView.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct MoodSelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: SessionCoordinatorViewModel
    
    @State var selectedMood: String?
    
    var body: some View {
        VStack(spacing: 0) {
            Text("How have you been feeling this week?")
                .font(.system(size: 34, weight: .bold))
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                .padding(.vertical, 72)
            
            makeMoodSelectionView()
            
            makeLogActivityButton()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.beige)
    }
    
    @ViewBuilder func makeMoodSelectionView() -> some View {
        VStack(spacing: 16) {
            ForEach(viewModel.task.wrappedValue.moodChoices, id: \.self) { moodChoice in
                Button {
                    selectedMood = moodChoice
                } label: {
                    Text(moodChoice)
                        .foregroundStyle(Color.black)
                        .frame(height: 44, alignment: .leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                }
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(moodChoice == selectedMood ? Color.lavender : Color.beige)
                    .stroke(Color.charcoal, lineWidth: 1)
                )
            }
        }
        .padding(.horizontal, 50)
        .padding(.bottom, 32)
    }
    
    @ViewBuilder func makeLogActivityButton() -> some View {
        Button {
            viewModel.task.wrappedValue.completedDate = .now
            viewModel.task.wrappedValue.moodChoice = selectedMood
            dismiss()
        } label: {
            Text("Log Activity")
                .font(.title3)
                .foregroundStyle(selectedMood == nil ? Color.charcoal.opacity(0.30) : Color.charcoal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
        .background(
            RoundedRectangle(
                cornerRadius: 12,
                style: .continuous
            )
            .fill(selectedMood == nil ? Color.disabled.opacity(0.12) : Color.mintGreen)
        )
        .disabled(selectedMood == nil)
        .padding(.horizontal, 50)
    }
}

#Preview {
    MoodSelectionView(viewModel: SessionCoordinatorViewModel(initialState: .moodSelection, task: .constant(MyTask(numberOfBreaths: 9, moodChoices: ["happy", "sad", "angry", "content"], unlockedDate: .now, completedDate: nil, moodChoice: nil))))
}
