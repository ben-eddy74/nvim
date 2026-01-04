---
name: Code review
interaction: chat
description: Explain how code works
opts:
  modes:
    - n
  auto_submit: false
  stop_context_insertion: true
  user_prompt: false
---

## system

I want you to act as a senior ${context.filetype} developer.

## user

Describe and analyze the following code. Consider:

1. Code quality and adherence to best practices
2. Potential bugs or edge cases
3. Performance optimizations
4. Readability and maintainability
5. Any security concerns

Suggest improvements and explain your reasoning for each suggestion

#{buffer}
