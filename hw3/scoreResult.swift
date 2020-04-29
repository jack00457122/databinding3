//
//  scoreResult.swift
//  hw3
//
//  Created by User09 on 2020/4/29.
//  Copyright © 2020 00457122. All rights reserved.
//

import SwiftUI

struct scoreResult: View {
    @Binding var name:String
    @Binding var subj: Int
    @Binding var islike:Bool
    @Binding var textday: Date
    @Binding var selike:String
    @Binding var showresult:Bool
    @State private var brightnessAmount: Double = 0
    @State private var scale: CGFloat = 0.5
    @State private var open = false
    let dateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var body: some View {
        VStack{
            Text("發考卷時的你")
                .padding(EdgeInsets(top:10, leading: 0, bottom: 0, trailing: 0))
        HStack
        {
            VStack
            {
                VStack{
                Text("\(name),目前正要看第 \(subj)科成績")
                .font(.system(size: 50, weight: .regular, design: .monospaced))
                    .foregroundColor(Color.orange)
                Text(" 成績發布日:")
                Text("\(dateFormatter.string(from: textday))")
                HStack
                {
                    if islike
                    {
                        if self.selike == "喜歡"
                        {
                            Image("好")
                            .resizable()
                            .scaledToFill()
                            .frame(width:30, height:30)
                        }
                        else if self.selike == "不喜歡"
                        {
                            Image("不")
                            .resizable()
                            .scaledToFill()
                            .frame(width:30, height:30)
                        }
                        else
                        {
                            Image("看穿")
                            .resizable()
                            .scaledToFill()
                            .frame(width:30, height:30)
                        }
                    }
                }
                if open{
                    if (brightnessAmount<0.2&&scale<0.7){
                    Text("不及格")
                    Image("可憐哪")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .brightness(self.brightnessAmount)
                        .frame(width:280, height:200)
                }
                else{
                    Text("及格")
                    Image("傑出")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .brightness(self.brightnessAmount)
                        .frame(width:280, height:200)
                }
                }
                Text("祈禱")
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                BrightnessSlider(brightnessAmount: self.$brightnessAmount)
                scaleSlider(scale: self.$scale)
                Spacer()
                .frame(height: 80)
                }
                Toggle("看成績", isOn: $open)
                Button(action:
                {
                    self.open = false
                    self.scale = 0.5
                    self.brightnessAmount = 0
                })
                {
                    HStack
                    {
                        Text("重修")
                        Image(systemName: "gobackward")
                        .imageScale(.large)
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                        
                }
                Button(action:{self.showresult = false})
                {
                    HStack
                    {
                        Text("放暑假摟～")
                        Image(systemName: "trash")
                        .imageScale(.large)
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(40)
                }
                
            }
            Spacer()
        }
        .padding()
        }
        .background(Image("我看了")
        .resizable()
        .scaledToFill()
        .opacity(0.3)
        .edgesIgnoringSafeArea(.all)
        .clipped())
    }
}
struct scoreResult_Previews: PreviewProvider {
    static var previews: some View {
        scoreResult(name:.constant(""),subj:.constant(2),islike:.constant(false),textday:.constant(Date()), selike:.constant(""),showresult:.constant(true))
    }
}
struct BrightnessSlider: View
{
    
    @Binding var brightnessAmount: Double
    
    var body: some View
    {
        HStack
        {
            Text("信仰值")
            Slider(value: self.$brightnessAmount, in: 0...0.5, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)){Text("")}
        }
        .frame(width:300)
    }
}
struct scaleSlider: View
{
    
    @Binding var scale: CGFloat
    
    var body: some View
    {
        HStack
        {
            Text("祈禱時間")
            Slider(value: self.$scale, in: 0.5...1)
            Text("\(self.scale, specifier: "%.2f")hour")
        }
        .frame(width:300)
    }
}
