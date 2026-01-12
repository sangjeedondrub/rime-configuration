# Wanxiang Integration

## Status: ✅ Working

## What's Integrated

- **Wanxiang LM** (language model): Smart contextual ranking
- **Wanxiang Supplement Dictionary**: Additional vocabulary with 〔万象〕 tag
- **Wanxiang Lua Modules**: auto_phrase, partial_commit, wanxiang_tagger

## Critical Configuration

### Single Character Support

```yaml
grammar:
  collocation_min_length: 1  # MUST be 1, not 3 (allows single hanzi)
```

### Disabled Module

```yaml
# NEVER enable - blocks single character input
# - lua_filter@*super_filter
```

## Download

Language model: https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram

Place in: `~/Library/Rime/`

## Key Lesson

The `super_filter` Lua module prevents single character candidates. Keep it disabled.
