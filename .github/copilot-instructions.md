# Sudoku iOS App
Sudoku is an iOS app built with SwiftUI that provides an AI-powered Sudoku game experience with multiple difficulty levels, hint system, and game persistence. The app supports iPhone, iPad, and Apple Vision Pro devices.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Critical Limitations and Requirements

### Platform Requirements
- **ESSENTIAL**: This project REQUIRES macOS and Xcode. It CANNOT be built, run, or properly tested on Linux, Windows, or any non-macOS environment.
- **Xcode Installation**: Must have Xcode 15.2+ installed with iOS 17.0+ SDK
- **iOS Simulator**: Required for running and testing the app
- **Network Access**: Required for AI hint functionality (uses external AIProxy service)

### What NOT to Do
- **DO NOT** attempt to build using `swift build` or Swift Package Manager directly - this is an Xcode project
- **DO NOT** try to run on Linux/Windows environments - will fail completely  
- **DO NOT** cancel builds or tests that appear to hang - iOS builds routinely take 5-10 minutes
- **DO NOT** modify the AIProxy dependency without testing hint functionality
- **DO NOT** change iOS deployment targets below 17.0 - app uses SwiftData and modern SwiftUI features
- **DO NOT** run the app without iOS Simulator - requires iOS runtime environment

## Working Effectively

### Prerequisites and Environment Setup
- **CRITICAL**: This project requires macOS and Xcode for building, testing, and running. It cannot be built or run on Linux or Windows.
- **Xcode Version**: Compatible with Xcode 15.2+ (LastUpgradeVersion = "1520")
- **Swift Version**: 5.0
- **iOS Deployment Target**: 17.0 (tests require 17.2)
- **Dependencies**: AIProxy Swift library (automatically resolved via SPM)

### Build and Test Commands
- **Build the app**: `xcodebuild -project Sudoku.xcodeproj -scheme Sudoku -configuration Debug build` -- takes 2-5 minutes depending on hardware. NEVER CANCEL. Set timeout to 10+ minutes.
- **Build for release**: `xcodebuild -project Sudoku.xcodeproj -scheme Sudoku -configuration Release build` -- takes 3-7 minutes. NEVER CANCEL. Set timeout to 15+ minutes.
- **Run tests**: `xcodebuild -project Sudoku.xcodeproj -scheme SudokuTests -destination 'platform=iOS Simulator,name=iPhone 15' test` -- takes 1-3 minutes. NEVER CANCEL. Set timeout to 10+ minutes.
- **Run tests with coverage**: `xcodebuild -project Sudoku.xcodeproj -scheme SudokuTests -destination 'platform=iOS Simulator,name=iPhone 15' test -enableCodeCoverage YES`
- **Clean build folder**: `xcodebuild -project Sudoku.xcodeproj -scheme Sudoku clean`
- **Archive for distribution**: `xcodebuild -project Sudoku.xcodeproj -scheme Sudoku -configuration Release archive -archivePath ./build/Sudoku.xcarchive` -- takes 5-10 minutes. NEVER CANCEL. Set timeout to 20+ minutes.

### Available iOS Simulator Destinations
- `'platform=iOS Simulator,name=iPhone 15'` (recommended)
- `'platform=iOS Simulator,name=iPhone 15 Plus'`
- `'platform=iOS Simulator,name=iPad Air (5th generation)'`
- `'platform=visionOS Simulator,name=Apple Vision Pro'` (if Vision Pro SDK available)

### Running the App
- **iOS Simulator**: Open `Sudoku.xcodeproj` in Xcode, select an iOS Simulator device (iPhone 15 recommended), and click Run (⌘+R)
- **Physical Device**: Requires Apple Developer account and device provisioning
- **Apple Vision Pro**: Use Vision Pro Simulator (requires Xcode 15.2+ and Vision Pro SDK)

### Dependencies Management
- Dependencies are managed via Swift Package Manager integrated into Xcode
- **AIProxy**: External library for AI-powered hint generation (https://github.com/lzell/aiproxyswift)
- **SwiftUI & SwiftData**: Apple frameworks for UI and data persistence (built-in)
- **XCTest**: Testing framework (built-in)
- Dependencies are automatically resolved when building the project

## Validation Scenarios

### Core Functionality Testing
Always test these user scenarios after making changes:
1. **New Game Flow**: Launch app → Select difficulty (Easy/Medium/Hard) → Verify grid loads with appropriate number of filled cells
2. **Game Interaction**: Tap empty cell → Select number from bottom panel → Verify number appears in cell
3. **Hint System**: During game → Tap "Hint" button → Verify AI-generated hint appears (requires network connection)
4. **Save/Continue**: Start game → Navigate away → Return to menu → Verify "Continue game" button appears
5. **Settings**: Navigate to settings → Test "Delete saved data" and "Clear hint cache" functions

### Mandatory Validation Steps
**CRITICAL**: Always perform these validation steps after making changes:
1. **Build Success**: Project builds without errors on both Debug and Release configurations
2. **Test Suite**: All existing unit tests pass without modification
3. **App Launch**: App launches successfully in iOS Simulator without crashes
4. **Grid Rendering**: Sudoku grid displays correctly with proper cell boundaries and colors
5. **Number Input**: Can select cells and input numbers 1-9 using the bottom number pad
6. **Hint Integration**: Hint button appears and makes network requests (may show "quota exceeded" in development)
7. **Navigation**: Can navigate between menu, game, settings, and how-to-play views
8. **Data Persistence**: Game state saves and restores correctly when navigating away and back

### Manual Testing Scenarios
Execute these complete workflows to ensure functionality:
1. **Complete Game Session**: 
   - Start new Easy game → Fill several numbers → Request hint → Save by navigating away → Return and continue → Complete puzzle
2. **Settings Workflow**:
   - Navigate to settings → Clear hint cache → Delete saved data → Verify no continue button in menu
3. **Cross-Device Testing**:
   - Test on iPhone simulator (portrait only) → Test on iPad simulator (all orientations) → Verify adaptive layouts

### AI Hint System Validation
- Verify hint requests work with network connection (uses AIProxy service)
- Test graceful degradation when network is unavailable
- Verify hints provide logical suggestions without revealing direct solutions

### Cross-Platform Testing
- **iPhone**: Portrait orientation, adaptive UI
- **iPad**: Larger grid display, landscape support
- **Vision Pro**: Special celebration message and animations (if available)

## Architecture Overview

### Key Directories and Files
```
Sudoku/
├── SudokuApp.swift           # Main app entry point
├── Menu/
│   ├── MenuView.swift        # Main menu interface
│   └── MenuViewModel.swift   # Menu logic and navigation
├── Game/
│   ├── GameView.swift        # Main game interface
│   ├── GameViewModel.swift   # Game state management
│   └── Grid/                 # Grid UI components
├── Models/                   # Data models and game logic
│   ├── GridValues.swift      # Sudoku grid representation
│   ├── GameConfig.swift      # SwiftData model for persistence
│   ├── Difficulty.swift      # Game difficulty levels
│   └── Hint.swift           # AI hint system models
├── SudokuSolver.swift        # Core Sudoku solving algorithms
├── API.swift                 # AI hint integration
├── SettingsView.swift        # App settings interface
└── Shared/                   # Common utilities and extensions

SudokuTests/
└── RowViewModelTests.swift   # Unit tests for grid UI logic
```

### Application Architecture
- **Pattern**: Model-View-ViewModel (MVVM) with SwiftUI
- **Data Persistence**: SwiftData for game state and user preferences
- **UI Framework**: SwiftUI with platform-adaptive layouts
- **Networking**: AIProxy for AI hint generation
- **Testing**: XCTest framework for unit tests

## Development Guidelines

### Code Style and Patterns
- Follow SwiftUI and Swift naming conventions
- Use `@Observable` for view models (modern SwiftUI pattern)
- Leverage SwiftData for persistent storage
- Use `@Environment` for dependency injection
- Maintain separation between UI logic and game logic

### Testing Approach
- Unit tests focus on view models and business logic
- UI testing requires iOS Simulator (cannot be automated in CI without macOS)
- Always run existing tests before submitting changes
- Add new tests for new view models or business logic

### Common Tasks and Locations
- **Adding new difficulty**: Update `Difficulty.swift` and `GridFactory.swift`
- **Modifying hint system**: Update `API.swift` and `Hint.swift`
- **UI changes**: Primarily in view files within respective directories
- **Game logic**: `SudokuSolver.swift` and model files
- **Persistence**: `GameConfig.swift` (SwiftData model)

## Troubleshooting

### Build Issues
- **"No such module 'AIProxy'"**: Dependencies may need resolution. Clean and rebuild project, or run `xcodebuild -project Sudoku.xcodeproj -resolvePackageDependencies`
- **"iOS deployment target too low"**: Ensure all targets use iOS 17.0+ in project settings
- **Signing errors**: Requires Apple Developer account for device deployment
- **"Command line tool 'xcodebuild' requires Xcode"**: This project cannot be built without Xcode on macOS. Do not attempt to build on Linux or Windows.
- **Build timeout**: iOS builds can take 3-10 minutes depending on hardware. Always set timeouts to 15+ minutes for builds and never cancel.

### Specific Error Messages
- **"error: Scheme 'Sudoku' does not exist"**: Use exact scheme names: `Sudoku` for app, `SudokuTests` for tests
- **"error: Unable to find a destination matching the provided destination specifier"**: Ensure iOS Simulator is available and running
- **"The operation couldn't be completed. Unable to log in with account"**: Xcode needs Apple ID for simulator deployment (can often be skipped with Continue)

### Runtime Issues
- **Hints not working**: Check network connection and AIProxy service availability. Development builds may hit quota limits.
- **"quotaExceeded" error in hints**: Normal in development environment. Production app uses different quota limits.
- **Data not persisting**: SwiftData may need model container reset via settings → "Delete saved data"
- **UI layout issues**: Test across different device sizes and orientations. Use iPad and iPhone simulators.
- **App crashes on launch**: Check for SwiftData migration issues or missing required iOS version

### Testing Issues  
- **Tests fail to run**: Ensure iOS Simulator is available and SudokuTests scheme exists
- **"Build target 'SudokuTests' does not exist"**: Use correct test command with SudokuTests scheme
- **Tests timeout**: Unit tests typically take 30 seconds to 2 minutes. Set timeout to 5+ minutes.

### Performance Considerations
- Grid rendering optimized for 60fps on all supported devices
- AI hint caching reduces network requests
- SwiftData provides efficient local storage for game state

## Environment Variables
The app uses the following environment variable for development:
- `AIPROXY_DEVICE_CHECK_BYPASS`: Set to "4b422179-0d3b-487e-83e7-ec85232d61db" for testing (configured in Xcode scheme)

## Bundle Information
- **Bundle ID**: com.rckim.Sudoku
- **Current Version**: 4.12.0 (30)
- **Supported Devices**: iPhone, iPad, Apple Vision Pro
- **Supported Orientations**: Portrait and Portrait Upside Down (iPhone), All orientations (iPad)

## Common Commands Reference

The following are outputs from frequently run commands. Reference them instead of running bash commands to save time.

### Project Structure
```bash
ls -la /path/to/Sudoku
.git/
.github/
.gitignore
README.md
Sudoku/              # Main app source code
Sudoku.xcodeproj/    # Xcode project file
SudokuTests/         # Unit tests
```

### Key Source Files
```bash
find Sudoku -name "*.swift" -type f | head -15
Sudoku/SudokuApp.swift
Sudoku/API.swift
Sudoku/SettingsView.swift
Sudoku/SudokuSolver.swift
Sudoku/Menu/MenuView.swift
Sudoku/Menu/MenuViewModel.swift
Sudoku/Game/GameView.swift
Sudoku/Game/GameViewModel.swift
Sudoku/Models/GridValues.swift
Sudoku/Models/GameConfig.swift
Sudoku/Models/Difficulty.swift
Sudoku/Models/Hint.swift
Sudoku/Shared/Extensions.swift
SudokuTests/RowViewModelTests.swift
```

### Bundle Information Query
```bash
/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" Sudoku/Info.plist
4.12.0

/usr/libexec/PlistBuddy -c "Print CFBundleVersion" Sudoku/Info.plist  
30

/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" Sudoku/Info.plist
com.rckim.Sudoku
```

### Expected Build Output
```bash
xcodebuild -project Sudoku.xcodeproj -scheme Sudoku -configuration Debug build
# Expected output includes:
=== BUILD TARGET Sudoku OF PROJECT Sudoku WITH CONFIGURATION Debug ===
Check dependencies
PhaseScriptExecution [CP] Check Pods Manifest.lock
CompileC Sudoku/SudokuApp.swift
CompileSwiftSources normal x86_64 
LinkStoryboards Sudoku
ProcessInfoPlistFile 
...
** BUILD SUCCEEDED **
```

### Expected Test Output  
```bash
xcodebuild -project Sudoku.xcodeproj -scheme SudokuTests -destination 'platform=iOS Simulator,name=iPhone 15' test
# Expected output includes:
=== TEST TARGET SudokuTests OF PROJECT Sudoku WITH CONFIGURATION Debug ===
Test Suite 'All tests' started
Test Suite 'SudokuTests.xctest' started
Test Suite 'RowViewModelTests' started
Test Case 'testBackgroundColorForColumnIndex...' passed
...
Executed 6 tests, with 0 failures (0 unexpected) in 0.xxx seconds
** TEST SUCCEEDED **
```

### SwiftUI Preview Notes
- SwiftUI Previews work for individual views but may require manual refresh
- Some previews depend on SwiftData context and may not render completely
- Use Xcode's Canvas feature for interactive preview testing

## Quick Reference Checklist

Before making any changes, verify:
- [ ] Running on macOS with Xcode 15.2+
- [ ] iOS Simulator is available
- [ ] Project builds successfully: `xcodebuild -project Sudoku.xcodeproj -scheme Sudoku build`
- [ ] Tests pass: `xcodebuild -project Sudoku.xcodeproj -scheme SudokuTests -destination 'platform=iOS Simulator,name=iPhone 15' test`

After making changes, validate:
- [ ] Code builds without errors in both Debug and Release
- [ ] All existing tests continue to pass
- [ ] App launches and displays main menu correctly in simulator
- [ ] Can create new game and interact with Sudoku grid
- [ ] Navigation between screens works correctly
- [ ] No crashes or UI layout issues on different device sizes

For UI changes specifically:
- [ ] Test on both iPhone (portrait) and iPad (all orientations) simulators
- [ ] Verify grid layout and number input functionality
- [ ] Check that colors and fonts render correctly in both light and dark modes