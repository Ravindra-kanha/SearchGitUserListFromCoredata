//
//  UserCell.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

//MARK: UserCell: To show user Information.
struct UserCell: View {
    
    
    //MARK: Properties
    
    /// user:- Information About the User.
    var user: UserList?
    
    //Body
    var body: some View {
        HStack(alignment: .center, spacing: 12){
            ///Load image from the image url
            RemoteImageView(urlString: user?.avatar_url ?? "", width: 50)
                .clipShape(Circle())
                .shadow(radius: 5)
            // show the name of the user.
            Text(user?.login ?? "").bold()
                .foregroundColor(.gray)   
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
