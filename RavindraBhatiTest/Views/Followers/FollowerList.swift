//  FollowerList.swift
//  RavindraBhatiSwiftApp
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.


import SwiftUI


//MARK: FollowersList: Follower List.
struct FollowersList: View {
    
    //MARK: Properties
    
    /// followerViewModel: Contain Information from  about the Follower user.
    @ObservedObject var followerViewModel: FollowerListViewModel = FollowerListViewModel()
    
    /// followersUrl: to get following User  list.
    var followersUrl: String
    
    //MARK: Body
    var body: some View {
        
        // To draw the List of the following User.
        FollowersLists(followerList: followerViewModel.state.followerList, isLoading: followerViewModel.state.canLoadNextPage) {
            self.followerViewModel.fetchNextPageIfPossible(self.followersUrl)
        }.environmentObject(self.followerViewModel)
            
            .onAppear(perform: {
                
                DispatchQueue.main.async {
                    // check internet connectivity
                    guard Reachability.isConnectedToNetwork() == true else{
                        // Load data from the local storage.
                        self.followerViewModel.fetchDataFromLocal()
                        return
                    }
                    // Load data from the  web service
                    self.followerViewModel.fetchNextPageIfPossible(self.followersUrl)
                }
            })
            .navigationBarTitle(Text("Follower List"))
    }
}

//MARK: FollowersList: Follower List container to get  information of the followers.
struct FollowersLists: View{
    
    //MARK: Properties
    
    
    /// followerList: Follower List information.
    var followerList: [FollowerList]
    
    //isLoading:  if load more information from the Web service or local.
    let isLoading: Bool
    
    // to check if user scroll at the bottom of the list
    let onScrolledAtBottom: () -> Void
    
    //viewModel: to access all the information  about the follower List.
    @EnvironmentObject var viewModel: FollowerListViewModel
    
    //MARK: Body
    var body: some View {
        
        List {
            followersList
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    //MAR: follower List
    private var followersList: some View {
        
        ForEach(followerList, id: \.self){ user in
            
            NavigationLink(destination: FollowerDetails(followerUserDetails: user)) {
                FollowingUserCell(followingUser: user)
            }
            .onAppear {
                if self.followerList.last == user {
                    self.onScrolledAtBottom()
                }
            }
        }
        .padding([.leading,.trailing], 5)
        .padding([.top, .bottom], 2)
        
    }
    // to show the activity Indicator.
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
        
    }
}
