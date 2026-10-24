# Review Gaps: nanohttpd

> Unanswered policy decisions remain 🔴 GAP. The source-level behavior is documented separately with confirmed evidence.

## Core

- 🔴 Request, header, and body size limits are not a unified contract. See [Question 1](questions.md#question-1).
- 🔴 Malformed percent-encoding behavior is unspecified. See [Question 2](questions.md#question-2).
- 🔴 Temporary-file permissions, location, and interrupted-request cleanup expectations are unspecified. See [Question 3](questions.md#question-3).

## WebSocket

- 🔴 Maximum frame/message size and masking expectations are unspecified. See [Questions 4](questions.md#question-4) and [5](questions.md#question-5).
- 🔴 Callback exception/connection closure policy is not fully specified. See [Question 5](questions.md#question-5).

## Webserver

- 🔴 Canonical path/symlink containment policy is unspecified. See [Question 6](questions.md#question-6).
- 🔴 Directory-listing HTML escaping, default listing policy, and CORS configuration expectations need maintainer validation. See [Question 7](questions.md#question-7).

## Nanolets

- 🔴 Handler lifecycle, route precedence, and unsupported-method behavior need compatibility confirmation. See [Question 8](questions.md#question-8).

## File upload

- 🔴 FileItemFactory, upload cap, storage, cleanup, and repeated stream-read expectations are host-configured or unspecified. See [Question 9](questions.md#question-9).

## Markdown plugin and samples

- 🔴 Markdown input encoding and generated HTML sanitization policy are unspecified. See [Question 10](questions.md#question-10).
- 🔴 Sample HTML escaping expectations are unspecified. See [Question 11](questions.md#question-11).

## Relocation and operations

- 🔴 Relocation support duration is unspecified. See [Question 12](questions.md#question-12).
- 🔴 Deployment hardening and recommended authentication guidance are not represented in this repository snapshot. See [Question 13](questions.md#question-13).
