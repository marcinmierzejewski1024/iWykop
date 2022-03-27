import SwiftUI


struct Tabs<Label: View>: View {
    @Binding var tabs: [String] // The tab titles
    @Binding var selection: Int // Currently selected tab
    let underlineColor: Color // Color of the underline of the selected tab
    // Tab label rendering closure - provides the current title and if it's the currently selected tab
    let label: (String, Bool) -> Label
    
    var body: some View {
        // Pack the tabs horizontally and allow them to be scrolled
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 30) {
                ForEach($tabs, id: \.self) {tab in
                    self.tab(title: tab.wrappedValue)
                }
            }.padding(.horizontal, Margins.small.rawValue) // Tuck the out-most elements in a bit
        }
    }
    
    func tab(title: String) -> some View {
        let index = self.tabs.firstIndex(of: title)!
        let isSelected = index == selection
        return Button(action: {
            // Allows for animated transitions of the underline,
            // as well as other views on the same screen
            withAnimation {
                self.selection = index
            }
        }) {
            label(title, isSelected)
                .overlay(Rectangle() // The line under the tab
                            .frame(height: 2)
                         // The underline is visible only for the currently selected tab
                            .foregroundColor(isSelected ? underlineColor : .clear)
                            .padding(.top, Margins.small.rawValue)
                         // Animates the tab selection
                            .transition(.move(edge: .bottom)) ,alignment: .bottomLeading)
        }
    }
}
