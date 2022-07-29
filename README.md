# City-Library-Database
A complete library database from scratch with ER diagram, Schema, mySQL code

- Reader's Functions
    - Add to Cart Functionality
    - Borrow (single documents/ multiple documents)
    - Reserve (single documents/ multiple documents)
    - Return (single documents/ multiple documents)
    - Search Documents by Document's name or by the Publisher's name
    - Automatic Fine setting (Default Due-date: 20 days from document borrow date for each borrowed document)
    - Automatic Deletion of Reserved Document (Default: by 6PM / at Library close time every day)
    - Max Limit for Borrowing documents (Default: 10 documents per reader)
    
- Admin's Functions
    - Add new Readers
    - Add new Documents / Copies
    - View all Library Branches (if any)
    
    - Miscellaneous:
      - Taking Library Branch number and get the most popular book at the moment
      - Taking Library Branch number and get the active reader for that libranch branch
      - Most popular books of a given year
      - Average Fine paid by the borrowers from in a given interval date
