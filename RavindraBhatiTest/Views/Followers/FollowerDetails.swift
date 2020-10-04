//  FollowerDetails.swift
//  RavindraBhatiSwiftApp
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
import SwiftUI
//MARK: FollowerDetails: to show the Details of the Followers.
struct FollowerDetails: View {
    
    //MARK: Properties
    
    /// followerUserDetails : to  contain information of the follower.
    var followerUserDetails: FollowerList?
    
    //MARK: Body
    var body: some View {
        
        Form{
            Section(header: Text("Follower Profile")) {
                HStack{
                    Spacer()
                    // load follower  user Image
                    RemoteImageView(urlString: followerUserDetails?.avatar_url ?? "", width: 150)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                    Spacer()
                }
                
                // load follower  score
                              
            }
            Section(header: Text("Follower Name")) {
                // load follower  user name
                Text(followerUserDetails?.login ?? "")
            }
            
            Section(header: Text("User Type")) {
                // load follower  user Type
                Text(followerUserDetails?.type ?? "")
            }
        }
        .navigationBarTitle(Text("User Details"))
        
    }
}

struct FollowerDetails_Previews: PreviewProvider {
    static var previews: some View {
        FollowerDetails()
    }
}
