# Answer

内容由平台提供(bushi)

## Get

```sql
SELECT i, j, getanswer(i, j) AS answer
FROM (
    SELECT a.i, b.j
    FROM (SELECT LEVEL + 1 AS i FROM DUAL CONNECT BY LEVEL <= 5) a
    CROSS JOIN
         (SELECT LEVEL AS j FROM DUAL CONNECT BY LEVEL <= 10) b
    UNION ALL
    SELECT 7 AS i, LEVEL AS j
    FROM DUAL
    CONNECT BY LEVEL <= 3
)
ORDER BY i, j;
```

## Lab 2

### T 1

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE pname not like '高%'
  AND pname not like '韩%'
  AND (pname like '%建%'
       OR pname like '%平%')
  AND birthdate > = TO_DATE ('19710101',
                             'yyyymmdd')
  AND birthdate < = TO_DATE ('19711231',
                             'yyyymmdd')
```

### T 2

```sql
SELECT t1.pid,
       pname,
       did,
       t2.bid,
       bname,
       amount,
       dtime,
       city
FROM bk.deptor t1,
     bk.deposit t2,
     bk.bank t3
WHERE t1.pid = t2.pid
  AND t2.bid = t3.bid
  AND t1.pname = '李龙'
  AND amount > 1000
  AND city = '北京'
```

### T 3

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE NOT EXISTS
    (SELECT pid
     FROM bk.deposit
     WHERE t1.pid = pid)
```

### T 4

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE pid IN
    (SELECT pid
     FROM bk.deposit t2
     WHERE EXISTS
         (SELECT bid
          FROM bk.deposit t3
          WHERE pid = '410101197304071326'
            AND t2.bid = t3.bid
            AND TRUNC (t2.dtime,
                       'dd') = TRUNC (t3.dtime,
                                      'dd')))
  AND pid < > '410101197304071326'
```

### T 5

```sql
SELECT t1.pid childpid,
       t1.pname childname,
       t1.birthdate childbirthdate,
       t2.pid parentpid,
       t2.pname parentname,
       t2.birthdate parentbirthdate
FROM bk.deptor t1,
     bk.deptor t2
WHERE t1.parentpid = t2.pid
  AND t1.birthdate-t2.birthdate > 365*22
```

### T 6

```sql
SELECT t1.pid childpid,
       t1.pname childname,
       t1.birthdate childbirthdate,
       t2.pid parentpid,
       t2.pname parentname,
       t2.birthdate parentbirthdate
FROM bk.deptor t1,
     bk.deptor t2
WHERE t1.parentpid = t2.pid
  AND t1.birthdate-t2.birthdate > 365*22
  AND t1.pid IN
    (SELECT pid
     FROM bk.deposit
     WHERE amount > 6000)
  AND t2.pid IN
    (SELECT pid
     FROM bk.deposit
     WHERE amount > 9000)
```

### T 7

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT *
     FROM bk.deptor t2
     WHERE t1.parentpid = pid
       AND EXISTS
         (SELECT *
          FROM bk.deposit
          WHERE t2.parentpid = pid
            AND amount > 8900))
```

### T 8

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT *
     FROM bk.deposit t2
     WHERE t1.pid = pid
       AND EXISTS
         (SELECT bid
          FROM bk.bank
          WHERE city = '成都'
            AND bid = t2.bid))
  AND NOT EXISTS
    (SELECT *
     FROM bk.deposit t2
     WHERE t1.pid = pid
       AND EXISTS
         (SELECT bid
          FROM bk.bank
          WHERE city = '西宁'
            AND bid = t2.bid))
```

### T 9

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT *
     FROM bk.deposit
     WHERE t1.pid = pid
       AND bid IN
         (SELECT bid
          FROM bk.bank
          WHERE city = '成都')
       AND amount > 5000)
  AND EXISTS
    (SELECT *
     FROM bk.deposit
     WHERE t1.pid = pid
       AND bid IN
         (SELECT bid
          FROM bk.bank
          WHERE city = '重庆')
       AND amount > 6000)
```

### T 10

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE NOT EXISTS
    (SELECT *
     FROM bk.bank t2
     WHERE NOT EXISTS
         (SELECT *
          FROM bk.deposit
          WHERE t1.pid = pid
            AND t2.bid = bid))
```

## Lab 3

### T 1

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE NOT regexp_like (pid, '[^0-9]')
```

### T 2

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE TO_CHAR (birthdate,
               'yyyymmdd') = SUBSTR (pid,
                                     7,
                                     8)
```

### T 3

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE sex = '男'
  OR sex = '女'
  OR sex IS NULL
```

### T 4

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE LENGTH (pname) *2 = lengthb (pname)
```

### T 5

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE age = 2019 - EXTRACT (YEAR
                            FROM birthdate)
```

### T 6

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE age = 2019 - EXTRACT (YEAR
                            FROM birthdate)
  AND LENGTH (pname) *2 = lengthb (pname)
  AND (sex = '男'
       OR sex = '女'
       OR sex IS NULL)
  AND TO_CHAR (birthdate,
               'yyyymmdd') = SUBSTR (pid,
                                     7,
                                     8)
  AND NOT regexp_like (pid, '[^0-9]')
```

### T 7

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE pid IN
    (SELECT pid
     FROM bk.deposit)
```

### T 8

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE parentpid IN
    (SELECT pid
     FROM bk.deptor3)
  OR parentpid IS NULL
```

### T 9

```sql
WITH tb_test AS
  (SELECT *
   FROM bk.deptor3
   WHERE sex IN ('男',
                 '女'))
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM tb_test
WHERE (birthdate IN
         (SELECT birthdate
          FROM tb_test
          WHERE sex = '女')
       AND sex = '男')
  OR (birthdate IN
        (SELECT birthdate
         FROM tb_test
         WHERE sex = '男')
      AND sex = '女')
ORDER BY birthdate
```

### T 10

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor3
WHERE (pid,
       pname) IN
    (SELECT pid,
            pname
     FROM bk.deptor)
```

## Lab 4

### T 1

```sql
SELECT CAST (REGEXP_REPLACE (pid,
                             '[^0-9]',
                             '0') AS varchar2 (18)) pid,
            CAST (REGEXP_REPLACE (pname,
                                  '[ -~]',
                                  '') AS varchar2 (20)) pname,
REPLACE
  (REPLACE (sex,
            ' ',
            '') , '性',
                  '') sex,
        age,
        birthdate,
        parentpid
FROM bk.deptor3
```

### T 2

```sql
SELECT CAST (SUBSTR (pid,
                     1,
                     6) ||TO_CHAR (birthdate,
                                   'yyyymmdd') ||SUBSTR (pid,
                                                         15) AS varchar2 (20)) pid,
            pname,
            sex,
            CASE
                WHEN age > 2019 - EXTRACT (YEAR
                                           FROM birthdate) THEN 2019 - EXTRACT (YEAR
                                                                                FROM birthdate)
                ELSE age
            END age,
            birthdate,
            parentpid
FROM bk.deptor3
```

### T 3

```sql
WITH t AS
  (SELECT t.pid,
          pname,
          sex,
          age,
          birthdate,
          parentpid,
          NVL (
                 (SELECT SUM (amount)
                  FROM bk.deposit
                  WHERE pid = parentpid) , 0) total_amount1,
              NVL (
                     (SELECT SUM (amount)
                      FROM bk.deposit
                      WHERE pid = t.pid) , 0) total_amount2,
                  NVL (
                         (SELECT SUM (amount)
                          FROM bk.deposit
                          WHERE pid = parentpid) , 0) + NVL (
                                                               (SELECT SUM (amount)
                                                                FROM bk.deposit
                                                                WHERE pid = t.pid) , 0) total_amount
   FROM bk.deptor3 t
   ORDER BY total_amount DESC)
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,
       total_amount1,
       total_amount2,
       total_amount
FROM t
WHERE rownum < = 20
```

### T 4

```sql
WITH t2 AS
  (SELECT pid,
          COUNT (*) total_count,
                SUM (amount) total_amount,
                    round (AVG (amount) , 2) avg_amount
   FROM bk.deposit
   WHERE pid IN
       (SELECT pid
        FROM bk.deptor3)
   GROUP BY pid)
SELECT t1.pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,
       total_count,
       total_amount,
       avg_amount
FROM bk.deptor3 t1,
     t2
WHERE t1.pid = t2.pid (+)
```

### T 5

```sql
WITH t2 AS
  (SELECT pid,
          COUNT (*) total_count,
                SUM (amount) total_amount,
                    round (AVG (amount) , 2) avg_amount
   FROM
     (SELECT t1.pid,
             amount
      FROM bk.deposit t2,
           bk.deptor3 t1
      WHERE t1.pid = t2.pid
      UNION ALL SELECT t1.pid,
                       amount
      FROM bk.deposit t2,
           bk.deptor3 t1
      WHERE t1.parentpid = t2.pid)
   GROUP BY pid)
SELECT t1.pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,
       NVL (total_count,
            0) total_count,
           total_amount,
           avg_amount
FROM bk.deptor3 t1,
     t2
WHERE t1.pid = t2.pid (+)
```

### T 6

```sql
WITH t2 AS
  (SELECT pid,
          COUNT (*) total_count,
                SUM (amount) total_amount,
                    round (AVG (amount) , 2) avg_amount
   FROM
     (SELECT t1.pid,
             amount
      FROM bk.deposit t2,
           bk.deptor3 t1
      WHERE t1.pid = t2.pid
        AND EXISTS
          (SELECT *
           FROM bk.deposit
           WHERE pid = t1.parentpid)
      UNION ALL SELECT t1.pid,
                       amount
      FROM bk.deposit t2,
           bk.deptor3 t1
      WHERE t1.parentpid = t2.pid)
   GROUP BY pid)
SELECT t1.pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,
       total_count,
       total_amount,
       avg_amount
FROM bk.deptor3 t1,
     t2
WHERE t1.pid = t2.pid (+)
```

### T 7

```sql
WITH t2 AS
  (SELECT pid,
          SUM (round (amount* (TRUNC (sysdate, 'dd') - TRUNC (dtime, 'dd')) *dailyrate, 2)) total_interest
   FROM bk.deposit b1,
        bk.bank b2
   WHERE b1.bid = b2.bid
     AND pid IN
       (SELECT pid
        FROM bk.deptor3)
   GROUP BY pid)
SELECT t1.pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,
       total_interest
FROM bk.deptor3 t1,
     t2
WHERE t1.pid = t2.pid (+)
```

### T 8

```sql
WITH ta_08 AS
  (SELECT pid,
          pname,
          sex,
          age,
          birthdate,
          parentpid,
          TO_CHAR (birthdate,
                   'mmdd') sbday
   FROM bk.deptor3
   WHERE sex IN ('男',
                 '女'))
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,

  (SELECT MAX (birthdate)
   FROM ta_08 t2
   WHERE t1.sbday = t2.sbday) birthdate1
FROM ta_08 t1
```

### T 9

```sql
WITH ta_09 AS
  (SELECT pid,
          pname,
          sex,
          age,
          birthdate,
          parentpid,
          TO_CHAR (birthdate,
                   'mmdd') sbday
   FROM bk.deptor3
   WHERE sex IN ('男',
                 '女'))
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,
       CAST (
               (SELECT MAX (pid)
                FROM ta_09 t2
                WHERE birthdate =
                    (SELECT MAX (birthdate)
                     FROM ta_09 t3
                     WHERE t1.sbday = t3.sbday)) AS varchar2 (20)) pid1
FROM ta_09 t1
```

### T 10

```sql
WITH ta_10 AS
  (SELECT pid,
          pname,
          sex,
          age,
          birthdate,
          parentpid,
          TO_CHAR (birthdate,
                   'mmdd') sbday
   FROM bk.deptor3
   WHERE sex IN ('男',
                 '女'))
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,

  (SELECT MAX (pid)
   FROM ta_10 t2
   WHERE t2.sex = '女'
     AND birthdate =
       (SELECT MAX (birthdate)
        FROM ta_10 t3
        WHERE t1.sbday = t3.sbday
          AND t3.sex = '女')) pid1
FROM ta_10 t1
WHERE sex = '男'
UNION ALL
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid,

  (SELECT MAX (pid)
   FROM ta_10 t2
   WHERE t2.sex = '男'
     AND birthdate =
       (SELECT MAX (birthdate)
        FROM ta_10 t3
        WHERE t1.sbday = t3.sbday
          AND t3.sex = '男')) pid1
FROM ta_10 t1
WHERE sex = '女'
```

## Lab 5

### T 1

```sql
SELECT t1.bid,
       bname,
       COUNT (*) dcount,
             COUNT (DISTINCT pid) pcount,
                   SUM (amount) sum_amount,
                       round (AVG (amount) , 2) avg_amount
FROM bk.deposit t1,
     bk.bank t2
WHERE t1.bid = t2.bid
GROUP BY t1.bid,
         bname
```

### T 2

```sql
SELECT city,
       t1.bid,
       bname,
       COUNT (*) dcount,
             SUM (amount) sum_amount
FROM bk.deposit t1,
     bk.bank t2
WHERE t1.bid = t2.bid
GROUP BY city,
         t1.bid,
         bname
UNION
SELECT city,
       '0000',
       '合计',
       COUNT (*) dcount,
             SUM (amount) sum_amount
FROM bk.deposit t1,
     bk.bank t2
WHERE t1.bid = t2.bid
GROUP BY city
ORDER BY city,
         bid
```

### T 3

```sql
SELECT CAST (TO_CHAR (TRUNC (EXTRACT (YEAR
                                      FROM birthdate) , -1) , 'fm0000') ||'后' AS varchar2 (20)) generation,
            COUNT (*) dcount,
                  SUM (amount) sum_amount,
                      MAX (total_count) total_count,
                          round (COUNT (*) /MAX (total_count) *100, 2) count_percent,
                          MAX (total_amount) total_amount,
                              round (SUM (amount) /MAX (total_amount) *100, 2) amount_percent
FROM bk.deposit t1,
     bk.deptor t2,
     bk.bank t3,
  (SELECT COUNT (*) total_count,
                SUM (amount) total_amount
   FROM bk.deposit)
WHERE t1.pid = t2.pid
  AND t1.bid = t3.bid
GROUP BY TO_CHAR (TRUNC (EXTRACT (YEAR
                                  FROM birthdate) , -1) , 'fm0000')
ORDER BY generation
```

### T 4

```sql
SELECT t1.city,
       dcount1,
       sum_amount1,
       round (sum_amount1/sum_amount*100, 2) amount_percent1,
       dcount2,
       sum_amount2,
       round (sum_amount2/sum_amount*100, 2) amount_percent2,
       dcount,
       sum_amount
FROM
  (SELECT city,
          COUNT (*) dcount1,
                SUM (amount) sum_amount1
   FROM bk.deposit t1,
        bk.bank t2
   WHERE t1.bid = t2.bid
     AND stru = '国有银行'
   GROUP BY city) t1,

  (SELECT city,
          COUNT (*) dcount2,
                SUM (amount) sum_amount2
   FROM bk.deposit t1,
        bk.bank t2
   WHERE t1.bid = t2.bid
     AND stru = '股份银行'
   GROUP BY city) t2,

  (SELECT city,
          COUNT (*) dcount,
                SUM (amount) sum_amount
   FROM bk.deposit t1,
        bk.bank t2
   WHERE t1.bid = t2.bid
   GROUP BY city) t
WHERE t1.city = t2.city
  AND t1.city = t.city
ORDER BY city
```

### T 5

```sql
SELECT t1.bankname,
       dcount1,
       sum_amount1,
       dcount2,
       sum_amount2
FROM
  (SELECT SUBSTR (bname,
                  3) bankname,
                 COUNT (*) dcount1,
                       SUM (amount) sum_amount1
   FROM bk.deposit t1,
        bk.bank t2
   WHERE t1.bid = t2.bid
     AND city = '北京'
   GROUP BY SUBSTR (bname,
                    3)) t1,

  (SELECT SUBSTR (bname,
                  3) bankname,
                 COUNT (*) dcount2,
                       SUM (amount) sum_amount2
   FROM bk.deposit t1,
        bk.bank t2
   WHERE t1.bid = t2.bid
     AND city = '上海'
   GROUP BY SUBSTR (bname,
                    3)) t2
WHERE t1.bankname = t2.bankname
ORDER BY t1.bankname
```

### T 6

```sql
WITH bkamount AS
  (SELECT pid,
          bid,
          SUM (amount) sum_amount
   FROM bk.deposit
   GROUP BY pid,
            bid)
SELECT bid,
       pid,
       sum_amount
FROM bkamount t1
WHERE (bid,
       sum_amount) IN
    (SELECT bid,
            MAX (sum_amount)
     FROM bkamount
     GROUP BY bid)
ORDER BY bid
```

### T 7

```sql
SELECT CAST (TO_CHAR (TRUNC (amount,
                             -3) , 'fm0000') ||'-'||TO_CHAR (TRUNC (amount,
                                                                    -3) +999,
                                                                   'fm0000') AS varchar2 (20)) amount,
            COUNT (*) dcount,
                  SUM (amount) sum_amount
FROM bk.deposit
WHERE amount > = 2000
  AND amount < = 9999
GROUP BY TRUNC (amount,
                -3)
ORDER BY amount
```

### T 8

```sql
SELECT city,
       CAST (TO_CHAR (TRUNC (EXTRACT (YEAR
                                      FROM birthdate) , -1) , 'fm0000') ||'后' AS varchar2 (20)) generation,
            EXTRACT (YEAR
                     FROM dtime) dyear,
                    COUNT (*) dcount,
                          SUM (amount) sum_amount
FROM bk.deposit t1,
     bk.deptor t2,
     bk.bank t3
WHERE t1.pid = t2.pid
  AND t1.bid = t3.bid
GROUP BY city,
         TO_CHAR (TRUNC (EXTRACT (YEAR
                                  FROM birthdate) , -1) , 'fm0000') , EXTRACT (YEAR
                                                                               FROM dtime)
ORDER BY city,
         generation,
         dyear
```

### T 9

```sql
SELECT t1.pid,
       t2.pname,
       t2.sex,
       COUNT (*) dcount,
             SUM (amount) sum_amount
FROM bk.deposit t1,
     bk.deptor t2
WHERE t1.pid = t2.pid
  AND sex = '女'
  AND amount > 2000
GROUP BY t1.pid,
         t2.pname,
         t2.sex
HAVING COUNT (*) > 130
AND SUM (amount) < 900000
ORDER BY dcount
```

### T 10

```sql
SELECT CAST (TO_CHAR (TRUNC (EXTRACT (YEAR
                                      FROM birthdate) , -1) , 'fm0000') ||'后' AS varchar (20)) generation,
            COUNT (*) pcount,
                  SUM (s) sum_amount
FROM
  (SELECT pid,
          SUM (amount) s
   FROM bk.deposit
   GROUP BY pid
   HAVING SUM (amount) > = 500000) t1,
     bk.deptor t2
WHERE t1.pid = t2.pid
GROUP BY TRUNC (EXTRACT (YEAR
                         FROM birthdate) , -1)
ORDER BY TRUNC (EXTRACT (YEAR
                         FROM birthdate) , -1)
```

## Lab 6

### T 1

```sql
SELECT CAST (SUBSTR (pname,
                     2) AS varchar2 (20)) first_name,
            COUNT (*) frequency
FROM bk.deptor
GROUP BY SUBSTR (pname,
                 2)
HAVING COUNT (*) > 5
```

### T 2

```sql
SELECT letter,
       SUM (frequency) frequency
FROM
  (SELECT CAST (SUBSTR (pname,
                        2,
                        1) AS varchar2 (10)) letter,
               COUNT (*) frequency
   FROM bk.deptor
   GROUP BY SUBSTR (pname,
                    2,
                    1)
   UNION ALL SELECT SUBSTR (pname,
                            3,
                            1) letter,
                           COUNT (*) frequency
   FROM bk.deptor
   WHERE LENGTH (pname) > 2
   GROUP BY SUBSTR (pname,
                    3,
                    1))
GROUP BY letter
HAVING SUM (frequency) > 10
```

### T 3

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE sex = '男'
  AND age = 40
  AND EXISTS
    (SELECT pid
     FROM bk.deposit
     WHERE t1.pid = pid
     GROUP BY pid
     HAVING SUM (amount) > 600000)
```

### T 4

```sql
SELECT t1.pid,
       pname,
       sex,
       age,
       COUNT (*) count_amount,
             SUM (amount) sum_amount
FROM bk.deptor t1,
     bk.deposit t2,
     bk.bank t3
WHERE t1.pid = t2.pid
  AND t3.bid = t2.bid
  AND city = '北京'
  AND sex = '女'
  AND age > 30
GROUP BY t1.pid,
         pname,
         sex,
         age
HAVING SUM (amount) > 500000
AND COUNT (*) > 60
```

### T 5

```sql
SELECT bid,
       bname,

  (SELECT MAX (amount)
   FROM bk.deposit
   WHERE t1.bid = bid) max_amount,

  (SELECT COUNT (*)
   FROM bk.deposit
   WHERE t1.bid = bid
     AND amount IN
       (SELECT MAX (amount) amount
        FROM bk.deposit
        WHERE t1.bid = bid)) max_amount_count
FROM bk.bank t1
```

### T 6

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t
WHERE sex = '女'
  AND age = 40
  AND EXISTS
    (SELECT pid
     FROM bk.deposit
     WHERE t.pid = pid
       AND amount > 6000
     GROUP BY pid,
              bid
     HAVING COUNT (*) > 3)
```

### T 7

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT pid
     FROM bk.deposit
     WHERE t1.pid = pid
       AND amount > 200
     GROUP BY pid
     HAVING COUNT (DISTINCT bid) = 360)
  AND sex = '女'
```

### T 8

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT *
     FROM bk.deptor t2
     WHERE t1.parentpid = parentpid
       AND t1.pid < > pid)
ORDER BY parentpid
```

### T 9

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE sex = '女'
  AND age > 40
  AND pid IN
    (SELECT pid
     FROM bk.deposit
     WHERE bid IN
         (SELECT bid
          FROM bk.bank
          WHERE city = '北京')
     GROUP BY pid
     HAVING SUM (amount) > 300000)
  AND pid NOT IN
    (SELECT pid
     FROM bk.deposit
     WHERE bid IN
         (SELECT bid
          FROM bk.bank
          WHERE city = '西宁'))
```

### T 10

```sql
SELECT rownum rank,
              pid,
              sum_amount
FROM
  (SELECT pid,
          SUM (amount) sum_amount
   FROM bk.deposit
   GROUP BY pid
   ORDER BY sum_amount DESC)
WHERE rownum < = 20
```

## Lab 7

### T 1

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT *
     FROM bk.deptor t2
     WHERE t1.parentpid = parentpid
       AND t1.pid < > pid)
UNION
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE EXISTS
    (SELECT ''
     FROM bk.deptor t2
     WHERE t1.pid = parentpid
     GROUP BY parentpid
     HAVING COUNT (*) > 1)
```

### T 2

```sql
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE sex = '男'
  AND EXISTS
    (SELECT *
     FROM bk.deptor t2
     WHERE t1.parentpid = parentpid
       AND t1.pid < > pid
       AND sex = '男')
UNION
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE sex = '女'
  AND EXISTS
    (SELECT *
     FROM bk.deptor t2
     WHERE t1.parentpid = parentpid
       AND t1.pid < > pid
       AND sex = '女')
UNION
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE sex = '男'
  AND EXISTS
    (SELECT ''
     FROM bk.deptor t2
     WHERE t1.pid = parentpid
       AND sex = '男'
     GROUP BY parentpid
     HAVING COUNT (*) > 1)
UNION
SELECT pid,
       pname,
       sex,
       age,
       birthdate,
       parentpid
FROM bk.deptor t1
WHERE sex = '男'
  AND EXISTS
    (SELECT ''
     FROM bk.deptor t2
     WHERE t1.pid = parentpid
       AND sex = '女'
     GROUP BY parentpid
     HAVING COUNT (*) > 1)
```

### T 3

```sql
SELECT t1.pid,
       t1.pname,
       t1.sex,
       t1.age,
       t1.birthdate,
       t1.parentpid,
       total_amount
FROM bk.deptor t1,

  (SELECT pid,
          SUM (amount) total_amount
   FROM bk.deposit
   GROUP BY pid
   HAVING (SUM (amount) > 2000000)) t2
WHERE t1.pid = t2.pid
```
