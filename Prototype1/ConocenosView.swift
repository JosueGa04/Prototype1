//
//  ConocenosView.swift
//  Prototype1
//
//  Created by Josue Galindo on 29/08/24.
//

import SwiftUI

struct ConocenosView: View {
    // Environment variable to dismiss the view
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Logo and User Settings
                    HStack {
                        Image("RED-BAMX")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle user settings action
                        }) {
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // About Us Information
                    ScrollView {
                        VStack(spacing: 20) {
                            Image("zero_hunger")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                            
                            Text("About Us")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                                .padding(.bottom, 10)
                            
                            Text("We are a company dedicated to making the world a better place by focusing on sustainability, social responsibility, and innovation. Our mission is to create solutions that positively impact our community and the environment.")
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                            
                            // Button to go back to the previous view with return animation
                            Button(action: {
                                dismiss() // Go back with return animation
                            }) {
                                Text("Back to Dashboard")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .navigationBarTitle("Conócenos", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    ConocenosView()
}
