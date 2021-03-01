//
//  BodyTemperaturePickerView.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//


import SwiftUI

struct BodyTemperaturePickerView: View {
    
    @Binding var selectedBodyTemperature: String
    @Binding var intPartSelection: String
    @Binding var decimalPartSelection: String
    
    
    private let intPartReference: [String] = ["35.", "36.", "37.", "38.", "39.", "40.", "41.", "42.", "43."]
    private let decimalPartReference: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            //MARK: INTERGER PART
            Picker(selection: $intPartSelection, label: Text(""), content: {
                ForEach(intPartReference, id:\.self){ tmp in
                    Text("\(tmp)")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                }
            })
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width: 100, height: 150)
            .clipped()
            
            //MARK: DECIMAL PART
            Picker(selection: $decimalPartSelection, label: Text(""), content: {
                ForEach(decimalPartReference, id:\.self){ tmp in
                    Text("\(tmp)")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                }
            })
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width: 100, height: 150)
            .clipped()
            
            Text("℃")
                .font(.title3)
                .foregroundColor(.black)
                .fontWeight(.regular)
        }
        .frame(height: 150, alignment: .center)
        .background(Color.MyThemeColor.accentColor)
        .cornerRadius(20)
    }
    
}

struct BodyTemperaturePickerView_Previews: PreviewProvider {
    @State static var selectedBodyTemperature: String = "36.5"
    @State static var intPartSelection: String = "36."
    @State static var decimalPartSelection: String = "5"
    
    static var previews: some View {
        BodyTemperaturePickerView(selectedBodyTemperature: $selectedBodyTemperature, intPartSelection: $intPartSelection, decimalPartSelection: $decimalPartSelection)
    }
}
