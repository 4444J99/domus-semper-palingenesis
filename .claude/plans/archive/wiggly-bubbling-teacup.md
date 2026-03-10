# Enable Login Mode for Stirling-PDF Admin Settings

## Issue
Desktop app is connected but shows "Login Mode Required" when accessing System Settings. Initial login credentials are not working because Stirling-PDF auto-restores from database backups on startup.

## Root Cause
Stirling-PDF has a database backup at `configs/backup/db/backup_202602051430.sql` that gets auto-restored on startup, overwriting any fresh database with old credentials.

## Solution
Delete both the database AND the backup, then restart the container.

## Steps

### 1. Stop the container
```bash
docker stop stirling-pdf
```

### 2. Delete database AND backup
```bash
rm "/Users/4jp/Library/Application Support/Stirling-PDF/configs/stirling-pdf-DB-2.3.232.mv.db" 2>/dev/null
rm -rf "/Users/4jp/Library/Application Support/Stirling-PDF/configs/backup/db/"
```

### 3. Start the container
```bash
docker start stirling-pdf
```

### 4. Login to desktop app
- Quit (Cmd+Q) and reopen
- Login: **admin** / **stirling123**

## Verification
- Check logs show no database import: `docker logs stirling-pdf 2>&1 | grep -i "database import"`
- Login should succeed with admin/stirling123
- System Settings should be editable
