#import "@preview/ezexam:0.3.1": *
#import "@preview/zebraw:0.6.1": *
// #import "@preview/subpar:0.2.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
// #import "@preview/pinit:0.2.2": *

#set page(height: auto)
#set par(justify: true)
#set smartquote(quotes: "\"\"")
#show: zebraw.with(lang: false)
#show: setup.with(
    mode: EXAM,
    resume: false,
    ref-color: black,
    // list-spacing: 1.5em,
    enum-spacing: 1.5em,
    // line-height: 1em,
)
#show link: it => text(fill: blue.darken(20%))[#underline(it)]
#show strong: it => text(weight: "bold", it)
#set enum(numbering: n => emph(strong(numbering("a.", n))))
// #let question = question.with(supplement: "Q ", ref-on: true)

#title[
    山东大学计算机科学与技术学院 \
    24 数据、智能数据库系统课后作业
]
#notice(
    [出于方便使用#link("https://github.com/gbchu/ezexam", "gbchu/ezexam:0.3.1")作模板.],
    [源码:#link("https://github.com/arshtyi/SDU-Database-System").],
    [课程主要参考的是#link("https://www.db-book.com/", "The book"). 此书题解容易找到,仅记录题目.],
)

= No.1
#question[
    (_3.4_) Consider the insurance database of Figure 3.17, where the primary keys are underlined. Construct the following SQL queries for this relational database.
    + Find the total number of people who owned cars that were involved in accidents in 2017.
    + Delete all year-2010 cars belonging to the person whose ID is '12345'.
]

#question[
    (_3.8_) Consider the bank database of Figure 3.18, where the primary keys are underlined. Construct the following SQL queries for this relational database.
    + Find the ID of each customer of the bank who has an account but not a loan.
    + Find the ID of each customer who lives on the same street and in the same city as customer '12345'.
    + Find the name of each branch that has at least one customer who has an account in the bank and who lives in "Harrison".
]

#question[
    (_3.9_) Consider the relational database of Figure 3.19, where the primary keys are underlined. Give an expression in SQL for each of the following queries.
    + Find the ID, name, and city of residence of each employee who works for "First Bank Corporation".
    + Find the ID, name, and city of residence of each employee who works for "First Bank Corporation" and earns more than \$10000.
    + Find the ID of each employee who does not work for "First Bank Corporation".
    + Find the ID of each employee who earns more than every employee of "Small Bank Corporation".
    + Assume that companies may be located in several cities. Find the name of each company that is located in every city in which "Small Bank Corporation" is located.
    + Find the name of the company that has the most employees (or companies, in the case where there is a tie for the most).
    + Find the name of each company whose employees earn a higher salary, on average, than the average salary at "First Bank Corporation".
]

#question[
    (_3.15_) Consider the bank database of Figure 3.18, where the primary keys are underlined. Construct the following SQL queries for this relational database.
    + Find each customer who has an account at _every_ branch located in "Brooklyn".
    + Find the total sum of all loan amounts in the bank.
    + Find the names of all branches that have assets greater than those of at least one branch located in "Brooklyn"
]

#question[
    (_3.16_) Consider the employee database of Figure 3.19, where the primary keys are underlined. Given an expression in SQL for each of the following queries.
    + Find ID and name of each employee who lives in the same city as the location of the company for which the employee works.
    + Find ID and name of each employee who lives in the same city and on the same street as does her or his manager.
    + Find ID and name of each employee who earns more than the average salary of all employees of her or his company.
    + Find the company that has the smallest payroll.
]

#question[
    (_3.17_) Consider the employee database of Figure 3.19. Give an expression in SQL for each of the following queries.
    + Give all employees for "First Bank Corporation" a 10 percent raise.
    + Give all managers of "First Bank Corporation" a 10 percent raise.
    + Delete all tuples in the _works_ relation for employees of "Small Bank Corporation".
]

#question[
    (_3.21_) Consider the library database of Figure 3.20. Write the following queries in SQL.
    + Find the member number and name of each member who has borrowed at least one book published by "McGraw-Hill".
    + Find the member number and name of each member who has borrowed every book published by "McGraw-Hill".
    + For each publisher, find the member number and name of each member who has borrowed more than five books of that publisher.
    + Find the average number of books borrowed per member. Take into account that if a member does not borrow any books, then that member does not appear in the _borrowed_ relation at all, but that member still counts in the average.
]

#question[
    (_4.1_) Consider the following SQL query that seeks to find a list of titles of all courses taught in Spring 2017 along with the name of the instructor.
    ```sql
    SELECT name, title
    FROM instructor NATURAL JOIN teaches NATURAL JOIN section NATURAL JOIN course
    WHERE semester = 'Spring' AND year = 2017;
    ```
    What is wrong with this query?
]

#question[
    (_4.2_) Write the following queries in SQL:
    + Display a list of all instructors, showing each instructor's ID and the number of sections taught. Make sure to show the number of sections as 0 for instuctors who have not taught any section. Your query should use an outer join, and should not use subqueries.
    + Write the same query as in part a, but using a scalar subquery and not using outer join.
    + Display the list of all course sections offered in Spring 2018, along with the ID and name of each instructor teaching the section. If a section has more than one instructor, that section should appear as many times in the result as it has instructors. If a section does not have any instructor, it should still appear in the result with the instructor name set to "-".
    + Display the list of all departments, with the total number of instructors, in each department, without using subqueries. Make sure to show departments that have no instructors, and list those departments with an instructor count of zero.
]

#question[
    (_4.7_) Consider the employee database of Figure 4.12. Give an SQL DDL definition of this database. Identify referential-integrity constraints that should hold, and include them in the DDL definition.
]

#question[
    (_6.2_)  Consider a database that includes the entity sets _student_, _course_, and _section_ from the university schema and that additionally records the marks that students receive in different exams of different sections.
    + Construct an E-R diagram that models exams as entities and uses a ternary relationship as part of the design.
    + Construct an alternative E-R diagram that uses only a binary relationship between _student_ and _section_. Make sure that only one relationship exists between a particular _student_ and _section_ pair, yet you can represent the marks that a student gets in different exams.
]

#question[
    (_6.3_) Design an E-R diagram for keeping track of the scoring statistics of your favorite sports team. You should store *the matches played*, *the scores in each match*, *the players in each match*, and *individual player scoring statistics for each match*. Summary statistics should be modeled as derived attributes with an explanation as to how they are computed.
]

#question[
    (_6.5_) An R diagram can be viewed as a graph. What do the following mean in termsof the structure of an enterprise schema?
    + The graph is disconnected.
    + The graph has a cycle.
]

#question[
    (_6.9_) Suppose the _advisor_ relationship set were one-to-one. What extra constraints are required on the relation _advisor_ to ensure that the one-to-one cardinality constraint is enforced?
]

#question[
    (_6.11_)In SQL, foreign key constraints can reference only the primary key attributes of the referenced relation or other attributes declared to be a superkey using the *unique* constraint. As a result, total participation constraints on a many-to-many relationship set (or on the "one" side of a one-to-many relationship set) cannot be enforced on the relations created from the relationship set, using primary key, foreign key, and not null constraints on the relations.
    + Explain why.
    + Explain how to enforce total participation constaints using complex check constraints or assertions (see Section 4.4.8). (Unfortunately, these features are not supported on any widely used database currently.)
]

#question[
    (_6.12_) Consider the following lattice structure of generalization and specialization (attributes are not shown). For entity sets $A$, $B$, and $C$, explain how attributes are inherited from the higher level entity sets $X$ and $Y$. Discuss how to handle a case where an attribute of $X$ has the same name as some attribute of $Y$.

    #diagram(
        node-stroke: luma(80%),
        node((1, 0), [$X$]),
        node((3, 0), [$Y$]),
        node((0, 2), [$A$]),
        node((2, 2), [$B$]),
        node((4, 2), [$C$]),
        edge((0, 2), (1, 0), "-|>"),
        edge((2, 2), (1, 0), "-|>"),
        edge((2, 2), (3, 0), "-|>"),
        edge((4, 2), (3, 0), "-|>"),
    )
]

#question[
    (_6.13_) An E-R diagram usually models the state of an enterprise at a point in time. Suppose we wish to track _temporal changes_, that is, changes to data over time. For example, Zhang may have been a student between September 2015 and May 2019, while Shankar may have had instructor Einstein as advisor from May 2018 to December 2018, and again from June 2019 to January 2020. Similary, attribute values of an entity or relationship, such as _title_ and _credits_ of _course_, _salary_, or even _name_ of _instructor_, and _tot_cred_ of _student_, can change over time.

    One way to model temporal changes is as follows: We define a new data type called *valid_time*, which is a time interval, or a set of time intervals. We then associate a _valid_time_ attribute with each entity and relationship, recording the time periods during which the entity or relationship is valid. The end time of an interval can be infinity; for example, if Shankar became a student in September 2018, and is still a student, we can represent the end time of the _valid_time_ interval as infinity for the Shankar entity. Similarly, we model attributes that can change over time as a set of values, each with its own _valid_time_.
    + Draw an E-R diagram with the _student_ and _instructor_ entities, and the _advisor_ relationship, with the above extensions to track temporal changes.
    + Convert the E-R diagram discussed above into a set of relations.
    It should be clear that the set of relations generated is rather complex, leading to difficulties in tasks such as writing queries in SQL. An alternative approach, which is used more widely, is to ignore temporal changes when designing the E-R model (in particular, temporal changes to attribute values), and to modify the relations generated from the E-R Model to track temporal changes.
]
= No.2
#question[
    (_10.1_) Suppose you need to store a very large number of small files, each of size say 2 kilobytes. If your choice is between a distributed file system and distributed key-value store, which would your prefer and explain why.
]

#question[
    (_10.2_) Suppose you need to store data for a very large number of students in a distributed document store such as MongoDB. Suppose also that the data for each student correspond to the data in the _student_ and the _takes_ relations. How would you represent the above data about students, ensuring that all the data for a particular student can be accessed efficiently? Give an example of the data representation for one student.
]

#question[
    (_10.4_) Give pseudocode for computing a join $r join_(r.A = s.A) s$ using a single MapReduce step, assuming that the *map()* function is invoked on each tuple of $r$ and $s$. Assume that the *map()* function can find the name of the relation using *context.relname()*.
]

#question[
    (_10.5_) What is the conceptual problem with the following snippet of Apache Spark code meant to work on very large data. Note that the *collect()* function returns a Java collection, and Java collections (from Java 8 onwards) support map and reduce functions.
    ```java
    JavaRDD<String> lines = sc.textFile('logDirectory');
    int totalLength = lines.collect().map(s -> s.length())
                                     .reduce(0, (a,b) -> a + b);
    ```
]

#question[
    (_10.6_) Apache Spark:
    + How does Apache Spark perform computations in parallel?
    + Explain the statement: "Apache Spark performs transformations on RDDs in a lazy manner."
    + What are some of the benefits of lazy evaluation of operations in Apache Spark?
]

#question[
    (_10.10_) Give four ways in which information in web logs pertaining to the web pages visited by a user can be used by the web site.
]

#question[
    (_10.14_) ill in the blanks below to complete the following Apache Spark program which computes the number of occurrences of each word in a file. For simplicity we assume that words only occur in lowercase, and there are no punctuations marks.
    ```java
    JavaRDD<String> textFile = sc.textFile("hdfs://...");
    JavaPairRDD<String, Integer> counts = textFile.____(s->Arrays.asList(s.split(" "))._____()).mapToPair(word -> new _______).reduceByKey((a,b) -> a + b);
    ```
]

#question[
    (_10.15_) Suppose a stream can deliver tuples out of order with respect to tuple timestamps. What extra information should the stream provide, so a stream query processing system can decide when all tuples in a window have been seen?
]

#question[
    (_10.16_) Explain how multiple operations can be executed on a stream using a publish-subscribe system such as Apache Kafka.
]
