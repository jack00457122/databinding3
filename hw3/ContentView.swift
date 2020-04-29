//
//  ContentView.swift
//  hw3
//
//  Created by User09 on 2020/4/27.
//  Copyright © 2020 00457122. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var sSP = false
    @State private var isP = false
    @State private var name = ""
    @State private var subj = 2
    @State private var islike = false
    @State private var textday = Date()
    @State private var selike = "還好"
    let like = ["喜歡", "不喜歡", "還好"]
    @State private var showresult = false
    @State private var showNameAlert = false
    let dateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var body: some View
    {
        VStack
            {
            score()
            TextField("你的名字", text: $name)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            .frame(width:300)
            .multilineTextAlignment(.center)
            
            .frame(width:200)
        Button("查看期中考分數") {
        self.sSP = true
        }
        .sheet(isPresented:self.$sSP) {
        SecondView(sSP:self.$sSP)
                }
                    Stepper(value: $subj, in: 1...10)
                    {
                        if subj == 1
                        {
                            Text("你只考\(subj)科")
                        }
                        else
                        {
                            Text("你要考\(subj)科")
                        }
                    }
                Form
                    {
                    Toggle("你喜歡讀書嗎？", isOn: $islike)
                    if islike
                    {
                        Picker("讀書", selection: $selike)
                        {
                            ForEach(like, id: \.self)
                            {
                                (like) in
                                Text(like)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    DatePicker("Your Birthday", selection: $textday, in:...Date(), displayedComponents: .date)
                        if isP
                        {
                            HStack{
                            Image("壓力大")
                            .resizable()
                            .scaledToFill()
                            .frame(width:150, height:120)
                            Text("幹！死定了")
                                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
                            }
                        }
                        else
                        {
                            HStack{
                            Image("聰明")
                            .resizable()
                            .scaledToFill()
                            .frame(width:150, height:120)
                            Text("輕輕鬆鬆")
                                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
                            }
                        }
                        Toggle("你壓力很大嗎？", isOn: $isP)
                        .frame(width:300)
                }
                .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                .frame(width:400, height: 300)
                .clipped()
                Button(action:
                    {
                        if self.name == ""
                        {
                            self.showNameAlert = true
                        }
                        else
                        {
                            self.showresult = true
                        }
                    })
                    {
                        HStack
                        {
                            Text("認命")
                            .fontWeight(.semibold)
                            .font(.title)
                            Image(systemName: "death")
                                .font(.title)
                        }
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(40)
                    }
                    .alert(isPresented: $showNameAlert)
                    {
                        () -> Alert in
                        return Alert(title: Text("沒寫名字"), message: Text("看來是很想零分喔～"))
                    }
                    .sheet(isPresented: self.$showresult)
                    {
                        scoreResult(name:self.$name,subj:self.$subj,islike:self.$islike,textday:self.$textday,selike:self.$selike,showresult:self.$showresult)
                    }
                }
                .background(Image("考卷")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .clipped()
                .edgesIgnoringSafeArea(.all))
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct SecondView: View {

    @Binding var sSP : Bool
    var body: some View {
        VStack{
            Image("我就爛")
            .resizable()
            .scaledToFill()
            .clipped()
            Text("０分")
            .font(.system(size: 50, weight: .regular, design: .monospaced))
        Button("ＧＧ") {
        self.sSP=false
        }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(sSP: .constant(true))
    }
}
struct score: View
{
    var body: some View
    {
        Text("期末考分數✍")
            .font(.system(size: 50, weight: .regular, design: .monospaced))
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.center)
            .frame(width:300.0, height:60)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.red, lineWidth: 5))
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
