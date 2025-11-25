# macOS Audio Recording App

## Overview

This is a native macOS application that captures audio from the microphone and allows users to manage their recordings.  

---

## Features Implemented

### Audio Recording
- Record audio from the microphone.
- Controls: **Start Recording**, **Stop Recording**, **Pause / Resume Recording**.
- Display recording status: `Recording`, `Paused`, `Stopped`.
- Show recording duration timer.
- Supports audio formats: **M4A**, **WAV**, **CAF**.

### User Interface
- Clean, intuitive macOS interface using **SwiftUI**.
- List of previous recordings with timestamp labels.
- Basic error handling with alerts.
- Supports dock badge to indicate active recording.

### Data Persistence
- Save recordings as files in the temporary directory.
- Store metadata: recording timestamp, duration, file size.
- Data persists between app launches using **CoreData**.

### Additional Features
- Microphone permission handling:
  - Alerts user if permission is denied.
  - Option to navigate to **System Settings** to enable microphone access.
- Audio visualization: shows a live waveform of microphone input.
- Ability to share audio files via native macOS share menu.

---

## Setup Instructions

1. **Requirements**
   - macOS 12.0+
   - Xcode 15.0+
   - Swift 5.9+
   - Deployment target: macOS 12.0+

2. **Installation**
   - Clone the repository:
     ```bash
     git clone https://github.com/Milker-Motor/Audio-Recording-App.git
     ```
   - Open `AudioRecordingApp.xcodeproj` in Xcode.
   - Build and run the application (Cmd + R).

---

## Architecture Overview

- **SwiftUI + MVVM**:  
  - Views are fully declarative, observing state from **ViewModels**.
  - Reactive updates handled via **Combine**.
  
- **Audio Layer**:  
  - `AVAudioRecorder` (via `AudioRecorder` class) manages recording.
  - Waveform visualization updated with a timer reading average power levels.
  
- **Persistence**:  
  - Recordings are stored as files.
  - Metadata is saved in **CoreData** for simplicity.
  
- **Error Handling**:  
  - Custom `AppError` enum for permission and recording errors.
  - UI presents alerts for errors and allows navigation to system settings if needed.

---

## macOS-Specific Considerations

- Microphone permissions handled using AVFoundation APIs.
- App uses native file paths and conforms to sandboxing rules.
- Dock badge shows live recording status.

---

## Design Decisions

- **Persistence**: Chose `CoreData` for metadata.
- **Audio Formats**: Focused on **M4A** for better compression and quality, but could be used **WAV**, **CAF**.
- **Waveform Updates**: Implemented via `Timer` rather than continuous Combine stream for simplicity and performance.
- **Concurrency**: Recording is async, using Swift `async/await` for clarity.

---

## Known Limitations / Future Improvements

- No system audio capture (microphone only).
- Only supports one input device (default system microphone).
- Waveform visualization is simplified.
- Could add menu bar app mode, Touch Bar support, or multiple audio input selection.

---

## Screenshots / Demo

![Recording Screen](screenshots/recording_screen.png)  
![Waveform Visualization](screenshots/waveform.png)  
![Recordings List](screenshots/recordings_list.png)

---

## How to Test

1. Run the app in Xcode on macOS 13+.
2. Grant microphone access when prompted.
3. Start a recording; verify timer and waveform updates.
4. Pause and resume recordings.
5. Stop recordings and check that files are saved with metadata.
6. Relaunch the app and verify recordings persist in the list.

