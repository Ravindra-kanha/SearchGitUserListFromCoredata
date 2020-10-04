//  FollowingUserCell.swift
//  RavindraBhatiSwiftApp
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

//MARK: FollowingUserCell: To show Following user Information.

struct FollowingUserCell: View {
    
    //MARK: Properties
    
    /// followingUser:- Information About the follower.
    var followingUser: FollowerList?
    
    //MARK: Body
    var body: some View {
        
        HStack(alignment: .center, spacing: 12){
            RemoteImageView(urlString: followingUser?.avatar_url ?? "", width: 50)
                .clipShape(Circle())
                .shadow(radius: 5)
            Text(followingUser?.login ?? "").bold()
                .foregroundColor(.gray)
        }
    }
}

struct FollowingUserCell_Previews: PreviewProvider {
    static var previews: some View {
        FollowingUserCell()
    }
}
