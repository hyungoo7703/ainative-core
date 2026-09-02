---
name: accessibility
description: Web accessibility (a11y) checklist. Use when writing HTML or UI components.
---

Accessibility is a baseline, not an option.

## Checklist

### Semantic HTML
- Use the right element (`button`, `nav`, `main`, `header`, ...)
- Do not overuse `div`; replace with meaningful elements
- Keep heading order (h1 → h2 → h3)

### Images and media
- Every `img` has a meaningful `alt`
- Decorative images use `alt=""`
- Videos have captions

### Forms
- Every input has an associated `label`
- Show errors both visually and programmatically
- Mark required fields (`aria-required`)

### Keyboard
- Every interactive element is reachable by keyboard
- Tab order is logical
- Focus is visible (never remove the outline)
- Modals and dropdowns trap focus

### Color and contrast
- Text contrast at least 4.5:1 (WCAG AA)
- Never convey information by color alone (add icons or text)

### ARIA
- Prefer native HTML; ARIA is unnecessary when native elements work
- Custom components get a proper `role` and `aria-label`
- Dynamic content changes use `aria-live`
