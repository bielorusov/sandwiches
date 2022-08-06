//
//  ContentView.swift
//  Sandwiches
//
//  Created by Dmitriy Belorusov on 8/5/22.
//

import SwiftUI

struct ContentView: View {
//  var sandwiches: [Sandwich] = []
  @ObservedObject var store: SandwichStore
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.sandwiches) { sandwich in
          SandwichCell(sandwich: sandwich)
        }
        .onMove(perform: moveSandwiches)
        .onDelete(perform: deleteSandwiches)
        HStack {
          Spacer()
          Text("\(store.sandwiches.count) sandwiches")
          Spacer()
        }
      }
      .navigationTitle("Sandwiches")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          #if os(iOS)
          EditButton()
          #endif
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Add", action: makeSandwich)
        }
      }
      .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
      
      Text("Select a sandwich")
        .font(.largeTitle)
    }
  }
  
  func makeSandwich() {
      withAnimation {
        store.sandwiches.insert(store.sandwiches.randomElement()!, at: 0)
      }
  }
  
  func moveSandwiches(from: IndexSet, to: Int) {
      withAnimation {
          store.sandwiches.move(fromOffsets: from, toOffset: to)
      }
  }
  
  func deleteSandwiches(offsets: IndexSet) {
      withAnimation {
          store.sandwiches.remove(atOffsets: offsets)
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView(store: testStore)
////      ContentView(store: testStore)
////        .environment(\.sizeCategory, .extraExtraExtraLarge)
//      ContentView(store: testStore)
//        .preferredColorScheme(.dark)
//        .environment(\.sizeCategory, .extraExtraExtraLarge)
////        .environment(\.layoutDirection, .rightToLeft)
////        .environment(\.locale, Locale(identifier: "ar"))
        
        
    }
  }
}

struct SandwichCell: View {
  var sandwich: Sandwich
  
  var body: some View {
    HStack {
      NavigationLink(destination: SandwichDetail(sandwich: sandwich)){
        Image(sandwich.thumbnailName)
          .resizable()
          .scaledToFit()
          .frame(width: 50, height: 50)
          .cornerRadius(8)
        
        VStack(alignment: .leading) {
          Text(sandwich.name)
          VStack(alignment: .leading) {
            Text("\(sandwich.ingredientCount) ingredients")
              .font(.subheadline)
              .foregroundColor(.secondary)
            Text("\(sandwich.id)")
              .font(.caption2)
              .fontWeight(.thin)
              .foregroundColor(.secondary)
              .lineLimit(1)
          }
        }
      }
    }
  }
}
