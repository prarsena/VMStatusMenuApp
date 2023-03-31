import Cocoa
import SwiftUI

class AppData: ObservableObject {
    @Published var counter: Int = 0
    @Published var vmName: String = "myVM"
    @Published var refresh: Bool = false
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var createVmWindow: NSWindow!
    var statusBarItem: NSStatusItem!
    @State var appData = AppData()
    @State var statusBarMenu = NSMenu(title: "Counter Bar Menu")

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("App running, check menu bar lol")
        
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.variableLength)
        
        statusBarItem.button?.image = NSImage(named: NSImage.Name("custom.rectangle.on.rectangle.square.fill"))
        
        statusBarItem.menu = statusBarMenu
        
        statusBarMenu.addItem(
            withTitle: "vmName \(appData.counter)",
            action: #selector(AppDelegate.increaseCount),
            keyEquivalent: "")
        
        statusBarMenu.item(at: 0)?.image = NSImage(named: "NSStatusNone")
        
        statusBarMenu.addItem(
            withTitle: "Decrease",
            action: #selector(AppDelegate.decreaseCount),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "Settings..",
            action: #selector(AppDelegate.openSettings),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "Refresh",
            action: #selector(AppDelegate.refresh),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(AppDelegate.quit),
            keyEquivalent: "")
        
        
         
    }
    
    @objc func increaseCount() {
        appData.counter += 1
        do {
            let sh = try? safeShell("whoami")
            print(sh ?? "none")
        }
        
        statusBarItem.button?.image = NSImage(named: NSImage.Name("custom.rectangle.on.rectangle.square.fill"))
        statusBarItem.button?.title = "\t \(appData.counter)"
        statusBarItem.button?.contentTintColor = NSColor.red
        statusBarMenu.item(at: 0)?.title = "vmName \(appData.counter)"
    }
    
    @objc func refresh() {
        appData.counter += 5
        appData.refresh.toggle()
        print(appData.refresh)
        
        statusBarMenu.item(at: 0)?.image = NSImage(named: "NSStatusUnavailable")
        statusBarMenu.item(at: 0)?.title = "vmName \(appData.counter)"
        
        statusBarItem.button?.image = NSImage(named: NSImage.Name("custom.rectangle.on.rectangle.square.fill"))
        statusBarItem.button?.title = "\t \(appData.counter)"
        statusBarItem.button?.contentTintColor = NSColor.red
    }
    
    @objc func decreaseCount() {
        appData.counter -= 1
        appData.refresh.toggle()
        
        statusBarMenu.item(at: 0)?.title = "vmName \(appData.counter)"
        statusBarItem.button?.image = NSImage(named: NSImage.Name("custom.rectangle.on.rectangle.square.fill"))
        statusBarItem.button?.title = "\t \(appData.counter)"
        statusBarItem.button?.contentTintColor = NSColor.red
        
        executeAsyncCommand(at: "pete rules", completion: {
            result in DispatchQueue.main.async{
                if !(result == "" ){
                    self.statusBarMenu.item(at: 0)?.image = NSImage(named: "NSStatusAvailable")
                    self.statusBarMenu.item(at: 0)?.title = "vmName \(self.appData.counter)"
                }
            }
        })
        
    }
    
    @objc func openSettings() {
        
        
        createVmWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        createVmWindow.isReleasedWhenClosed = false
        createVmWindow.setFrameAutosaveName("Create VM")
        createVmWindow.center()
        createVmWindow.contentView = NSHostingView(rootView: ContentView(counter: $appData.counter, appData: $appData, statusBarMenu: $statusBarMenu) )
        createVmWindow.makeKeyAndOrderFront(nil)
        
        
    }
    
    @objc func quit() {
        print("Shutting down")
        NSApplication.shared.terminate(self)
    }
 }
  

func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
}

func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
