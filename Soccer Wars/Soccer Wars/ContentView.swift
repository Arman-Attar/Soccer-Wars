//
//  ContentView.swift
//  Soccer Wars
//
//  Created by Arman Zadeh-Attar on 2021-09-02.
//

import SwiftUI

struct ContentView: View {
   
    
    var body: some View {
        NavigationView {
            ZStack{
                    Image("back").resizable().ignoresSafeArea()
                    VStack{
                        HStack{
                            Image(systemName: "chevron.up").font(.system(size: 45)).foregroundColor(.black)
                            
                            Text("Soccer Wars").font(.system(size: 40)).bold().foregroundColor(.black)
                            
                            Image(systemName: "chevron.down").font(.system(size: 45)).foregroundColor(.black)
                            
                        }.padding()
                       Spacer()
                        NavigationLink(
                            destination: OverallWar()){
                            Text("Overall War")
                                .fontWeight(.light)
                            .foregroundColor(.black)
                            .font(.title)
                            .bold()
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 35)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(20)
                            .padding()
                        }
                        
                        NavigationLink(
                            destination: WarRules()){
                            Text("Rules")
                                .fontWeight(.light)
                            .foregroundColor(.black)
                            .font(.title)
                            .bold()
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 70)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(20)
                            .padding()
                        }
                        
                        Spacer()
                        Spacer()
                    }
            }
        }.navigationBarHidden(true)
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
