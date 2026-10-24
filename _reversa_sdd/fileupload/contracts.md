# File Upload Contract

- 🟢 NanoHttpdContext exposes UTF-8, content-type, content-length, and session input stream.
- 🟢 content-length parse failure returns -1.
- 🟢 Multipart detection is POST-only.
- 🟢 parseRequest returns FileItem list; parseParameterMap groups items; getItemIterator streams items.
- 🟢 FileItemFactory is supplied by the caller.
- 🔴 Size, storage, and cleanup policy are not set by NanoFileUpload.
- 🔴 The session stream is consumed; replay/rewind is not provided.

