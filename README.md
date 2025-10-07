# Contacts

A modern SwiftUI contacts app for iOS featuring a gradient-rich UI, searchable contact list, and an animated, collapsible contact detail header.

## Features

- SwiftUI-first design with NavigationStack and TabView
- Contacts tab with:
  - Search by name or phone number
  - Contact list with avatars and navigation to details
- Calls tab (placeholder)
- Keyboard tab (placeholder)
- Contact detail screen with:
  - Glass/gradient avatar
  - Collapsing header animation on drag
  - Quick action buttons (message, phone, video, email)
  - Contact info rows
- Light, clean architecture with simple models and sample data

## Screens

- HomeView: Tab-based navigation (Contacts, Calls, Keyboard, Add)
- ContactsView: Searchable list of contacts
- ContactDetailView: Animated profile with action buttons and info
- KeyboardView: Placeholder
- CallsView: Placeholder (not included yet; see TODO)

## Tech Stack

- Language: Swift
- UI: SwiftUI
- Navigation: NavigationStack
- Concurrency: N/A (no async flows yet)
- Minimum iOS: iOS 17+ recommended (uses modern SwiftUI APIs like Tab initializer with role and glassEffect-style visuals)

## Project Structure

- ContactsApp.swift: App entry point
- HomeView.swift: Main TabView
- ContactsView.swift: Contact model, search bar, list
- ContactDetailView.swift: Detail view with drag-based collapsing header
- KeyboardView.swift: Placeholder

Note: HomeView references CallsView, which isn’t included yet. Add a stub to build successfully.

## Requirements

- Xcode: 16+
- Swift: 5.9+
- iOS: 17.0+ (adjust if you replace APIs like .toolbar(.hidden, for:) or glass effects)
- Dependencies: None (no SPM/CocoaPods)

## Setup & Run

1. Open the project in Xcode.
2. Ensure the iOS deployment target and toolchain match the Requirements.
3. Build and run on the iOS Simulator or a device.

## Testing

No tests are included yet. Suggested next steps:
- Add Swift Testing-based suites for:
  - Filtering logic in ContactsView.filteredContacts
  - UI previews using snapshot testing (optional)

Example Swift Testing skeleton:

```swift
import Testing

@Suite("Contacts Filtering")
struct ContactsFilteringTests {
    @Test
    func filtersByNameOrPhone() throws {
        let contacts = Contact.sampleContacts
        let query = "Emily"
        let filtered = contacts.filter { $0.name.localizedCaseInsensitiveContains(query) || $0.phoneNumber.contains(query) }
        #expect(!filtered.isEmpty)
    }
}
