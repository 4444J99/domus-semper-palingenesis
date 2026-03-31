# Memory - a-i--skills repo

## LFS Configuration
- Global git attributes at `~/.config/git/attributes` enables LFS for binary types (fonts, archives, images, etc.)
- This repo has a `.gitattributes` that disables LFS with `-filter -diff -merge binary` for all binary types
- The `.build/` directory contains copies of source binaries; LFS interception there was causing push failures
- If LFS push fails due to budget: the fix is to ensure no commit in the push range contains LFS pointers. Squashing commits that contain LFS pointers with ones that replace them with real content eliminates the LFS upload requirement.

## Build System
- `python3 scripts/refresh_skill_collections.py` regenerates `.build/` (collections, bundles, registry, lockfile, direct links)
- Validate with: `python3 scripts/validate_skills.py --collection example --unique` and `python3 scripts/validate_generated_dirs.py`
- 101 example skills + 4 document skills
