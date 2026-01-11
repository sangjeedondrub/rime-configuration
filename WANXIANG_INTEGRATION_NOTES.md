# Wanxiang Integration - Status and Lessons Learned

## ⚠️ Current Status: NOT INTEGRATED

After extensive debugging on 2026-01-11, we discovered that Wanxiang integration has critical stability issues.

## Current Working Configuration

**Base**: rime-ice with original settings (clean backup from 2026-01-11 04:22)

**What's Active**:
- ✅ Wanxiang LM (wanxiang-lts-zh-hans.gram) - provides smart contextual ranking
- ✅ All original rime-ice features
- ✅ Single character input works perfectly (ni → 你 尼 呢 泥 逆 拟)

**What's NOT Active**:
- ❌ Wanxiang dictionaries (88MB) - causes instability
- ❌ Wanxiang Lua modules - breaks script_translator

## What We Learned

### The "Single Character Problem" Didn't Exist
- **Original complaint**: "Can't type single characters, only seeing multi-char words"
- **Reality**: Clean configuration works perfectly
- **Actual issue**: Broken Wanxiang integration was causing the problem

### What Breaks the Input Method

1. **Modifying `speller/algebra`**: Completely replacing algebra rules breaks pinyin matching
2. **Disabling translator settings**: `enable_sentence: false` or `enable_completion: false` blocks output
3. **Wanxiang Lua modules**: When combined, they break `script_translator` completely
4. **Copying broken Lua files**: Modules from broken states cause cascading failures

### Critical Discovery: script_translator Breakage

When Wanxiang components were integrated, `script_translator` (core pinyin engine) stopped working:
- Symptom: Zero candidates for ANY input (ni, ren, wo, etc.)
- Only custom_phrase entries appeared
- Root cause: Unknown interaction between Wanxiang Lua modules and rime-ice core

## Recommendations

### DO NOT Attempt Wanxiang Integration Unless:
1. You have recent backups
2. You're working on a feature branch
3. You can afford several hours of debugging
4. You're willing to potentially lose all configuration

### If You Must Try:
1. Add ONLY dictionaries first, test for days
2. Add Lua modules ONE at a time
3. Test each change for 24 hours before proceeding
4. Never modify core translator or speller settings

### For Single Character Input:
The default rime-ice configuration already handles this perfectly. No changes needed.

## Files

**Working backup**: `~/Library/rime-backup-20260111-042223.tar.gz`
**Broken state**: `~/Library/Rime-Sangjee-broken-20260111-182857/` (for forensics)
**Experimental branch**: `feature/single-char-priority` (broken, do not merge)

## Conclusion

Stay with clean rime-ice + Wanxiang LM only. Basic input reliability is more important than additional dictionaries.

---
**Date**: 2026-01-11
**Status**: Clean configuration restored ✅
**Wanxiang Dictionaries**: Not recommended ⚠️
