# Legacy Mapping: fileupload

| Concern | Legacy file | Evidence |
|---|---|---|
| Session-to-UploadContext adaptation | `fileupload/src/main/java/org/nanohttpd/fileupload/NanoFileUpload.java` | `NanoHttpdContext` L56-100 |
| Commons FileUpload facade | `NanoFileUpload.java` | `isMultipartContent`, `parseRequest`, `parseParameterMap`, `getItemIterator` L101-EOF |
| Integration tests | `fileupload/src/test/java/org/nanohttpd/junit/fileupload/TestNanoFileUpLoad.java` | Test class and Commons FileUpload dependency |
