---
Task ID: 1
Agent: Main Agent
Task: Read and understand all 3 GitHub repos (dakkho-worker, dakkho-admin-web, dakkho-student-app) to identify previous mistakes and fix Course Page Chapters & Lessons

Work Log:
- Cloned all 3 repos: dakkho-worker, dakkho-admin-web, dakkho-student-app
- Read worker routes: lessons.ts, chapters.ts, videos.ts, courses.ts, index.ts
- Read worker schema.sql to understand DB structure
- Read admin panel course-curriculum.tsx (1501 lines) and api-client.ts
- Identified the root cause: frontend not sending subject_id for lessons, backend requiring it → 400 error
- Identified delete param mismatch: frontend sends chapterId/lessonId but backend expects id
- Identified videos.ts missing chapter_id/subject_id in allowedFields
- Previous mistakes: added columns wrong, rewrote UI instead of maintaining existing pattern, made subject_id optional instead of auto-deriving

Stage Summary:
- Root cause identified: subject_id not sent from frontend + required by backend = lessons can't be created
- Delete param mismatch between frontend and backend
- Videos route missing chapter_id/subject_id fields

---
Task ID: 2
Agent: Main Agent
Task: Fix Worker routes and Frontend, deploy everything

Work Log:
- Fixed lessons.ts: auto-derive subject_id from chapter, added video_url/thumbnail_url/document_url fields, accept both id and lessonId for delete
- Fixed chapters.ts: accept both id and chapterId for delete, made subject_id optional in INSERT (NULL allowed)
- Fixed videos.ts: added chapter_id/subject_id to allowedFields for both create and update, accept both id and videoId for delete
- Fixed course-curriculum.tsx: added videoUrl/thumbnailUrl/documentUrl to Lesson interface and lesson form, added "Media & Resources" section in lesson dialog, updated fetchAllData mapping, added video/document indicators in lesson rows, made chapter subject_id optional in handleSaveChapter
- D1 columns already existed from previous migration (video_url, thumbnail_url, document_url)
- Built admin panel with GitHub Pages config, pushed to dakkho-admin-web repo
- Deployed worker to Cloudflare (dakkho-admin-api.dakkho-admin.workers.dev)
- Pushed worker code to dakkho-worker repo
- Pushed student-app code to dakkho-student-app repo

Stage Summary:
- All 3 repos updated and pushed to GitHub
- Worker deployed to Cloudflare
- Admin panel built and deployed to GitHub Pages
- Key fixes: subject_id auto-derive, delete param compatibility, lesson media fields, videos route fields
