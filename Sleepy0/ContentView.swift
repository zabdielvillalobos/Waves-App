//
//  ContentView.swift
//  Sleepy0
//
//  Created by Zabdiel Villalobos on 10/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userName: String = ""
    
    
    var body: some  View {
        TabView {
            HomeView(userName: $userName)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
//            SleepTrackerView()
  //              .tabItem {
  //                  Image(systemName: "bed.double")
     //               Text("Sleep Tracking")
     //           }
            
            AlarmListView()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Alarms")
                }
            
        //    SleepHistoryView()
        //        .tabItem {
        //            Image(systemName: "clock")
         //           Text("History")
         //       }
            
            NotifyFriendsView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Notify Friends")
                }
        }
    }
}

struct HomeView: View {
    @Binding var userName: String
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue,.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                TextField("Enter your name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    Spacer()
                
                Text("Hey, Welcome to **Waves** \(userName)")
                    .font(.largeTitle)
                    .font(.custom("TimesNewRomanPSMT", size: 24))
                    Spacer()
                Image("sleepman")
                    .resizable()
                    .frame(width: 300, height:300)
                    Spacer()
                Text("**Works with Sleep Pad**")
                Spacer()
            }
        }
    }
}

struct SleepTrackerView: View {
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue,.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("TRACKER")
                    .font(.largeTitle)
                    .bold()
                Text("Sleep Graph")
                Image("graphpro")
                    .resizable()
                    .frame(width: 335, height: 335)
                    .padding()
                HStack{
                    Spacer()
                    Text("Sleep Score")
                    Spacer()
                    Text("YOU AVERAGED:")
                    Spacer()
                }
                HStack {
                    Image("sleepgauge")
                        .resizable()
                        .frame(width: 150, height: 150)
                    VStack{
                        Text("6H 2M - Oct 28")
                        Text("7H 34M - Oct 29")
                        Text("7H 34M - Oct 30")
                        Text("7H 34M - Oct 31")
                        Text("7H 34M - Nov 1")
                        Text("7H 34M - Nov 2")
                    }
                    
                    }
                HStack{
                    Text("**Connect to Sleep Pad for Best Results**")
                    Image("bluetooth")
                        .resizable()
                        .frame(width:30, height: 30)
                    
                }
            }
        }
        }
    }

struct AlarmItem: Identifiable {
    let id = UUID()
    let time: Date
    var isEnabled: Bool
}

struct AlarmListView: View {
    
    @State private var alarms: [Date] = [] // Store the list of alarm times
    @State private var newAlarmTime = Date() // Store the new alarm time entered by the user
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue,.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Active Alarms")
                    .font(.largeTitle)
                    .padding()
                
                List {
                   ForEach(alarms, id: \.self) { alarmTime in
                        Text(formatAlarmTime(alarmTime: alarmTime))
                    }
                }

                DatePicker("New Alarm Time", selection: $newAlarmTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()

                Button(action: {
                    alarms.append(newAlarmTime)
                    newAlarmTime = Date() // Reset the new alarm time
                }) {
                    Text("Add Alarm")
                }
                .buttonStyle(.bordered)
                .padding()

                }
            .navigationTitle("Alarms")
        }
        }
    }

func formatAlarmTime(alarmTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: alarmTime)
}

struct SleepHistoryView: View {
    var body: some View {
        Text("Sleep History View")
    }
}

struct NotifyFriendsView: View {
    @State private var messages: [String] = []
    @State private var selectedMessageIndex = 0
    let fixedMessages = [ "Hey Guys, I'm going to bed now!", "Sweet dreams!", "Trying to sleep can you guys be a little more quiet!", "Sleep tight!"]
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue,.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("People In Your Circle: Kiara, Owen, Ben, Sophia, Justin")
                    .bold()
                    .font(.largeTitle)
                HStack {
                    Image("kiarapic")
                        .resizable()
                        .frame(width: 70, height:70)
                        .cornerRadius(20)
                    Image("owenpic")
                        .resizable()
                        .frame(width: 70, height:70)
                        .cornerRadius(20)
                    Image("benpic")
                        .resizable()
                        .frame(width: 70, height:70)
                        .cornerRadius(20)
                    Image("sophiapic")
                        .resizable()
                        .frame(width: 70, height:70)
                        .cornerRadius(20)
                    Image("justinpic")
                        .resizable()
                        .frame(width: 70, height:70)
                        .cornerRadius(20)
                }
                List(messages, id: \.self) { message in
                    Text(message)
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(4)
                }
                Text("Notify Friends You Are Going To Bed!")

                Menu {
                    ForEach(0 ..< fixedMessages.count, id: \.self) { index in
                        Button(action: {
                            selectedMessageIndex = index
                            sendMessage()
                        }) {
                            Text(fixedMessages[index])
                        }
                    }
                } label: {
                    Text("Select a message")
                }
                
                Button(action: sendMessage) {
                    Text("Send")
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(16)
        }
    }
    
    func sendMessage() {
        let selectedMessage = fixedMessages[selectedMessageIndex]
        // Add the selected message to the messages array
        messages.append(selectedMessage)
    }
}


    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    #Preview {
        ContentView()
    }

