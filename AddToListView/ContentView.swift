//
//  ContentView.swift
//  AddToListView
//
//  Created by Bryan Monsalvatge on 2/2/20.
//  Copyright © 2020 Bryan Monsalvatge. All rights reserved.
//

import SwiftUI

struct Item: Hashable {
    let name: String
    let color: UIColor
}

struct ContentView: View {
    
    @State var listItems = [Item]()
    
    @State var addItemName: String = ""
    @State var colorSelection: UIColor = UIColor.systemRed
    
    @State var addItem = false
    
    var body: some View {
        ZStack {
                VStack {
                    NavigationView {
                        List {
                            ForEach(listItems, id: \.self) { item in
                                Text(item.name).listRowBackground(Color(item.color))
                            }
                        }
                            .navigationBarTitle(Text("List Items"))
                            .navigationBarItems(trailing:
                                Button(action: {
                                    self.addItem.toggle()
                                }, label: {
                                    Image(systemName: "plus")
                                })
                                    
                        )
                    }.sheet(isPresented: $addItem) {
                        VStack {
                            HStack {
                                Text("Item Name: ")
                                TextField("Add an Item", text: self.$addItemName)
                            }
                            
                            Picker(selection: self.$colorSelection, label: Text("Select a Color")) {
                                Text("Red").tag(UIColor.systemRed)
                                Text("Blue").tag(UIColor.systemBlue)
                                Text("Green").tag(UIColor.systemGreen)
                                Text("Yellow").tag(UIColor.systemYellow)
                            }
 
                            Button(action: {
                                self.listItems.append(Item(name: self.addItemName, color: self.colorSelection))
                                self.addItem.toggle()
                                
                                print(self.listItems)
                                
                                // Reset Values
                                self.addItemName = ""
                                self.colorSelection = UIColor.systemRed
                            }, label: {
                                Text("Add")
                            })
                        }.padding(100)
                    }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(listItems: [Item(name: "test 1", color: UIColor.systemRed)], colorSelection: UIColor.systemRed, addItem: true)
    }
}
