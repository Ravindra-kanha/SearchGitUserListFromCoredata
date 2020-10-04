//
//  UserDetailsView.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

//MARK: UserDetailsView
struct UserDetailsView: View {
    
    //MARK: Properties
    
    //userDetails: to contain information off the user.
    var userDetails: UserList?
    
    var body: some View {
        
        Form{
            
            Section(header: Text("User Profile")) {
                HStack{
                    Spacer()
                    // Load  image from the url and show
                    RemoteImageView(urlString: userDetails?.avatar_url ?? "", width: 150)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                    Spacer()
                }
            }
            Section(header: Text("User Name")) {
                // to show user Name
                Text(userDetails?.login ?? "")
            }
            
            Section(header: Text("User Type")) {
                // to show User Type
                Text(userDetails?.type ?? "")
            }

            NavigationLink(destination: FollowersList(followersUrl: userDetails?.followers_url ?? "")) {
                Text("Followers").bold()
            }
        }
         .navigationBarTitle(Text("User Details"))
        
    }
}
