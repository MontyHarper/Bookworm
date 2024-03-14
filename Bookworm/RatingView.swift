//
//  RatingView.swift
//  Bookworm
//
//  Created by Monty Harper on 3/12/24.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    let maxRating = 5
    
    var label: String = ""
    var offImage: Image?
    let onImage = Image(systemName: "star.fill")
    
    let onColor = Color(.yellow)
    let offColor = Color(.gray)
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id:\.self) {number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
