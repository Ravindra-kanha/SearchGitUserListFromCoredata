//  ContentView.swift
//  RavindraBhatiTest
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.

import SwiftUI

//MARK: ContentView: to show the information of the User List  and follower list.
struct ContentView: View {
    
    //MARK: Properties
    
    /// user Name :- to enter the name of the user in the textfield.
    @State var userName: String = ""
    
    //Body
    var body: some View {
        
        NavigationView{
            Form{
                // Enter user Name to show user List
                Section(header: Text("Enter username")) {
                    TextField("Enter username...", text: self.$userName)
                }
                if !(self.userName.isEmpty){
                    
                    NavigationLink(destination: UserListView(userName: self.userName)) {
                        HStack{
                            Spacer()
                            //on the selection of search show to user list
                            Text("Search")
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.red.opacity(0.9))
                                .clipShape(Capsule())
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle(Text("User"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
