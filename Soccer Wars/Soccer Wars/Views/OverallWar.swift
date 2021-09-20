//
//  OverallWar.swift
//  Soccer Wars
//
//  Created by Arman Zadeh-Attar on 2021-09-02.
//

import SwiftUI


struct OverallWar: View {
    
    @State private var number = 0 // used to find the index for the card being played
    @State private var playerCard = 0 // stores the index of the player card for that round
    @State private var aiCard = 0 // stores the index of the ai card for that round
    @State private var aiscore = 0
    @State private var playerscore = 0
    @State private var ai = 0 // ai card deck
    @State private var player = 0 // player card deck
    @State private var dealt = 0
    @State private var tie = false
    @State private var turn = 0
    @State private var played = false
    @State private var round = 1
    
    @State var players = [
        Players(name: "ronaldo", overall: 94, aiTeam: false, playerTeam: false, played: false),
        Players(name: "messi", overall: 95, aiTeam: false, playerTeam: false, played: false),
        Players(name: "salah", overall: 90, aiTeam: false, playerTeam: false, played: false),
        Players(name: "auba", overall: 89, aiTeam: false, playerTeam: false, played: false),
        Players(name: "del", overall: 98, aiTeam: false, playerTeam: false, played: false),
        Players(name: "dybala", overall: 89, aiTeam: false, playerTeam: false, played: false),
        Players(name: "griez", overall: 89, aiTeam: false, playerTeam: false, played: false),
        Players(name: "haaland", overall: 90, aiTeam: false, playerTeam: false, played: false),
        Players(name: "henry", overall: 99, aiTeam: false, playerTeam: false, played: false),
        Players(name: "ibra", overall: 88, aiTeam: false, playerTeam: false, played: false),
        Players(name: "insigne", overall: 87, aiTeam: false, playerTeam: false, played: false),
        Players(name: "kane", overall: 91, aiTeam: false, playerTeam: false, played: false),
        Players(name: "kdb", overall: 91, aiTeam: false, playerTeam: false, played: false),
        Players(name: "lautaro", overall: 86, aiTeam: false, playerTeam: false, played: false),
        Players(name: "lewa", overall: 93, aiTeam: false, playerTeam: false, played: false),
        Players(name: "lukaku", overall: 90, aiTeam: false, playerTeam: false, played: false),
        Players(name: "modric", overall: 92, aiTeam: false, playerTeam: false, played: false),
        Players(name: "pedri", overall: 85, aiTeam: false, playerTeam: false, played: false),
        Players(name: "sheva", overall: 98, aiTeam: false, playerTeam: false, played: false),
        Players(name: "vardy", overall: 88, aiTeam: false, playerTeam: false, played: false)
    ]
    
    private var turnIndicator = ["hand.point.left", "hand.point.right"]
    
    var body: some View {
        //background
        NavigationView{
            ZStack{
                Image("field").resizable().ignoresSafeArea()
                VStack{
                    Spacer()
                    HStack{
                        Label("User: \(playerscore) ", systemImage: "person.circle.fill")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                            .background(Color(.black))
                            .cornerRadius(20)
                        
                        Image(systemName: turnIndicator[turn]).font(.system(size: 40)).foregroundColor(.white)
                        
                        
                        Label("CPU: \(aiscore) ", systemImage: "desktopcomputer").padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                            .background(Color(.black))
                            .cornerRadius(20)
                        
                        
                    }.padding()
                    Label("User cards left:  \(player) ", systemImage: "placeholdertext.fill").padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .background(Color(.black))
                        .cornerRadius(20)
                    Spacer()
                    
                    //Mid Section involving the card being played and the turn indicator
                    HStack {
                        
                        if played == true{
                            Image(players[number].name).resizable().frame(width: 250, height: 380)
                                .cornerRadius(30)
                                .shadow(radius: 20)
                                .padding()
                        }
                        else{
                            Rectangle().frame(width: 250, height: 380)
                                .cornerRadius(30)
                                .shadow(radius: 20)
                                .padding()
                                .opacity(0)
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                    HStack{
                
                        Button(action: {
                            played = true
                            playerTurn()
                            turn = 1
                            player -= 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                aiTurn()
                                turn = 0
                                tie = winner()
                               if tie == false {
                               
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                        played = false
                                        dealt += 1
                                        self.round = 1
                                    }
                                }
                               else{
                                
                                self.round += 1
                                dealt += 1
                                
                               }
                            }
                        }, label: {
                            Text("Deal").bold().padding(.vertical, 20.0).padding([.leading, .trailing], 50.0).background(Color(.black).opacity(0.8)).foregroundColor(.white).cornerRadius(25)
                        })
                    }
                    
                    //scroll view to show user the cards he has
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(0..<players.count) { card in
                                if players[card].playerTeam == true && players[card].played == false{
                                    Image(players[card].name).resizable().frame(width: 100, height: 150).aspectRatio(contentMode: .fill).cornerRadius(20).shadow(radius: 5)
                                }
                            }
                        }
                        
                    }.padding(.horizontal, 10)
                    
                }
                //User wins screen
                if aiscore < playerscore && dealt == 10 {
                
                    Rectangle().ignoresSafeArea().background(Color(.black)).opacity(0.4)
                    VStack{
                        Spacer()
                        HStack{
                            Image(systemName: "crown").font(.system(size: 50)).foregroundColor(.yellow)
                            Text("You won")
                                .font(.largeTitle)
                                .fontWeight(.medium).foregroundColor(.yellow)
                            Image(systemName: "crown").font(.system(size: 50)).foregroundColor(.yellow)
                        }
                        
                        Button(action: {
                            playerscore = 0
                            aiscore = 0
                            ai = 0
                            player = 0
                            dealt = 0
                            self.round = 1
                            randomize()
                            
                        }, label: {
                            
                            Text("Play Again")
                                .font(.headline)
                                .foregroundColor(Color.yellow)
                                .padding(.vertical, 30)
                                .padding(.horizontal, 50)
                                .background(Color(.black))
                                .cornerRadius(15)
                            
                        }).padding()
                        
                        NavigationLink(
                            destination: ContentView()){
                            Text("Return to Main Menu")
                                .font(.headline)
                                .foregroundColor(Color.yellow)
                                .padding(.vertical, 30)
                                .padding(.horizontal, 50)
                                .background(Color(.black))
                                .cornerRadius(15)
                        }
                        
                        
                        
                        Spacer()
                    }
                }
                
                // User loses screen
                else if playerscore < aiscore && dealt == 10 {
                    
                    Rectangle().ignoresSafeArea().background(Color(.black)).opacity(0.4)
                    VStack{
                        Spacer()
                        HStack{
                            Image(systemName: "crown").font(.system(size: 50)).foregroundColor(.yellow)
                            Text("You lost")
                                .font(.largeTitle)
                                .fontWeight(.medium).foregroundColor(.yellow)
                            Image(systemName: "crown").font(.system(size: 50)).foregroundColor(.yellow)
                        }
        
                        Button(action: {
                            playerscore = 0
                            aiscore = 0
                            ai = 0
                            player = 0
                            dealt = 0
                            self.round = 1
                            randomize()
                            
                        }, label: {
                            
                            Text("Play Again")
                                .font(.headline)
                                .foregroundColor(Color.yellow)
                                .padding(.vertical, 30)
                                .padding(.horizontal, 50)
                                .background(Color(.black))
                                .cornerRadius(15)
                            
                        }).padding()
                        
                        NavigationLink(
                            destination: ContentView()){
                            Text("Return to Main Menu")
                                .font(.headline)
                                .foregroundColor(Color.yellow)
                                .padding(.vertical, 30)
                                .padding(.horizontal, 50)
                                .background(Color(.black))
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                    }
                    
                }
                // in the case of a draw
                else if playerscore == aiscore && dealt == 10 {
                    
                    Rectangle().ignoresSafeArea().background(Color(.black)).opacity(0.4)
                    VStack{
                        Spacer()
                        HStack{
                            Image(systemName: "crown").font(.system(size: 50)).foregroundColor(.yellow)
                            Text("Its a draw")
                                .font(.largeTitle)
                                .fontWeight(.medium).foregroundColor(.yellow)
                            Image(systemName: "crown").font(.system(size: 50)).foregroundColor(.yellow)
                        }
                        
                        Button(action: {
                            playerscore = 0
                            aiscore = 0
                            ai = 0
                            player = 0
                            dealt = 0
                            self.round = 1
                            randomize()
                            
                        }, label: {
                            
                            Text("Play Again")
                                .font(.headline)
                                .foregroundColor(Color.yellow)
                                .padding(.vertical, 30)
                                .padding(.horizontal, 50)
                                .background(Color(.black))
                                .cornerRadius(15)
                            
                        }).padding()
                        
                        
                        
                        NavigationLink(
                            destination: ContentView()){
                            Text("Return to Main Menu")
                                .font(.headline)
                                .foregroundColor(Color.yellow)
                                .padding(.vertical, 30)
                                .padding(.horizontal, 50)
                                .background(Color(.black))
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                    }
                    
                }
                  
            }.navigationBarHidden(true).onAppear(perform: {
                randomize()
            })
        }.navigationBarHidden(true)
    }
    
    func aiTurn(){
        var done: Bool
        done = false
        while done != true{
            self.number = Int.random(in: 0...players.count - 1)
            if players[number].playerTeam == false && players[number].played == false {
                done = true
            }
        }
        aiCard = number
        players[aiCard].played = true
    }
    
    func playerTurn(){
        var done: Bool
        done = false
        while done != true{
            self.number = Int.random(in: 0...players.count - 1)
            if players[number].playerTeam == true && players[number].played == false {
                done = true
            }
        }
        playerCard = number
        players[playerCard].played = true
    }
    
    func winner() -> Bool{
        if  players[playerCard].overall > players[aiCard].overall{
            playerscore += (1 * self.round)
            return false
            
        }
        else if players[playerCard].overall < players[aiCard].overall{
            aiscore += (1 * self.round)
            return false
        }
        else{
            
            return true
        }
    }
    
    // To randomly distribute the cards
    func randomize(){
        var i = 0
        var reset: Bool
        reset = false
        
        while reset != true{ // resets the deck to be randomized again in case the user wants to play again
            players[i].aiTeam = false
            players[i].playerTeam = false
            players[i].played = false
            i += 1
            if i == players.count {
                reset = true
            }
        }
        
        while ai < players.count / 2{
            for count in 0...players.count - 1{
                let result = Bool.random()
                if result == true && ai < players.count / 2 {
                    players[count].aiTeam = result
                    ai += 1
                }
                
            }
        }
        while player < players.count / 2{
            for count in 0...players.count - 1{
                if players[count].aiTeam == false && player < players.count / 2 {
                    players[count].playerTeam = true
                    player += 1
                }
                
            }
        }
    }
    
    
    
    struct OverallWar_Previews: PreviewProvider {
        static var previews: some View {
            OverallWar()
        }
    }
}
