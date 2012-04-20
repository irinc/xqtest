xQuery Unit Testing
-------------------

Xqtest is a unit test runner for testing xQuery.  Write your code in xQuery.  Write your tests in xQuery.


Start
-----

- Clone the code
- Setup MarkLogic HTTP server for testing locally
  - Root: <xqtest-dir>/src
  - Authentication: application-level
  - Default user: admin
- Run the xqtest tests
  - HTML results: http://<your-server:port>/test/html.xqy
  - XML/TestNG results: http://<your-server:port>/test/testng.xqy