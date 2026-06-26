# Tree Familia Implementation Plan

This plan outlines the step-by-step development of Tree Familia, an offline-first family tree application with a retro/historic aesthetic, starting from landing page to homepage with tree management features.

## Phase 1: Project Setup & Architecture Foundation

**1.1 Project Structure Setup**
- Create clean architecture folders: `lib/core/`, `lib/features/`, `lib/shared/`
- Set up Riverpod provider structure in `lib/core/providers.dart`
- Create routing/navigation system
- Set up theme configuration with retro/historic color scheme (light yellow, warm tones)

**1.2 Database Schema Design (Drift)**
- Create `lib/core/database/app_database.dart` with Drift setup
- Define tables:
  - `trees` (id, name, created_at, updated_at)
  - `family_members` (id, tree_id, full_name, nickname, gender, birth_date, death_date, photo_path, bio)
  - `relationships` (id, tree_id, from_member_id, to_member_id, relationship_type)
- Generate database code with build_runner

**1.3 Repository Layer**
- Create `TreeRepository` in `lib/features/trees/data/tree_repository.dart`
- Create `FamilyMemberRepository` in `lib/features/members/data/member_repository.dart`
- Set up Riverpod providers for repositories

## Phase 2: Landing Page & Onboarding

**2.1 Welcome Screen UI**
- Create `lib/features/onboarding/presentation/welcome_screen.dart`
- Design retro-styled welcome screen with:
  - App logo/illustration (family tree icon)
  - App name "Tree Familia"
  - Description text explaining the app's purpose
  - "Get Started" button with warm, vintage styling
- Add subtle animations (fade-in, gentle transitions)

**2.2 Theme Implementation**
- Create `lib/core/theme/app_theme.dart` with:
  - Retro color palette (cream, warm brown, sage green, vintage gold)
  - Custom typography (serif for headings, sans-serif for body)
  - Card and button styles with vintage aesthetics
  - Apply theme to MaterialApp

**2.3 Navigation Setup**
- Implement routing system in `lib/core/router/app_router.dart`
- Set up initial route to WelcomeScreen
- Configure route transitions (slide/fade animations)

## Phase 3: Homepage - Tree Management

**3.1 Homepage UI**
- Create `lib/features/home/presentation/home_screen.dart`
- Design drawer navigation with:
  - Home
  - Settings (placeholder)
  - About (placeholder)
- Main content area with:
  - App bar with retro styling
  - "My Family Trees" header
  - List of existing trees (empty state initially)
  - Floating action button or prominent button for "Create New Tree"

**3.2 Empty State Design**
- Create beautiful empty state illustration
- Add helpful text: "No family trees yet. Create your first tree to start preserving your family history."
- Include "Create Tree" and "Import Tree" buttons

**3.3 Tree List Item Design**
- Create `lib/features/trees/presentation/widgets/tree_list_item.dart`
- Card-based design with retro styling
- Display: tree name, member count, last modified date
- Add tap to open, long-press for options (edit, delete, export)
- Subtle shadow and border radius for vintage feel

## Phase 4: Create Tree Flow

**4.1 Create Tree Screen UI**
- Create `lib/features/trees/presentation/create_tree_screen.dart`
- Form with:
  - Tree name input field
  - Optional description
  - "Create Tree" button
  - "Cancel" button
- Form validation (name required)
- Retro-styled form fields with warm borders

**4.2 Create Tree Logic**
- Implement tree creation in TreeRepository
- Connect UI to repository via Riverpod provider
- Handle success/error states with user-friendly messages
- Navigate to tree detail screen on success

**4.3 Tree Detail Screen (Initial)**
- Create `lib/features/trees/presentation/tree_detail_screen.dart`
- Display tree name and description
- Show "Add Family Member" button
- Show empty state for members
- Back navigation to homepage

## Phase 5: Import Tree Flow (Placeholder)

**5.1 Import Tree Screen UI**
- Create `lib/features/trees/presentation/import_tree_screen.dart`
- File picker UI (using file_picker package)
- Display selected file name
- "Import" and "Cancel" buttons
- Show progress indicator during import

**5.2 Import Logic (Basic)**
- Set up file picker integration
- Create basic import handler (JSON parsing placeholder)
- Validate file structure
- Create new tree from imported data
- Handle errors gracefully

## Phase 6: Polish & Refinement

**6.1 UI Polish**
- Add loading states to all screens
- Implement error handling with user-friendly messages
- Add consistent animations and transitions
- Ensure retro aesthetic is cohesive across all screens

**6.2 Testing**
- Test navigation flow from landing → home → create → detail
- Test empty states
- Test form validation
- Test error scenarios

**6.3 Code Quality**
- Add proper documentation comments
- Ensure consistent code style
- Run flutter analyze and fix issues

## Future Phases (Not in Initial Scope)

- Family member CRUD operations
- Photo upload/management
- Relationship management
- Interactive tree visualization
- Export functionality
- Advanced import with merge options
- Search and filtering
- Settings and preferences

## Technology Stack

- **Framework**: Flutter 3.12+
- **State Management**: Riverpod 3.3+
- **Database**: Drift 2.34+ (SQLite)
- **File Storage**: path_provider 2.1+
- **Date Formatting**: intl 0.20+
- **File Picker**: file_picker (to be added)
- **Image Handling**: image_picker (to be added)

## Design Principles

- **Retro/Historic Aesthetic**: Warm colors (cream, brown, sage), serif typography, vintage card designs
- **Offline First**: All data stored locally, no network dependencies
- **Simplicity**: Intuitive UI for all age groups
- **Data Ownership**: User-controlled local storage
