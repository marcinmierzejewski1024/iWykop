//
//  SettingsView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 01/03/2022.
//

import SwiftUI
import AxisSegmentedView


struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore

    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("Content settings").modifier(TitleStyle())) {
                        Toggle(isOn: $settings.autoplayAnimated) {
                            Text("Autoplay animated images").modifier(OtherTextStyle())
                        }
                        
                        Toggle(isOn: $settings.openInSafari) {
                            Text("Open links in external browser").modifier(OtherTextStyle())
                        }
                        Toggle(isOn: $settings.plus18Enabled) {
                            Text("Show +18 content").modifier(OtherTextStyle())
                        }
                        

                        HStack {
                        Text("Theme").modifier(OtherTextStyle())
                        Spacer()

                        AxisSegmentedView(selection: $settings.selectedTheme, constant: .init()) {
                            Text("Light").foregroundColor(.accentColor)
                                .itemTag(0, selectArea: 0) {
                                    Text("Light").bold()
                                    
                                }
                            Text("Dark").foregroundColor(.accentColor)
                            
                                .itemTag(1, selectArea: 0) {
                                    Text("Dark").bold()
                                }
                            Text("OLED").foregroundColor(.accentColor)
                            
                                .itemTag(2, selectArea: 0) {
                                    Text("OLED").bold()
                                }
                        } style: {
                            ASScaleStyle(backgroundColor: .clear, foregroundColor: WykopColors.shared.currentTheme.accentColor.opacity(0.4), cornerRadius: 4.0)
                            
                        } onTapReceive: { selectionTap in
                            settings.selectedTheme = selectionTap;
                        }
                        .frame(width: 200, height: 30)
                        }
                    }
                    
                    Section(header: Text("Assets").modifier(TitleStyle())) {
                        Button("https://www.flaticon.com/free-icons/hide"){
                            
                            if let url = URL(string: "https://www.flaticon.com/free-icons/hide") {
                                BasePushableViewModel.urlHandler?.handleUrl(url: url)
                            }
                        }.font(.settingsFont()).foregroundColor(.mint)
                    }
                    
                    
                    
                }.navigationBarTitle(Text("Settings"))
            }
        }
    }
}

