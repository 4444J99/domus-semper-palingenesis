# Migration and System Reset Plan

## Objective
Migrate all local data to the external drive `/Volumes/4444-iivii`, organize it systematically, and perform a clean install of macOS to eliminate system instability.

## 1. Inventory & Assessment
**Source Data (Estimated ~300GB - 400GB):**
- **User Home:** `/Users/4jp/`
  - `Workspace/` (Dev projects, git repos)
  - `Documents/`
  - `Desktop/`
  - `LocalArchive/` (The 91GB archive moved from iCloud)
  - `Downloads/`
  - `Pictures/`, `Music/`, `Movies/`
  - **Hidden Configs:** `.ssh/`, `.aws/`, `.config/`, `.zshrc` (Critical for dev environment restoration)

**Destination:**
- **Drive:** `/Volumes/4444-iivii`
- **Available Space:** ~1.4 TB (Sufficient)

## 2. Organization Strategy (On External Drive)
Instead of a raw dump, we will structure the data on the external drive to make the fresh start easier.

**Proposed Directory Structure:**
```text
/Volumes/4444-iivii/
└── System_Snapshots/
    └── MacBook_Pro_2026_Feb_19/
        ├── Home_Root/          (Full rsync of ~/)
        ├── Manual_Archives/    (The 91GB iCloud dump)
        └── Critical_Keys/      (Separate encrypted zip of .ssh, .aws, .kube)
```

## 3. Migration Process (The "RSYNC" Protocol)
We will use `rsync` for verification and resumability.

**Phase A: The Dry Run**
Verify what will be copied without moving data.

**Phase B: Critical Configs First**
Manually copy `.ssh`, `.aws`, `.config`, and keyfiles to a secure folder to ensure no permissions issues lock us out later.

**Phase C: The Big Move**
Execute `rsync` excluding system junk (`Library/Caches`, `.Trash`, `node_modules` if desired).

**Command Template:**
```bash
rsync -avP 
  --exclude '.Trash' 
  --exclude 'Library/Caches' 
  --exclude 'Library/Containers' 
  --exclude 'node_modules' 
  /Users/4jp/ /Volumes/4444-iivii/System_Snapshots/MacBook_Pro_2026_Feb_19/Home_Root/
```

## 4. Verification
1. Compare sizes (`du -sh source destination`).
2. Spot check critical files (Repositories, Keys).

## 5. The "Nuke & Pave" (Reboot)
**Steps:**
1. Sign out of iCloud (System Settings).
2. Deauthorize Computer (Music/TV apps).
3. Restart into **Recovery Mode** (Hold Power Button on Apple Silicon).
4. **Disk Utility:** Select "Macintosh HD" -> Erase Volume Group.
5. **Reinstall macOS:** Install the latest available stable release (avoid Beta unless necessary).

## 6. Restoration
1. Create new user `4jp`.
2. Install basic tools (`brew`, `git`, `cursor`).
3. Selectively drag files back from `4444-iivii` as needed (Don't use Migration Assistant to keep "cruft" away).
