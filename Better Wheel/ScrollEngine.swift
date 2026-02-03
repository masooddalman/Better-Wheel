import Foundation
import Foundation
import ApplicationServices
import Combine

/// Core scrolling logic and event handling
class ScrollEngine: ObservableObject {
    
    // MARK: - Published Settings
    
    @Published var isEnabled = true {
        didSet {
            if isEnabled {
                startEventTap()
            } else {
                stopEventTap()
            }
        }
    }
    
    @Published var smoothingFactor: Double = 0.3 {  // Lower = smoother, higher = more responsive
        didSet {
            print("✏️ Smoothing factor changed to: \(smoothingFactor)")
        }
    }
    
    @Published var scrollMultiplier: Double = 1.0 {
        didSet {
            print("✏️ Scroll multiplier changed to: \(scrollMultiplier)")
        }
    }
    
    @Published var enableInertia = true {
        didSet {
            print("✏️ Inertia enabled: \(enableInertia)")
        }
    }
    
    @Published var invertScroll = false {
        didSet {
            print("✏️ Invert scroll: \(invertScroll)")
        }
    }
    
    @Published var processAllScrollEvents = false {  // For debugging: process trackpad too
        didSet {
            print("✏️ Process all scroll events: \(processAllScrollEvents)")
        }
    }
    
    // MARK: - Internal State
    
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?
    
    // Scroll state for smoothing
    private var scrollVelocityY: Double = 0
    private var scrollVelocityX: Double = 0
    
    // Inertia timer
    private var inertiaTimer: Timer?
    
    // MARK: - Initialization
    
    init() {
        loadPreferences()
    }
    
    deinit {
        stopEventTap()
    }
    
    // MARK: - Event Tap Management
    
    func startEventTap() {
        guard eventTap == nil else {
            print("⚠️ Event tap already exists, skipping creation")
            return
        }
        
        // Check permissions first
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: false]
        let trusted = AXIsProcessTrustedWithOptions(options as CFDictionary)
        print("🔐 Accessibility trusted status: \(trusted)")
        
        if !trusted {
            print("❌ No accessibility permissions - cannot create event tap")
            print("   Go to: System Settings > Privacy & Security > Accessibility")
            return
        }
        
        // Store self reference for callback
        let refcon = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        // Create event tap for scroll wheel events
        let eventMask = (1 << CGEventType.scrollWheel.rawValue)
        
        print("🔧 Creating event tap with mask: \(eventMask)")
        
        eventTap = CGEvent.tapCreate(
            tap: .cghidEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: CGEventMask(eventMask),
            callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
                guard let refcon = refcon else {
                    return Unmanaged.passUnretained(event)
                }
                
                let engine = Unmanaged<ScrollEngine>.fromOpaque(refcon).takeUnretainedValue()
                return engine.handleScrollEvent(proxy: proxy, type: type, event: event)
            },
            userInfo: refcon
        )
        
        guard let eventTap = eventTap else {
            print("❌ Failed to create event tap!")
            print("   Possible reasons:")
            print("   1. App needs to be RESTARTED after granting accessibility permission")
            print("   2. Permission was revoked in System Settings")
            print("   3. Another app is blocking event taps")
            print("")
            print("   Solutions:")
            print("   1. Quit app completely (Cmd+Q)")
            print("   2. Open System Settings > Privacy & Security > Accessibility")
            print("   3. Make sure ScrollFix is checked ✓")
            print("   4. Restart ScrollFix")
            return
        }
        
        // Add to run loop
        runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CGEvent.tapEnable(tap: eventTap, enable: true)
        
        print("✅ Event tap started successfully!")
    }
    
    func stopEventTap() {
        inertiaTimer?.invalidate()
        inertiaTimer = nil
        
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: false)
        }
        
        if let runLoopSource = runLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        }
        
        eventTap = nil
        runLoopSource = nil
        
        print("Event tap stopped")
    }
    
    // MARK: - Event Handling
    
    private func handleScrollEvent(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent) -> Unmanaged<CGEvent>? {
        // Handle tap disabled event
        if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
            print("⚠️ Event tap was disabled, re-enabling...")
            if let eventTap = eventTap {
                CGEvent.tapEnable(tap: eventTap, enable: true)
            }
            return Unmanaged.passUnretained(event)
        }
        
        guard type == .scrollWheel else {
            return Unmanaged.passUnretained(event)
        }
        
        // Check if this is a continuous (trackpad) or discrete (mouse wheel) scroll
        let isContinuous = event.getIntegerValueField(.scrollWheelEventIsContinuous) != 0
        
        print("📊 Scroll event: isContinuous=\(isContinuous)")
        
        // We primarily want to fix discrete mouse wheel scrolling
        // Trackpad scrolling usually works fine
        if isContinuous && !processAllScrollEvents {
            print("   ↳ Skipping continuous/trackpad scroll (enable 'Process All Events' to override)")
            return Unmanaged.passUnretained(event)
        }
        
        print("🖱️ Mouse wheel event - smoothing: \(smoothingFactor), multiplier: \(scrollMultiplier)")
        
        // Get raw scroll deltas
        var deltaY = event.getDoubleValueField(.scrollWheelEventDeltaAxis1)
        var deltaX = event.getDoubleValueField(.scrollWheelEventDeltaAxis2)
        
        print("   Raw delta: Y=\(deltaY), X=\(deltaX)")
        
        // Apply inversion if enabled
        if invertScroll {
            deltaY = -deltaY
            deltaX = -deltaX
        }
        
        // Apply smoothing using exponential moving average
        scrollVelocityY = scrollVelocityY * (1 - smoothingFactor) + deltaY * smoothingFactor
        scrollVelocityX = scrollVelocityX * (1 - smoothingFactor) + deltaX * smoothingFactor
        
        // Apply multiplier
        let smoothedDeltaY = scrollVelocityY * scrollMultiplier
        let smoothedDeltaX = scrollVelocityX * scrollMultiplier
        
        // Scale up for smoother pixel-based scrolling
        let pixelDeltaY = smoothedDeltaY * 10.0
        let pixelDeltaX = smoothedDeltaX * 10.0
        
        print("   Processed delta: Y=\(pixelDeltaY), X=\(pixelDeltaX)")
        
        // Create a new continuous scroll event for smoother scrolling
        if let newEvent = CGEvent(scrollWheelEvent2Source: nil,
                                   units: .pixel,
                                   wheelCount: 2,
                                   wheel1: Int32(pixelDeltaY),
                                   wheel2: Int32(pixelDeltaX),
                                   wheel3: 0) {
            
            // Start inertia simulation if enabled
            if enableInertia && (abs(deltaY) > 0.5 || abs(deltaX) > 0.5) {
                startInertia()
            }
            
            return Unmanaged.passRetained(newEvent)
        }
        
        return Unmanaged.passUnretained(event)
    }
    
    // MARK: - Inertia Simulation
    
    private func startInertia() {
        inertiaTimer?.invalidate()
        
        inertiaTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            // Decay velocity
            self.scrollVelocityY *= 0.95
            self.scrollVelocityX *= 0.95
            
            // Stop when velocity is negligible
            if abs(self.scrollVelocityY) < 0.01 && abs(self.scrollVelocityX) < 0.01 {
                self.scrollVelocityY = 0
                self.scrollVelocityX = 0
                timer.invalidate()
                self.inertiaTimer = nil
                return
            }
            
            // Post inertia scroll events
            let pixelDeltaY = self.scrollVelocityY * self.scrollMultiplier * 10.0
            let pixelDeltaX = self.scrollVelocityX * self.scrollMultiplier * 10.0
            
            if let event = CGEvent(scrollWheelEvent2Source: nil,
                                   units: .pixel,
                                   wheelCount: 2,
                                   wheel1: Int32(pixelDeltaY),
                                   wheel2: Int32(pixelDeltaX),
                                   wheel3: 0) {
                event.post(tap: .cghidEventTap)
            }
        }
    }
    
    // MARK: - Preferences Persistence
    
    func savePreferences() {
        UserDefaults.standard.set(smoothingFactor, forKey: "smoothingFactor")
        UserDefaults.standard.set(scrollMultiplier, forKey: "scrollMultiplier")
        UserDefaults.standard.set(enableInertia, forKey: "enableInertia")
        UserDefaults.standard.set(invertScroll, forKey: "invertScroll")
        UserDefaults.standard.set(isEnabled, forKey: "isEnabled")
        UserDefaults.standard.set(processAllScrollEvents, forKey: "processAllScrollEvents")
    }
    
    private func loadPreferences() {
        if UserDefaults.standard.object(forKey: "smoothingFactor") != nil {
            smoothingFactor = UserDefaults.standard.double(forKey: "smoothingFactor")
        }
        if UserDefaults.standard.object(forKey: "scrollMultiplier") != nil {
            scrollMultiplier = UserDefaults.standard.double(forKey: "scrollMultiplier")
        }
        if UserDefaults.standard.object(forKey: "enableInertia") != nil {
            enableInertia = UserDefaults.standard.bool(forKey: "enableInertia")
        }
        if UserDefaults.standard.object(forKey: "invertScroll") != nil {
            invertScroll = UserDefaults.standard.bool(forKey: "invertScroll")
        }
        if UserDefaults.standard.object(forKey: "isEnabled") != nil {
            isEnabled = UserDefaults.standard.bool(forKey: "isEnabled")
        }
        if UserDefaults.standard.object(forKey: "processAllScrollEvents") != nil {
            processAllScrollEvents = UserDefaults.standard.bool(forKey: "processAllScrollEvents")
        }
    }
}
