//
//  LanePickerView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-23.
//

import SwiftUI

struct LanePickerView: View {
  let viewModel: DotaTactixViewModel
  let lanes = ["Mid", "Easy", "Hard"]

  var body: some View {
    VStack(alignment: .leading) {
      Text("Lane")
        .boldFont(size: 20)
      HStack {
        ForEach(lanes, id: \.self) { lane in
          Button {
            viewModel.selectedLane = lane
          } label: {
            Text(lane)
              .padding(10)
              .background(viewModel.selectedLane == lane ? .accent : .grayDark)
              .foregroundStyle(viewModel.selectedLane == lane ? .white : .grayLight)
              .cornerRadius(5)
          }
        }
      }
      .regularFont()
    }
  }
}
