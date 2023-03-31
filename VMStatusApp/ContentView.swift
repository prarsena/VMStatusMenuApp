//  Created by petera on 2/5/23.
import SwiftUI
import Cocoa

struct ContentView: View {
    @Binding var counter: Int
    @Binding var appData: AppData
    @Binding var statusBarMenu: NSMenu
    
    @State var refresh: Bool = true
    
    var body: some View {
        VStack(){
            Text("Hello, World!")
            
            HStack(){
                Button("Refresh", action: {
                    refresh.toggle()
                })
                Button("Increase", action: {
                    //counter += 1
                    let appDelegate = NSApplication.shared.delegate as! AppDelegate
                    appDelegate.increaseCount()
                    //statusBarMenu.item(at: 0)?.title = "vmName \(counter)"
                    refresh.toggle()
                })
                Button("close", action: {
                    NSApplication.shared.keyWindow?.close()
                    
                    statusBarMenu.item(at: 0)?.title = "vmName \(counter)"
                    refresh.toggle()
                })
            }
            
            Text("Count is \(counter)")
            Text("\(String(refresh))")
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            
            let sh = try? safeShell("whoami")
            print(sh ?? "none")
            
        }
    }
}
