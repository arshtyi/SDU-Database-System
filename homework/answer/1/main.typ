#import "@preview/tyniverse:0.2.3": homework
#import "@preview/zebraw:0.6.1": *
// #import "@preview/subpar:0.2.2"
// #import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
// #import "@preview/pinit:0.2.2": *

#set page("a4")
#show: homework.template.with(
    course: "数据库系统",
    number: 1,
    student-infos: ((name: "彭靖轩", id: "202400130242"),),
)
#set enum(numbering: n => emph(strong(numbering("a.", n))))
#show: zebraw.with(lang: false)

#homework.simple-question[
    _3.4_
]
1. ```sql
    SELECT COUNT(DISTINCT person.driver_id)
    FROM accident, participated, person, owns
    WHERE accident.report_number = participated.report_number
          AND owns.driver_id = person.driver_id
          AND owns.license_plate = participated.license_plate
          AND year = 2017
    ```
2. ```sql
    DELETE FROM car
    WHERE year = 2010 AND license_plate IN
        (SELECT license_plate FROM owns WHERE driver_id = '12345')
    ```
#homework.simple-question[
    _3.8_
]
1. ```sql
    (SELECT ID FROM depositor)
    EXCEPT
    (SELECT ID FROM borrower)
    ```
2. ```sql
    SELECT F.ID
    FROM customer AS F, customer AS S
    WHERE F.customer_street = S.customer_street
        AND F.customer_city = S.customer_city
        AND S.customer_id = '12345';
    ```
3. ```sql
    SELECT DISTINCT branch_name
    FROM account, depositor, customer
    WHERE customer.id = depositor.id
        AND depositor.account_number = account.account_number
        AND customer_city = 'Harrison'
    ```

#homework.simple-question[
    _3.9_
]
1. ```sql
    SELECT e.ID, e.person_name, city
    FROM employee AS e, works AS w
    WHERE w.company_name = 'First Bank Corporation' AND w.ID = e.ID
    ```
2. ```sql
    SELECT ID, name, city
    FROM employee
    WHERE ID IN (
        SELECT ID
        FROM works
        WHERE company_name = 'First Bank Corporation' AND salary > 10000
    )
    ```
3. ```sql
    SELECT ID
    FROM employee
    WHERE ID NOT IN (
        SELECT ID
        FROM works
        WHERE company_name = 'First Bank Corporation'
    )
    ```
4. ```sql
    SELECT ID
    FROM works
    WHERE salary > ALL (
        SELECT salary
        FROM works
        WHERE company_name = 'Small Bank Corporation'
    )
    ```
5. ```sql
    SELECT S.company_name
    FROM company AS S
    WHERE NOT EXISTS (
        (
            SELECT city
            FROM company
            WHERE company_name = 'Small Bank Corporation'
        )
        EXCEPT
        (
            SELECT city
            FROM company AS T
            WHERE T.company_name = S.company_name
        )
    )
    ```
6. ```sql
    SELECT company_name
    FROM works
    GROUP BY company_name
    HAVING COUNT(DISTINCT ID) >= ALL (
        SELECT COUNT(DISTINCT ID)
        FROM works
        GROUP BY company_name
    )
    ```
7. ```sql
    SELECT company_name
    FROM works
    GROUP BY company_name
    HAVING AVG(salary) >  (
        SELECT AVG(salary)
        FROM works
        WHERE company_name = 'First Bank Corporation'
    )
    ```

#homework.simple-question[
    _3.15_
]
1. ```sql
    WITH all_branches_in_brooklyn(branch_name) AS (
        SELECT branch_name
        FROM branch
        WHERE branch_city = 'Brooklyn'
    )
    SELECT ID, customer_name
    FROM customer AS c1
    WHERE NOT EXISTS (
        (SELECT branch_name FROM all_branches_in_brooklyn)
        EXCEPT
        (
            SELECT branch_name
            FROM account INNER JOIN depositor
                ON account.account_number = depositor.account_number
            WHERE depositor.ID = c1.ID
        )
    )
    ```
2. ```sql
    SELECT SUM(amount)
    FROM loan
    ```
3. ```sql
    SELECT branch_name
    FROM branch
    WHERE assets > SOME (
        SELECT assets
        FROM branch
        WHERE branch_city = 'Brooklyn'
    );
    ```

#homework.simple-question[
    _3.16_
]
1. ```sql
    SELECT employee.id, employee.person_name
    FROM employee INNER JOIN works ON employee.id = works.id
                  INNER JOIN company ON works.company_name = company.company_name
    WHERE employee.city = company.city
    ```
2. ```sql
    SELECT E.id, E.person_name
    FROM employee AS E INNER JOIN manages ON E.id = manages.id
                       INNER JOIN employee AS manager_of_E ON manages.manager_id = manager_of_E.id
    WHERE E.street = manager_of_E.street AND
          E.city = manager_of_E.city;
    ```
3. ```sql
    WITH average_salary_per_company(company_name, avg_salary) AS (
        SELECT company_name, AVG(salary)
        FROM works
        GROUP BY company_name
    )
    SELECT E.id, E.person_name
    FROM employee AS E INNER JOIN works ON E.id = works.id
    WHERE works.salary > (
        SELECT avg_salary
        FROM average_salary_per_company
        WHERE company_name = works.company_name
    )
    ```
4. ```sql
        SELECT company_name, SUM(salary) AS total_payroll
    FROM works
    GROUP BY company_name
    ORDER BY total_payroll ASC
    LIMIT 1
    ```

#homework.simple-question[
    _3.17_
]
1. ```sql
    UPDATE works
    SET salary = salary * 1.1
    WHERE company_name = 'First Bank Corporation'
    ```
2. ```sql
    UPDATE works
    SET salary = salary * 1.1
    WHERE company_name = 'First Bank Corporation' AND id IN (
        SELECT manager_id
        FROM manages
    )
    ```
3. ```sql
    DELETE FROM works
    WHERE company_name = 'Small Bank Corporation'
    ```

#homework.simple-question[
    _3.21_
]
1. ```sql
    SELECT memb_no, name
    FROM member AS m
    WHERE EXISTS (
        SELECT *
        FROM book INNER JOIN borrowed ON book.isbn = borrowed.isbn
        WHERE book.publisher = 'McGraw-Hill' AND
                borrowed.memb_no = m.memb_no
    )
    ```
2. ```sql
    SELECT memb_no, name
    FROM member AS m
    WHERE NOT EXISTS (
        (
            SELECT isbn
            FROM book
            WHERE publisher = 'McGraw-Hill'
        )
        EXCEPT
        (
            SELECT isbn
            FROM borrowed
            WHERE memb_no = m.memb_no
        )
    )
    ```
3. ```sql
    WITH member_borrowed_book(memb_no, memb_name,isbn,title,authors,publisher,date) AS (
        SELECT member.memb_no, name, book.isbn, title, authors, publisher, date
        FROM member INNER JOIN borrowed ON member.memb_no = borrowed.memb_no
                    INNER JOIN book ON borrowed.isbn = book.isbn
    )
    SELECT memb_no, memb_name, publisher, COUNT(isbn)
    FROM member_borrowed_book
    GROUP BY memb_no, memb_name, publisher
    HAVING COUNT(isbn) > 5;
    ```
4. ```sql
    WITH number_of_books_borrowed(memb_no, memb_name, number_of_books) AS (
        SELECT memb_no, name, (
            CASE
                WHEN NOT EXISTS (SELECT * FROM borrowed WHERE borrowed.memb_no = member.memb_no) THEN 0
                ELSE (SELECT COUNT(*) FROM borrowed WHERE borrowed.memb_no = member.memb_no)
            END
        )
        FROM member
    )
    SELECT AVG(number_of_books) AS average_number_of_books_borrowed_per_member
    FROM number_of_books_borrowed
    ```

#homework.simple-question[
    _4.1_
]
语法正确,但是因为`dept_name`是`course`和`instructor`两个表的属性,由于自然连接,只有当一个教师在其所属部分教授课程时才会有结果.

#homework.simple-question[
    _4.2_
]
1. ```sql
    SELECT ID, COUNT(sec_id) AS Number_of_sections
    FROM instructor NATURAL LEFT OUTER JOIN teaches
    GROUP BY ID
    ```
2. ```sql
    SELECT ID, (
        SELECT COUNT(*) AS Number_of_sections
        FROM teaches T
        WHERE T.id = I.id
    )
    FROM instructor I
    ```
3. ```sql
    SELECT course_id,sec_id,ID,decode(name,null,'-',name) as name
    FROM (section NATURAL LEFT OUTER JOIN teaches)
        NATURAL LEFT OUTER JOIN instructor
    WHERE semester = 'Spring' AND year = 2018;
    ```
4. ```sql
    SELECT dept_name, COUNT(id)
    FROM department NATURAL LEFT OUTER JOIN instructor
    GROUP BY dept_name;
    ```

#homework.simple-question[
    _4.7_
]
```sql
CREATE TABLE employee (
    id INTEGER,
    person_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE company (
    company_name VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY(company_name)
);

CREATE TABLE works (
    id INTEGER,
    company_name VARCHAR(50),
    salary numeric(10,2),
    PRIMARY KEY(id),
    FOREIGN KEY (id) REFERENCES employee(id),
    FOREIGN KEY (company_name) REFERENCES company(company_name)
);

CREATE TABLE manages (
    id INTEGER,
    manager_id INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES employee (id),
    FOREIGN KEY (manager_id) REFERENCES employee (id)
)
```

#homework.simple-question[
    _6.2_
]
1. $ product_("person_name")sum_("city"='"Miami"')"employee" $
2. $ product_("person_name")sum_("salary">100000)"employee" $
3. $ product_("person_name")sum_(("city"='"Miami"') inter ("salary">100000))"employee" $

#homework.simple-question[
    _6.3_
]
1. $ product_("branch_name")sum_("branch_city"='"Chicago"')"branch" $
2. $ product_("ID")sum_("loan.branch_name"='"Downtown"')"borrower"join_("borrower.loan_number=loan.loan_number")"loan" $

#homework.simple-question[
    _6.5_
]
设
$
    T= product_("ID,,course_id")"takes",C= product_("course_id")sum_("dept_name"='"Comp. Sci."')"course"
$
1. $ product_("ID")(T div C) $
2. 所有可能的学生$ A=product_("ID") T $找出缺课的学生$ M=A times C -T $则答案为$ A - product_("ID")M $

#homework.simple-question[
    _6.9_
]
设
- $"employee"(e):(e=("person_name","street","city"))$
- $"works"(w):(w=("person_name","company_name","salary"))$
- $"manages"(m):(m=("person_name","manager_name"))$
1. $
        {,e mid(|) "employee"(e) and exists m,("manages"(m) and "m.manager_name"\ ='"Jones"' and "m.person_name"="e.person_name"),}
    $
2. $
        {,<c>mid(|) exists e,exists m,("employee"(e) and "manages"(m) and "m.manager_name"\ ='"Jones"' and "m.person_name"="e.person_name" and c = "e.city"),}
    $
3. $
        {,<n>mid(|) exists m_1,exists m_2,("manages"(m_1)and "manages"(m_2)and "m_1.manager_name"\ ='"Jones"' and "m_2.person_name"="m_1.manager_name" and n = "m_2.manager_name"),}
    $
4. $
        {,e mid(|) "employee"(e)and exists w,("works"(w)and "w.person_name"="e.person_name" and \ forall e_2,forall w_2,(("employee"(e_2)and "works"(w_2)and e_2".city"='"Mumbai"'\ and w_2."person_name"="e_2"."person_name")arrow.r.double "w.salary" > "w_2.salary")),}
    $

#homework.simple-question[
    _6.11_
]
1. $ product_("loan_number")sum_("amount">10000)"loan" $
2. $ product_("ID")("depositor"join_("depositor.account_number=account.account_number")sum_("balance">6000)"account") $
3. $
        product_("ID")("depositor"join_("depositor.account_number=account.account_number")sum_(("balance">6000) inter ("branch_name"='"Uptown"'))"account")
    $

#homework.simple-question[
    _6.12_
]
1. $ product_("ID,name")sum_("dept_name"='"Physics"')"instructor" $
2. $
        product_("ID,name")("instructor"join_("instructor.dept_name=department.dept_name")sum_("building"='"Watson"')"department")
    $
3. $
        product_("ID,name")("student"join_("student.ID=takes.ID")"takes"join_("takes.course_id=course.course_id")sum_("dept_name"='"Comp. Sci."')"course")
    $
4. $ product_("ID,name")("student"join_("student.ID=takes.ID")sum_("year"=2018)"takes") $
5. $
        product_("ID,name")"student" - product_("ID,name")("student"join_("student.ID=takes.ID")sum_("year"=2018)"takes")
    $


#homework.simple-question[
    _6.13_
]
设
- $"employee"(e):(e=("person_name","street","city"))$
- $"works"(w):(w=("person_name","company_name","salary"))$
- $"company"(c):(c=("company_name","city"))$
- $"manages"(m):(m=("person_name","manager_name"))$
1. $
        {,<n>mid(|) exists w,("works"(w) and "w.company_name"='"FBC"' and n = "w.person_name"),}
    $
2. $
        {,<n,c>mid(|) exists e,exists w,("employee"(e) and "works"(w) and "w.company_name"='"FBC"' \ and "e.person_name"="w.person_name" and n = "e.person_name" and c = "e.city"),}
    $
3. $
        {,<n,s,c>mid(|) exists e,exists w,("employee"(e) and "works"(w) and "w.company_name"='"FBC"' \ and "w.salary">10000 and "e.person_name"="w.person_name" and n = "e.person_name" and s = "e.street" and c = "e.city"),}
    $
4. $
        {,e mid(|) "employee"(e) and exists w,exists c,("works"(w) and "company"(c) \ and "w.person_name"="e.person_name" and "c.company_name"="w.company_name" and "e.city"="c.city"),}
    $
5. $
        {,e mid(|) "employee"(e) and exists m,exists e_2,("manages"(m) and "employee"(e_2) \ and "m.person_name"="e.person_name" and "m.manager_name"="e_2.person_name" and "e.street"="e_2.street" and "e.city"="e_2.city"),}
    $
6. $
        {,e mid(|) "employee"(e) and not exists w,("works"(w) and "w.person_name"="e.person_name" and "w.company_name"='"FBC"'),}
    $
7. $
        {,e mid(|) "employee"(e) and exists w,("works"(w) and "w.person_name"="e.person_name" \ and forall w_2,(("works"(w_2) and "w_2.company_name"='"SBC"') arrow.r.double "w.salary" > "w_2.salary")),}
    $
8. $
        {,<"cn">mid(|) exists c_0,("company"(c_0) and "cn" = "c_0.company_name" and forall c_1,(("company"(c_1) \ and "c_1.company_name"='"SBC"') arrow.r.double exists c_2,("company"(c_2) and "c_2.company_name"="cn" and "c_2.city"="c_1.city"))),}
    $
