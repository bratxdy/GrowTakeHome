//
//  TaskCell.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct TaskCell: View {
    enum State {
        case unlocked(dateString: String)
        case locked(dateString: String)
        case completed(mood: String)
        
        var title: String {
            switch self {
            case .unlocked(let dateString):
                return dateString
            case .locked(let dateString):
                return dateString
            case .completed(let mood):
                return mood
            }
        }
        
        var image: Image {
            switch self {
            case .unlocked:
                return Image.rightChevron
            case .locked:
                return Image.lock
            case .completed:
                return Image.completed
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .unlocked:
                return .mintGreen
            default:
                return .beige
            }
        }
        
        var fontColor: Color {
            switch self {
            case .locked:
                return .disabled
            default:
                return .black
            }
        }
        
        var imageColor: Color {
            switch self {
            case .unlocked:
                return .black
            case .locked:
                return .disabled
            case .completed:
                return .lavender
            }
        }
    }
    
    let state: State
    let action: () -> Void
    
    init(state: State, action: @escaping () -> Void = { }) {
        self.state = state
        self.action = action
    }
    
    var body: some View {
        Button {
            switch state {
            case .unlocked:
                action()
            default:
                break
            }
        } label: {
            HStack {
                Text(state.title)
                    .foregroundStyle(state.fontColor)
                
                Spacer()
                
                state.image
                    .foregroundStyle(state.imageColor)
            }
            .font(.title3)
            .padding(.horizontal, 16)
            .frame(height: 55)
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .fill(state.backgroundColor)
            .stroke(.charcoal, lineWidth: 2)
        )
    }
}

#Preview("Unlocked") {
    TaskCell(state: .unlocked(dateString: "February 19"))
        .padding(.horizontal, 24)
}

#Preview("Locked") {
    TaskCell(state: .locked(dateString: "February 19"))
        .padding(.horizontal, 24)
}

#Preview("Completed") {
    TaskCell(state: .completed(mood: "Low energy"))
        .padding(.horizontal, 24)
}
