---
Task ID: 1
Agent: Main Agent
Task: Fix Student App sync with Admin App, D1, KV - Theme, Notification Preferences, Privacy

Work Log:
- Read Student App core files (store.ts, api-client.ts, DakkhoApp, AppShell, all settings pages, notifications page)
- Read Worker API routes (student-api.ts, auth.ts, notifications.ts, onesignal.ts)
- Read D1 schema (schema.sql)
- Identified issues: Theme only supports light/dark (no system), not persisted to D1; notification preferences exist in D1 but push sending doesn't check them; privacy settings are local-only
- Added `user_preferences` table to D1 schema (theme_mode, accent_color, font_size, border_radius, compact_mode, privacy fields, content_protection, download prefs, language)
- Created `user_preferences` table in production D1 database
- Added GET/PUT `/api/student/preferences` routes to Worker (student-api.ts)
- Added `checkUserNotifPrefs()` function to onesignal.ts for per-user notification preference checking
- Updated Worker notifications route to check user preferences before sending push notifications
- Updated Student App theme store to support 'system' mode with localStorage persistence and D1 sync
- Added `userPreferencesApi` to Student App api-client.ts
- Updated ThemeSettingsPage to load from D1 on mount and save to D1 on change
- Updated PrivacySettingsPage to load from D1 on mount and save to D1 on change
- Updated SettingsPage to show correct theme mode label (Light/Dark/System)
- Deployed Worker to Cloudflare (v403db3b5)

Stage Summary:
- `user_preferences` table created in D1 with theme, privacy, appearance, download, and language fields
- Worker API deployed with GET/PUT /api/student/preferences endpoints
- Notification push sending now checks user's notification_preferences before sending
- Student App theme store now supports 'system' mode and persists to both localStorage and D1
- All settings pages (Theme, Privacy) now load from D1 on mount and save to D1 on change
- Worker deployed: https://dakkho-admin-api.dakkho-admin.workers.dev
