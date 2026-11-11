#!/bin/zsh
# Rebuild every WorldFirst Business case preview (taxonomy re-tag, 11 Nov 2026).
B=~/.claude/skills/wf_business_story/system/build.py
cd ~/Downloads/wf-business-stories
for d in */; do
  s=${d%/}
  [[ $s == _* || $s == *-old ]] && continue
  [[ -f $s/case.json ]] || continue
  out=$(/opt/homebrew/bin/python3.14 $B $s 2>&1 | grep -E "^(PASS|FAIL|BUILD|  ERROR|  - )" | head -8)
  echo "== $s"; echo "$out"
done > _shared/rebuild_all.log 2>&1
echo DONE
