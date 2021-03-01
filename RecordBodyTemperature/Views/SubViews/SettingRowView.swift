//
//  SettingRowView.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//


import SwiftUI

struct SettingRowView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            Text(title)
                .font(.title3)
                .bold()
            Spacer()
            Image(systemName: imageName)
                .font(.title)
        }
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(title: "体温計リーダー", imageName: "heart.fill")
    }
}
