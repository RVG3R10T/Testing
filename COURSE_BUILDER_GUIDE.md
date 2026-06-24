# Drag and Drop Course Builder Documentation

## Overview

The drag-and-drop course builder allows instructors to easily create and organize training courses with multiple content types (text, video, images, links).

## Features

### ✅ Core Features

1. **Drag and Drop Reordering**
   - Reorder course modules by dragging
   - Visual feedback during dragging
   - Automatic order index updates

2. **Multiple Content Types**
   - 📝 **Text**: Written lessons and instructions
   - 🎥 **Video**: Embedded video URLs (YouTube, Vimeo, etc.)
   - 🖼️ **Image**: Visual content and diagrams
   - 🔗 **Link**: External resources and references

3. **Module Management**
   - Add modules with the "Add Module" button
   - Edit existing modules
   - Delete modules with confirmation
   - Preview module content

4. **Course Details**
   - Course title and description
   - Automatic module counting
   - Content type diversity tracking
   - Estimated duration calculation

### 🎨 UI Components

#### `CourseBuilderScreen`
Main screen for creating/editing courses. Features:
- Course title and description input
- Reorderable module list
- Add/Edit/Delete module actions
- Course statistics dashboard
- Save course button

#### `ModuleEditorDialog`
Dialog for creating/editing modules:
- Title input with validation
- Content type selection (radio/chip buttons)
- Content input with context-aware hints
- Save/Cancel actions

#### `ModulePreviewCard`
Card displaying module information:
- Content type icon and color
- Module title and preview
- Edit and delete buttons
- Drag handle indicator
- Visual feedback for drag state

#### `ModulePreviewDialog`
Full module preview in dialog:
- Module title and content type
- Content display with formatting
- Close button

#### `ContentTypeGuide`
Info dialog explaining content types:
- Descriptions and use cases
- Example URLs and formats
- Visual icons for each type

### 📦 State Management

#### `CourseBuilderState`
Holds the complete course builder state:
```dart
class CourseBuilderState {
  final String? courseId;           // Existing course ID or null
  final String title;               // Course title
  final String description;         // Course description
  final int companyId;              // Company ID (default: 1)
  final List<ModuleItem> modules;   // List of modules
  final bool isLoading;             // Loading state
  final String? error;              // Error message
  final ModuleItem? selectedModule; // Currently selected module
}
```

#### `CourseBuilderNotifier`
Handles state mutations:
- `setTitle()`: Update course title
- `setDescription()`: Update course description
- `addModule()`: Add a new module
- `updateModule()`: Update an existing module
- `deleteModule()`: Remove a module
- `reorderModules()`: Drag and drop reordering
- `setSelectedModule()`: Select a module
- `setLoading()`: Set loading state
- `setError()`: Set error message
- `reset()`: Reset builder to initial state

#### Provider
```dart
final courseBuilderProvider = StateNotifierProvider.family<
  CourseBuilderNotifier,
  CourseBuilderState,
  String?  // courseId parameter
>
```

Usage:
```dart
// Get state
final courseBuilder = ref.watch(courseBuilderProvider(courseId));

// Get notifier
final notifier = ref.read(courseBuilderProvider(courseId).notifier);
```

### 📱 Module Item Model

```dart
class ModuleItem {
  final String? id;                    // Database ID
  final String title;                  // Module title
  final String content;                // Content (text, URL, etc.)
  final String contentType;            // text, video, image, or link
  int orderIndex;                      // Position in course
  final DateTime? createdAt;           // Creation timestamp
}
```

## Usage

### Creating a New Course

```dart
context.go('/course/create');
```

### Editing an Existing Course

```dart
context.go('/course/:courseId/edit');
```

### Programmatic Access

```dart
final notifier = ref.read(courseBuilderProvider(null).notifier);

// Add a module
notifier.addModule(
  ModuleItem(
    title: 'Introduction',
    content: 'Welcome to this course...',
    contentType: 'text',
    orderIndex: 0,
  ),
);

// Reorder modules (swap positions)
notifier.reorderModules(0, 2);

// Delete a module
notifier.deleteModule(1);
```

## Drag and Drop Implementation

The course builder uses Flutter's `ReorderableListView` for drag-and-drop functionality:

```dart
ReorderableListView(
  onReorder: (oldIndex, newIndex) {
    notifier.reorderModules(oldIndex, newIndex);
  },
  children: [
    // Module cards with ValueKey
  ],
)
```

### Key Points

1. **ValueKey Required**: Each child must have a unique ValueKey
2. **Automatic Reordering**: List automatically reorders UI
3. **State Synchronization**: Order indices updated automatically
4. **Visual Feedback**: Drag handle cursor and elevation changes

## Content Type Guidelines

### Text
- Regular lesson content
- Instructions and guidelines
- Longer-form educational material
- **Input**: Plain text (supports markdown in future)

### Video
- YouTube, Vimeo, or self-hosted videos
- Demonstrations and walkthroughs
- Expert interviews or presentations
- **Input**: Full video URL (embedded player)

### Image
- Diagrams and flowcharts
- Screenshots and visual guides
- Infographics
- **Input**: Image URL (loads in preview)

### Link
- External resources
- Reference materials
- Recommended reading
- **Input**: Full URL (clickable link)

## Validation Rules

1. **Title**: Required, non-empty
2. **Content**: Required, non-empty
3. **Content Type**: Must be one of: text, video, image, link
4. **Course Title**: Required, non-empty
5. **At least 1 module**: Required before saving

## Future Enhancements

- [ ] Markdown support for text content
- [ ] Image upload (instead of URL only)
- [ ] Video preview thumbnails
- [ ] Module duplication
- [ ] Module templates/presets
- [ ] Batch operations (delete multiple modules)
- [ ] Module visibility toggle (hide/show from students)
- [ ] Quiz/assessment modules
- [ ] Estimated time per module
- [ ] Module prerequisites

## API Integration

### Create Course

```bash
POST /api/v1/courses
Content-Type: application/json
Authorization: Bearer {token}

{
  "title": "Course Title",
  "description": "Course description",
  "company_id": 1,
  "thumbnail": "url-to-thumbnail"
}
```

### Add Module

```bash
POST /api/v1/courses/{courseId}/modules
Content-Type: application/json
Authorization: Bearer {token}

{
  "title": "Module Title",
  "content": "Content or URL",
  "content_type": "text|video|image|link",
  "order_index": 0
}
```

### Update Module

```bash
PUT /api/v1/courses/{courseId}/modules/{moduleId}
Content-Type: application/json
Authorization: Bearer {token}

{
  "title": "Updated Title",
  "content": "Updated content",
  "content_type": "text|video|image|link",
  "order_index": 0
}
```

### Delete Module

```bash
DELETE /api/v1/courses/{courseId}/modules/{moduleId}
Authorization: Bearer {token}
```

## Troubleshooting

### Drag and Drop Not Working
- Ensure ReorderableListView children have unique ValueKeys
- Check that modules list is not empty
- Verify no duplicate order indices

### Validation Not Triggering
- Check TextEditingController values
- Ensure contentType is set before validation
- Verify all required fields are being checked

### State Not Updating
- Ensure using Riverpod notifier for updates
- Check that ref.watch is observing correct provider
- Verify modules list is being copied (not mutated in place)

## Testing

```dart
// Test adding a module
test('add module', () {
  final notifier = CourseBuilderNotifier();
  final module = ModuleItem(
    title: 'Test',
    content: 'Content',
    contentType: 'text',
    orderIndex: 0,
  );
  notifier.addModule(module);
  expect(notifier.state.modules.length, 1);
});

// Test reordering
test('reorder modules', () {
  // Add modules and test reordering logic
});
```
