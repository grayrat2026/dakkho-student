---
Task ID: 1
Agent: Main Agent
Task: Fix Instructor Site issues - Live Page, Course Creation, Curriculum modals, CourseDetail, VideoManager, Profile

Work Log:
- Read full codebase: CourseLive, CourseNew, CourseCurriculum, Profile, VideoManager, CourseDetail, CourseSettings
- Fixed CourseLive.tsx: Added missing AnimatePresence import that caused the Schedule Class dialog to crash
- Fixed CourseNew.tsx: Removed double `/instructor` prefix in apiUpload call for thumbnail (was `/instructor/instructor/courses/...`)
- Fixed CourseSettings.tsx: Same double-prefix bug in thumbnail upload
- Rewrote CourseCurriculum.tsx: Replaced cramped inline popups with proper fullscreen modals (Modal component) for Add Subject, Add Chapter, Edit Chapter, Add Lesson
- Fixed CourseDetail.tsx: Added safe defaults for course data (tags can be string or array, isPublished can be number or boolean), added error boundary with user-friendly error display
- Fixed VideoManager.tsx: Improved dialog alignment (max-w-xl, consistent padding, better sticky header)
- Fixed CourseLive.tsx: Consistent modal styling across all dialogs
- Improved CourseNew.tsx: Better courseId extraction from API response with fallback navigation

Stage Summary:
- All major bugs fixed and deployed
- Course creation with thumbnail upload now works (was broken due to double API path prefix)
- Live page dialog now works (was missing AnimatePresence import)
- Curriculum page has proper modals instead of cramped inline forms
- CourseDetail page no longer crashes on course data with mixed types
- VideoManager popup properly aligned
- Pushed to GitHub: grayrat2026/dakkho-instructor
- Deployed to Cloudflare Pages: https://dakkho-instructor.pages.dev/
