---
Task ID: 1
Agent: Main Agent
Task: Fix all OTP/verification bugs in Dakkho platform

Work Log:
- Read backend code: student-api.ts, student-auth.ts, schema.sql
- Read frontend code: EmailVerificationPage.tsx, OTPInput.tsx, api-client.ts, store.ts, constants.ts
- Identified root cause of "Invalid or expired code" error: deployed dist code still uses `expires_at > datetime("now")` SQL filter which compares ISO 8601 format with SQLite datetime format unreliably
- Source code already had the fix (JS-based expiry check) but was never rebuilt/deployed
- Deployed resend-otp used 5-minute expiry for email verification; source code updated to 10 minutes but not deployed
- Fixed frontend EmailVerificationPage.tsx: countdown persistence using useEffect instead of useState initializer (fixes SSR hydration issue where localStorage is unavailable)
- Fixed frontend: added isResending ref to prevent double-clicking resend button
- Fixed frontend: changed "New code sent" notification from pointer-events-none CSS class to inline style (more reliable), added role="status" and aria-live="polite"
- Rebuilt and deployed worker to Cloudflare (dakkho-admin-api.dakkho-admin.workers.dev)
- Built and deployed student app to Cloudflare Pages (dakkho-student.pages.dev)

Stage Summary:
- Worker deployed with all OTP fixes: JS-based expiry validation, 10-minute OTP expiration for email verification, rate limiting, improved resend logic
- Student app deployed with frontend fixes: countdown persists across page refresh, "New code sent" notification is purely informational, resend button has double-click protection
- Key fix: The deployed worker code was outdated (dist/ was stale), source code had all fixes but wasn't deployed
