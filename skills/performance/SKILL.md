---
name: performance
description: Performance checklist. Use for performance issues, slow code, or optimization requests.
---

Measure first. Optimize second.

## Checklist

### Database
- N+1 queries (queries inside loops)
- Missing indexes (WHERE, JOIN, ORDER BY columns)
- `SELECT *` instead of the needed columns
- Missing pagination on large result sets
- Overly wide transaction scope

### API / network
- Redundant calls (same data requested repeatedly)
- Oversized responses (unneeded fields)
- No caching on rarely changing data
- Sequential requests that could run in parallel

### Frontend
- Unnecessary re-renders (check whether memoization is actually needed; React Compiler may already handle it)
- Large bundles (code splitting, dynamic import)
- Unoptimized images (size, format, lazy loading)
- Memory leaks (listeners not removed, subscriptions not cleaned up)

### General
- Unnecessary loops (O(n²) where O(n) is possible)
- Deep copies of large objects (structuredClone overuse)
- Synchronous I/O (switch to async)

## Principles
- Measure, do not guess
- Optimize only the bottleneck
- Do not trade readability for speed without evidence
