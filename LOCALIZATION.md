# Sudoku App Localization Guide

This document describes the localization implementation for the Sudoku iOS app, which supports English (Base) and Korean languages.

## Overview

The Sudoku app has been fully localized using Swift's built-in localization system. All user-facing text has been extracted to `.strings` files, making it easy to add new languages in the future.

## File Structure

```
Sudoku/
├── Base.lproj/
│   └── Localizable.strings    # English (default) translations
├── ko.lproj/
│   └── Localizable.strings    # Korean translations
└── [Swift files using localized strings]
```

## Supported Languages

- **English** (Base language) - `Base.lproj/`
- **Korean** - `ko.lproj/`

## String Categories

The localization keys are organized into logical categories:

### App Identity
- `app_title` - Main app title
- `continue_game` - Continue saved game
- `new_game` - Start new game

### Difficulty Levels  
- `difficulty_easy` - Easy level
- `difficulty_medium` - Medium level
- `difficulty_hard` - Hard level

### Navigation
- `nav_stats` - Statistics screen
- `nav_how_to_play` - Instructions screen
- `nav_settings` - Settings screen

### Game Actions
- `action_undo` - Undo move
- `action_save` - Save game
- `action_confirm` - Confirm action
- `action_cancel` - Cancel action
- `action_clear` - Clear cell
- `action_edit` - Edit mode
- `action_hint` - Get hint

### Alerts and Messages
- Alert titles: `alert_congratulations`, `alert_almost`, etc.
- Alert messages: `alert_completed_correctly`, `alert_hint_error`, etc.
- Alert actions: `alert_go_back`, `alert_thanks`, etc.

### Settings
- `settings_version` - Version string format
- `settings_copyright` - Copyright notice
- `settings_website` - Website button
- `settings_delete_data` - Delete data button
- `settings_clear_cache` - Clear cache button

### Statistics  
- `stats_title` - Statistics screen title
- `stats_fastest_time` - Fastest completion time
- `stats_total_games` - Total games completed
- Time formatting: `time_format_hours_minutes_seconds`, etc.

### Instructions (How to Play)
- `howto_title` - Instructions screen title
- `howto_intro` - Introduction text
- `howto_rule_*` - Game rules explanation
- `howto_conclusion_*` - Conclusion text

### Hint System
- `hint_loading` - Generating hint message
- `hint_naked_single` - Naked single hint
- `hint_hidden_single` - Hidden single hint
- `hint_*_value` - Specific value hints

## Usage in Code

### Basic Text Localization
```swift
// Simple localized text
Text("app_title")

// Navigation titles
.navigationTitle("howto_title")

// Button labels
Button("action_save") { /* action */ }
Label("nav_stats", systemImage: "chart.bar")
```

### Parameterized Strings
```swift
// Version string with parameters
Text("settings_version", locale: .current, arguments: appVersion, buildVersion)

// Time formatting
String(localized: "time_format_hours_minutes_seconds", 
       defaultValue: "%d hours, %d minutes, and %d seconds",
       table: nil, locale: .current, 
       arguments: hours, minutes, seconds)
```

### Alert Messages
```swift
// Alert titles and messages
.alert("alert_data_deleted", isPresented: $showAlert) {
    Button("alert_ok") { }
} message: {
    Text("alert_data_deleted_message")
}
```

## Adding New Languages

To add a new language (e.g., Spanish):

1. **Create Language Directory**: `es.lproj/`
2. **Copy Base Strings**: Copy `Base.lproj/Localizable.strings` to `es.lproj/Localizable.strings`
3. **Translate Values**: Translate only the values (right side of = sign)
4. **Update Xcode Project**: Add the new language in Xcode project settings
5. **Test**: Verify all strings display correctly in the new language

## Translation Guidelines

### Korean Localization Notes
- Uses formal polite speech level (합니다체)
- Time units properly localized (시간, 분, 초)
- Button actions use appropriate Korean UI conventions
- Alert messages maintain respectful tone

### Best Practices
- Keep key names in English for consistency
- Use descriptive, hierarchical key naming (e.g., `settings_delete_data`)
- Provide fallback values for safety
- Test with longer translations (Korean text can be 20-30% longer)
- Consider cultural context, not just literal translation

## Maintenance

### Adding New Strings
1. Add the key-value pair to `Base.lproj/Localizable.strings`
2. Add translated versions to all other language files
3. Use the key in your Swift code
4. Test in all supported languages

### Updating Existing Strings
1. Update the value in the appropriate `.strings` file
2. No code changes needed if key remains the same
3. Test to ensure layout still works with new text

## Technical Implementation

### Automatic Language Selection
The app automatically displays in the user's preferred language if supported, falling back to English for unsupported languages.

### Performance
- Strings are loaded efficiently by the system
- No runtime performance impact
- Minimal memory overhead

### Testing
Run the app with different device languages:
- Settings → General → Language & Region → iPhone Language
- Choose Korean to see Korean interface
- Choose English to see English interface

## Future Enhancements

Potential improvements for the localization system:
- Add more languages (Japanese, Spanish, French, etc.)
- Implement right-to-left (RTL) language support
- Add locale-specific number formatting
- Include region-specific cultural adaptations

---

*This localization system provides a solid foundation for multi-language support and can be easily extended as the app grows.*