//
//  WarRules.swift
//  Soccer Wars
//
//  Created by Arman Zadeh-Attar on 2021-09-13.
//

import SwiftUI

struct WarRules: View {
    
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    private var rules = ["The overall War mode puts the player against the AI where they take turns playing a random card from their deck.", "The player with the highest overall card played during that round wins.", "In the case of a draw the players keep playing until a winner for that round is determined.", "Game is over when players run out of cards"]
    
   @State private var number = 0
    
    var body: some View {
        ZStack{
            Image("back").resizable().ignoresSafeArea()
           
            VStack {
                
                Text(rules[number]).font(.title2).fontWeight(.light).multilineTextAlignment(.center).padding(.all).frame(width: 330, height: 330).foregroundColor(.white).border(Color(.black).opacity(0.6), width: 15).background(Color(.black).opacity(0.5))
                
                HStack{
                    
                    Button(action: {
                        
                        if number > 0 && number != 0 {
                            number -= 1
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.left.circle").font(.system(size: 50)).foregroundColor(.white).padding()
                            })
                    
                    Text("\(number + 1) / \(rules.count)").font(.title).fontWeight(.heavy).foregroundColor(.white)
                    
                    Button(action: {
                        
                        if number < 3 && number != 3 {
                            number += 1
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.right.circle").font(.system(size: 50)).foregroundColor(.white).padding()
                            })
                    
                }
            }
            
        }.navigationBarTitle("Overall War Rules")
    }
    
}


struct WarRules_Previews: PreviewProvider {
    static var previews: some View {
        WarRules()
    }
}
