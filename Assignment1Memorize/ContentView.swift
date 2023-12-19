//
//  ContentView.swift
//  Assignment1Memorize
//
//  Created by Саша Восколович on 18.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: [String] = []
    @State private var selectedThemeIndex: Int?
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            VStack {
                ScrollView {
                    cards
                }
                Spacer()
                cardThemeChoosers
            }
        }
        .padding()
        .onAppear {
            emojis = generateShuffledEmoji()
        }
    }
    
    var firstTheme: some View {
        cardThemeChooser(by: 2, with: "fork.knife")
    }
    var secondTheme: some View {
        cardThemeChooser(by: 0, with: "dog")
    }
    
    var thirdTheme: some View {
        cardThemeChooser(by: 1, with: "globe")
    }
    
    var cardThemeChoosers: some View {
        HStack(spacing: 20) {
               firstTheme
               secondTheme
               thirdTheme
           }
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 8) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2 / 3, contentMode: .fill)
            }
        }
        .foregroundStyle(getColor(for: selectedThemeIndex ?? 0))
    }
    
    func getColor(for theme: Int) -> Color {
        switch theme {
        case 0:
            return .red
        case 1:
            return .green
        case 2:
            return .blue
        default:
            return .primary
        }
    }
    
    func generateShuffledEmoji() -> [String] {
        return (Theme.get(by: selectedThemeIndex ?? 0) + Theme.get(by: selectedThemeIndex ?? 0)).shuffled()
        
    }
    
    func cardThemeChooser(by index: Int, with symbol: String) -> some View {
        Button(action: {
            selectedThemeIndex = index
            emojis = generateShuffledEmoji()
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
                Text("\(Theme.get(name: index))")
            }
        })
        .disabled(selectedThemeIndex == index)
    }
    
}

#Preview {
    ContentView()
}

struct CardView: View {
    
    let content: String
    @State var isFaseUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .foregroundStyle(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaseUp ? 1 : 0)
            
            base.opacity(isFaseUp ? 0 : 1)
        }
        .onTapGesture {
            isFaseUp.toggle()
        }
    }
}
