//
//  EmptyRowView.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

struct EmptyRowView: View {
    var body: some View {
        HStack {
            Rectangle()
                .strokeBorder(lineWidth: 3)
                .foregroundColor(Color("CharBackground"))
                .frame(width: 80, height: 80, alignment: .bottom)
            Rectangle()
                .strokeBorder(lineWidth: 3)
                .foregroundColor(Color("CharBackground"))
                .frame(width: 80, height: 80, alignment: .bottom)
            Rectangle()
                .strokeBorder(lineWidth: 3)
                .foregroundColor(Color("CharBackground"))
                .frame(width: 80, height: 80, alignment: .bottom)
            Rectangle()
                .strokeBorder(lineWidth: 3)
                .foregroundColor(Color("CharBackground"))
                .frame(width: 80, height: 80, alignment: .bottom)
        }
    }
}

struct EmptyRowView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRowView()
    }
}
