#import "@preview/ezexam:0.3.1": *
#import "@preview/zero:0.6.1": num, set-num, set-unit, zi
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lovelace:0.3.1": *
#import "@preview/cetz:0.5.2"

#show: setup.with(
    mode: EXAM,
    resume: false,
    heading-top: 0em,
    heading-bottom: 0.4em,
    line-height: 0.65em,
    par-spacing: 0.65em,
    enum-spacing: 0.65em,
    list-spacing: 0.65em,
)
#set par(justify: true)
#set smartquote(quotes: "\"\"")
#show link: it => text(fill: blue.darken(20%), underline(it))
#show raw: set text(font: ("IBM Plex Mono", "Source Han Sans SC", "Noto Sans CJK SC"))
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 0.3em, y: 0em),
    outset: (x: 0em, y: 0.3em),
    radius: 0.2em,
)
#show raw.where(block: true): block.with(
    fill: luma(248),
    stroke: 0.5pt + rgb("bfbfbf"),
    inset: 0.7em,
    radius: 4pt,
)
#set-unit(fraction: "power")
#show strong: set text(weight: "bold")
#set enum(numbering: n => emph(strong(numbering("a.", n))))

#let question = question.with(supplement: "Q", ref-on: true, show-ref-prefix: false)
#let (B, KB, MB, GB, TB) = (
    zi.declare("B"),
    zi.declare("KB"),
    zi.declare("MB"),
    zi.declare("GB"),
    zi.declare("TB"),
)
#let (mus, ms, s) = (
    zi.declare("mus"),
    zi.declare("ms"),
    zi.declare("s"),
)
#let (MB-s,) = (
    zi.declare("MB/s"),
)
#let (ll, rr) = (sym.lt.eq.slant, sym.gt.eq.slant)
#let pk(body) = underline(offset: 3.5pt, evade: false, body)
#let schema(
    body,
    caption: none,
    supplement: [Schema],
    numbering: "1",
) = figure(
    kind: "schema",
    supplement: supplement,
    numbering: numbering,
    caption: caption,
    align(
        center,
        block(
            stroke: 0.7pt + gray,
            inset: (x: 18pt, y: 10pt),
            radius: 0pt,
            {
                set align(left)
                set text(font: "New Computer Modern", size: 11pt)
                set par(leading: 0.55em)
                emph(body)
            },
        ),
    ),
)
#title[山东大学计算机科学与技术学院数据库系统课后作业]
#exam-info(info: (班级: "24智能", 教师: "梁文革"))
#notice(
    [出于方便使用#link("https://github.com/gbchu/ezexam", "gbchu/ezexam:0.3.1")作模板.],
    [源码:#link("https://github.com/arshtyi/SDU-Database-System", "source").],
    [课程主要参考的是#link("https://www.cmpedu.com/books/book/5610387.htm", "The book"). 注意用的是*本科教学版*.],
)

= No.1
#question[
    (_3.4_) 考虑图3-17(亦如下)的保险公司数据库,其中主码下划线.构造以下SQL查询:
    + 找到$2017$年涉及事故的汽车的车主总数.
    + 删除`ID`为`'12345'`的人的所有$2010$年汽车.
    #schema[
        person (#pk[driver_id], name, address) \
        car (#pk[license_plate], model, year) \
        accident (#pk[report_number], year, location) \
        owns (#pk[driver_id], #pk[license_plate]) \
        participated (#pk[report_number], #pk[license_plate], driver_id, damage_amount)
    ]<S1>
]

#question[
    (_3.8_) 考虑图3-18(亦如下)的银行数据库,其中主码下划线.构造以下SQL查询:
    + 找到每个有账户但没有贷款的客户的`ID`.
    + 找到住在与客户`'12345'`同一城市且同一街道的每个客户的`ID`.
    + 找到每个这样的分行的名字:该分行至少有一个客户在银行有账户,并且住在`"Harrison"`.
    #schema[
        branch(#pk[branch_name], branch_city, assets) \
        customer(#pk[ID], customer_name, customer_street, customer_city) \
        loan(#pk[loan_number], branch_name, amount) \
        borrower(#pk[ID], #pk[loan_number]) \
        account(#pk[account_number], branch_name, balance) \
        depositor(#pk[ID], #pk[account_number])
    ]<S2>
]

#question[
    (_3.9_) 考虑图3-19(亦如下)的员工数据库,其中主码下划线.给出以下查询的SQL表达式:
    + 找到每个为`"First Bank Corporation"`工作的员工的`ID`、姓名和居住城市.
    + 找到每个为`"First Bank Corporation"`工作且收入超过$10000$美元的员工的ID、姓名和居住城市.
    + 找到每个不为`"First Bank Corporation"`工作的员工的`ID`.
    + 找到每个收入超过`"Small Bank Corporation"`的每个员工的`ID`.
    + 假设公司可能位于几个城市.找到位于`"Small Bank Corporation"`所在的所有城市的每个公司名称.
    + 找到员工最多的公司名称(如果有员工最多的公司有多个,则一并列出).
    + 找到每个员工平均收入高于`"First Bank Corporation"`平均收入的公司名称.
    #schema[
        employee(#pk[ID], person_name, street, city) \
        works(#pk[ID], #pk[company_name], salary) \
        company(#pk[company_name], city) \
        manages(#pk[ID],manager_ID)
    ]<S3>
]

#question[
    (_3.15_) 考虑图3-18(亦如@S2)的银行数据库,其中主码下划线.构造以下SQL查询:
    + 找到在`"Brooklyn"`的每个分行都有账户的每个客户.
    + 找到银行中所有贷款金额的总和.
    + 找出资产比位于`"Brooklyn"`的至少一个分行的资产更大的所有分行的名字.
]

#question[
    (_3.16_) 考虑图3-19(亦如@S3)的员工数据库,其中主码下划线.给出以下查询的SQL表达式:
    + 找到每个员工的`ID`和姓名,这些员工住在与他们工作的公司所在的城市相同的城市.
    + 找到每个员工的`ID`和姓名,这些员工住在与他们的经理所在的城市和街道相同的城市和街道.
    + 找到每个员工的`ID`和姓名,这些员工的收入超过他们所在公司的所有员工的平均收入.
    + 找到拥有最小工资总额的公司名称.
]

#question[
    (_3.17_) 考虑图3-19(亦如@S3)的员工数据库,其中主码下划线.给出以下查询的SQL表达式:
    + 给`"First Bank Corporation"`的所有员工加薪10%.
    + 给`"First Bank Corporation"`的所有经理加薪10%.
    + 删除`"Small Bank Corporation"`员工在_works_关系中的所有元组.
]

#question[
    (_3.21_) 考虑图3-20(亦如下)的图书馆数据库,其中主码下划线.给出以下查询的SQL表达式:
    + 找到至少借过一本由`"McGraw-Hill"`出版的书的每个会员的会员号和姓名.
    + 找到借过`"McGraw-Hill"`出版的每本书的每个会员的会员号和姓名.
    + 对于每个出版社,找到借过该出版社的超过五本书的每个会员的会员号和姓名.
    + 找到每个会员平均借书数量.考虑到如果一个会员没有借过任何书,那么该会员在_borrowed_关系中根本不出现,但该会员仍然计入平均数中.
    #schema[
        member(#pk[memb_no], name) \
        book(#pk[isbn], title, authors, publisher) \
        borrowed(#pk[memb_no], #pk[isbn], date)
    ]<S4>
]

#question[
    (_4.1_) 考虑以下SQL查询,该查询试图找到2017年春季所有课程的标题以及教师的姓名.
    ```sql
    SELECT name, title
    FROM instructor NATURAL JOIN teaches NATURAL JOIN section NATURAL JOIN course
    WHERE semester = 'Spring' AND year = 2017;
    ```
    这个查询有什么问题?
]

#question[
    (_4.2_) 用SQL编写以下查询:
    + 显示所有教师的列表,显示每个教师的`ID`和教授的课程数量.确保显示的课程数量为$0$的教师也显示在结果中.你的查询应该使用外连接,并且不使用子查询.
    + 使用标量子查询编写与*a*部分相同的查询,但不使用外连接.
    + 显示$2018$年春季提供的所有课程部分的列表,以及每个教授该部分的教师的`ID`和姓名.如果一个部分有多个教师,则该部分应该在结果中出现多次,每个教师对应一次.如果一个部分没有任何教师,它仍然应该出现在结果中,教师姓名设置为`"-"`.
    + 显示所有部门的列表,以及每个部门的教师总数,不使用子查询.确保显示没有教师的部门,并将这些部门的教师数量列为$0$.
]

#question[
    (_4.7_) 考虑图4-12(亦如下)的员工数据库.给出该数据库的SQL`DDL`定义.确定应该满足的参照完整性约束,并将它们包含在`DDL`定义中
    #schema[
        employee(#pk[ID], person_name, street, city) \
        works(#pk[ID], #pk[company_name], salary) \
        company(#pk[company_name], city) \
        manages(#pk[ID],manager_ID)
    ]<S5>
]

#question[
    (_6.2_) 考虑图6-11(亦如下)的职员数据库.使用关系代数表达式来表示下面的每个查询:
    + 找出居住在`"Miami"`的每个员工的姓名.
    + 找出所有工资超过$100000$美元的员工的姓名.
    + 找出居住在`"Miami"`的每个员工的姓名,并且他们的工资超过$100000$美元.
    #schema[
        employee(ID, person_name, street, city) \
        works(person_name, company_name, salary) \
        company(company_name, city) \
    ]<S6>
]

#question[
    (_6.3_) 考虑图6-12(亦如下)的银行数据库.使用关系代数表达式来表示下面的每个查询:
    + 找出位于`"Chicago"`的每个分行的名字.
    + 找出在`"Downtown"`分行有贷款的每位贷款人的`ID`.
    #schema[
        branch(branch_name, branch_city, assets) \
        customer(ID, customer_name, customer_street, customer_city) \
        loan(loan_number, branch_name, amount) \
        borrower(ID, loan_number) \
        account(account_number, branch_name, balance) \
        depositor(ID, account_number)
    ]<S7>
]

#question[
    (_6.5_) 定义关系代数的*除法算子*:设关系$r(R),s(S)$且$S subset.eq R$;也就是说模式$R$包含模式$S$中的所有属性.给定一个元组$t$,令$t[S]$表示元组$t$在$S$中属性上的投影.那么,$r div s$是$R-S$上的一个关系.元组$t$在$r div s$的充要条件是:
    - $t$在$product_(R-S)(r)$中
    - 对于每个$s$中的元组$t_s$,在$r$中存在一个元组$t_r$同时满足:
        + $t_r[S] = t_s[S]$
        + $t_r[R-S] = t$
    根据上述定义:
    + 使用除法算子写出一个关系代数表达式,找出所有选修过全部计算机科学课程的学生的`ID`.
    + 展示如何在不适用除法的情况下,使用关系代数表达式来表示上述查询.
]

#question[
    (_6.9_) 考虑图6-13(亦如下)的关系数据库,其中主码下划线.为下面的每个查询写出元组关系演算:
    + 找出所有直接为`"Jones"`工作的员工.
    + 找出所有直接为工作的员工居住的城市.
    + 找出`"Jones"`的经理的经理的姓名.
    + 找出比居住在`"Mumbai"`的所有员工收入更高的所有员工.
    #schema[
        employee(#pk[person_name], street, city) \
        works(#pk[person_name], company_name, salary) \
        company(#pk[company_name], city) \
        manages(#pk[person_name], manager_name)
    ]<S8>
]

#question[
    (_6.11_) 考虑图6-12(亦如@S7)的银行数据库.使用关系代数表达式表达下面的查询:
    + 找出贷款额度超过$10000$美元的每个贷款号.
    + 找出每个这样的存款人`ID`:拥有一个存款余额大于$6000$美元的账户.
    + 找出每个这样的存款人`ID`:在`"Uptown"`分行有一个存款余额大于$6000$美元的账户
]

#question[
    (_6.12_) 对于大学模式,使用关系代数编写下面的查询:
    + 找出物理系中每位教师的`ID`和姓名.
    + 找出位于`"Watson"`教学楼的系的每位教师的`ID`和姓名.
    + 找出至少选修过`"Comp. Sci"`系的一门课程的每位学生的`ID`和姓名.
    + 找出在$2018$年至少上过一门课程的每位学生的`ID`和姓名.
    + 找出在$2018$年没有上过任何课程的每位学生的`ID`和姓名.
]

#question[
    (_6.13_) 考虑图6-13(亦如@S8)的员工数据库.为下面的每个查询给出元组关系演算表达式:
    + 找出所有为`"FBC"`工作的员工的姓名.
    + 找出所有为`"FBC"`工作的员工的姓名和居住城市.
    + 找出所有为`"FBC"`工作且收入超过$10000$美元的员工的姓名、居住城市和街道地址.
    + 找出所有居住在与其工作的公司相同城市的员工.
    + 找出所有居住在与其经理相同城市和街道的员工.
    + 找出所有在数据库中不为`"FBC"`工作的员工.
    + 找出所有收入超过`"SBC"`的所有员工的员工.
    + 假设公司可能位于几个城市.找出位于`"SBC"`所在的所有城市的每个公司名称.
]
= No.2
#question[
    (_10.1_) SSD可用作存储器和磁盘之间的存储设备,数据库的某些部分可以存储在SSD.另一种选择是把SSD用作磁盘的缓存.
    + 如果需要实时查询,你会选择哪种方式?为什么?
    + 如果有一个非常大型的客户关系,仅有一些磁盘块经常被访问,你会选择哪种方式?为什么?
]

#question[
    (_10.2_) 一些数据库仅使用外侧磁道中的扇区而不是内侧磁道中的扇区.为什么?
]

#question[
    (_10.4_) 考虑从图10-6(亦如下)中的文件中删除记录5.比较下列实现技术:
    + 将记录$6$移到记录$5$的位置并将记录$7$移到记录$6$的位置.
    + 将记录$7$移到记录$5$的位置.
    + 标记记录$5$为已删除.
    #align(
        center,
        figure(
            table(
                columns: 5,
                align: (left, center, center, center, center),
                inset: (x: 8pt, y: 5pt),
                [记录 0], [10101], [Srinivasan], [Comp. Sci.], [65000],
                [记录 1], [12121], [Wu], [Finance], [90000],
                [记录 2], [15151], [Mozart], [Music], [40000],
                [记录 11], [98345], [Kim], [Elec. Eng.], [80000],
                [记录 4], [32343], [El Said], [History], [60000],
                [记录 5], [33456], [Gold], [Physics], [87000],
                [记录 6], [45565], [Katz], [Comp. Sci.], [75000],
                [记录 7], [58583], [Califieri], [History], [62000],
                [记录 8], [76543], [Singh], [Finance], [80000],
                [记录 9], [76766], [Crick], [Biology], [72000],
                [记录 10], [83821], [Brandt], [Comp. Sci.], [92000],
            ),
        ),
    )
]

#question[
    (_10.5_) 给出经过下面每一步后图10-7(亦如下)中文件的结构:
    + 插入```sql (24556,Turnamian,Finance,9800)```.
    + 删除记录$2$.
    + 插入```sql (34556,Thompson,Music,67000)```.
    #{
        set align(center)
        set text(size: 9pt)
        cetz.canvas(length: 1cm, {
            import cetz.draw: *
            let row-h = 0.45
            let rows = 13 // 文件头 + 记录 0..11
            let xl = 1.10
            let xr = 7.10
            let xs = (xl, 2.20, 3.95, 5.75, xr)
            let label-x = 0.45
            let row-center(i) = -(i + 0.5) * row-h
            set-style(stroke: black + 0.55pt)

            content((label-x, row-center(0)), [文件头], anchor: "center", padding: 0pt)
            for i in range(12) {
                content(
                    (label-x, row-center(i + 1)),
                    [记录 #i],
                    anchor: "center",
                    padding: 0pt,
                )
            }
            for x in xs {
                line((x, 0), (x, -rows * row-h))
            }
            for r in range(rows + 1) {
                let y = -r * row-h
                line((xl, y), (xr, y))
            }

            let data = (
                ("10101", "Srinivasan", "Comp. Sci.", "65000"),
                ("", "", "", ""),
                ("15151", "Mozart", "Music", "40000"),
                ("22222", "Einstein", "Physics", "95000"),
                ("", "", "", ""),
                ("33456", "Gold", "Physics", "87000"),
                ("", "", "", ""),
                ("58583", "Califieri", "History", "62000"),
                ("76543", "Singh", "Finance", "80000"),
                ("76766", "Crick", "Biology", "72000"),
                ("83821", "Brandt", "Comp. Sci.", "92000"),
                ("98345", "Kim", "Elec. Eng.", "80000"),
            )
            for (i, row) in data.enumerate() {
                let y = row-center(i + 1)
                for (j, val) in row.enumerate() {
                    if val != "" {
                        content(
                            (xs.at(j) + 0.2, y),
                            val,
                            anchor: "west",
                            padding: 0pt,
                        )
                    }
                }
            }

            // 表头 -> 记录 1
            // 记录 1 -> 记录 4
            // 记录 4 -> 记录 6
            let ptr(y1, y2) = {
                bezier(
                    (xr - 0.05, y1),
                    (xr - 0.05, y2),
                    (xr + 0.65, y1 - 0.12),
                    (xr + 0.65, y2 + 0.12),
                    mark: (end: "stealth"),
                    stroke: black + 0.55pt,
                )
            }
            ptr(row-center(0), row-center(2))
            ptr(row-center(2), row-center(5))
            ptr(row-center(5), row-center(7))

            // 记录 6 -> NULL / ground
            let yn = row-center(7)
            line((xr - 0.05, yn), (xr + 0.70, yn), (xr + 0.70, yn - 0.28))
            line((xr + 0.45, yn - 0.28), (xr + 0.95, yn - 0.28))
            line((xr + 0.52, yn - 0.36), (xr + 0.88, yn - 0.36))
            line((xr + 0.60, yn - 0.44), (xr + 0.80, yn - 0.44))
        })
    }
]

#question[
    (_10.6_) 考虑_section_和_takes_关系.给出这两个关系的一个实例,包括$3$个课程,每个课程有$5$个学生.给出对这些关系使用多表聚簇的一种文件结构.
]

#question[
    (_10.10_) 对于下面每种情况,给出一个关系代数表达式和一个查询处理策略的示例:
    + MRU优于LRU.
    + LRU优于MRU.
]

#question[
    (_10.14_) 在变长记录表示中,用空位图表示属性是否为空值.
    + 对于变长字段,如果值为空,那么偏移量字段和长度字段中应该存储什么?
    + 在一些应用中,元组有非常大量的属性,其中大部分属性都是空.你能否更改记录表示使得一个空值属性的开销仅为空位图中的一个位?
]

#question[
    (_10.15_) 解释为什么在磁盘块上分配记录会显著影响数据库系统的性能.
]

#question[
    (_10.19_) 标准的缓冲区管理器假定每个块的大小和读取代价是相同的.设想一个缓冲区管理器使用对象引用率而不是LRU.假设我们要在缓冲区存储变长和读取代价可变的对象.试建议缓冲区管理器可以如何选择要从缓冲区中移出哪个块.
]
= No.3
#question[
    (_11.1_) 索引加快了查询处理,但是在作为潜在搜索码的每个属性上或者每个属性组合上创建索引通常是不好的.为什么?
]

#question[
    (_11.2_) 在同个关系的不同搜索码上建两个聚集索引一般来说是否可行?
]

#question[
    (_11.9_) 给定一个数据库模式和一些经常执行的查询.如何决定要创建什么样的索引?
]

#question[
    (_11.10_) 考虑图11-1(亦如下)的_instructor_关系:
    + 在_salary_属性上构建一个位图索引,把_salary_的值分成$4$个区间:小于$50000$,$50000$到$60000$以下,$60000$到$70000$以下,$70000$及以上的.
    + 考虑查询:查找在金融系中工资大于或等于$80000$的所有教师.概述该查询的步骤,并给出为回答这个查询而构建的最终位图和中间位图.
    #{
        set align(center)
        set text(size: 9pt)
        cetz.canvas(length: 1cm, {
            import cetz.draw: *

            let row-h = 0.52
            let rows = 12
            let x0 = 0.00
            let x1 = 1.45
            let x2 = 3.30
            let x3 = 5.15
            let x4 = 6.65
            let x5 = 7.35
            let xs = (x0, x1, x2, x3, x4, x5)
            let yc(i) = -(i + 0.5) * row-h
            let bottom = -rows * row-h
            set-style(stroke: black + 0.55pt)

            for x in xs {
                line((x, 0), (x, bottom))
            }
            for i in range(rows + 1) {
                let y = -i * row-h
                line((x0, y), (x5, y))
            }

            let data = (
                ("10101", "Srinivasan", "Comp. Sci.", "65000"),
                ("12121", "Wu", "Finance", "90000"),
                ("15151", "Mozart", "Music", "40000"),
                ("22222", "Einstein", "Physics", "95000"),
                ("32343", "El Said", "History", "60000"),
                ("33456", "Gold", "Physics", "87000"),
                ("45565", "Katz", "Comp. Sci.", "75000"),
                ("58583", "Califieri", "History", "62000"),
                ("76543", "Singh", "Finance", "80000"),
                ("76766", "Crick", "Biology", "72000"),
                ("83821", "Brandt", "Comp. Sci.", "92000"),
                ("98345", "Kim", "Elec. Eng.", "80000"),
            )

            for (i, row) in data.enumerate() {
                let y = yc(i)
                content((x0 + 0.25, y), [#row.at(0)], anchor: "west", padding: 0pt)
                content((x1 + 0.25, y), [#row.at(1)], anchor: "west", padding: 0pt)
                content((x2 + 0.25, y), [#row.at(2)], anchor: "west", padding: 0pt)
                content((x3 + 0.25, y), [#row.at(3)], anchor: "west", padding: 0pt)
            }

            let px = x4 + 0.12
            let bx = x5 + 0.58
            let link(i) = {
                let y1 = yc(i)
                let y2 = yc(i + 1)
                bezier(
                    (px, y1),
                    (px, y2),
                    (bx, y1),
                    (bx, y2),
                    mark: (end: "stealth"),
                    stroke: black + 0.55pt,
                )
            }
            for i in range(rows - 1) {
                link(i)
            }

            let gy = yc(rows - 1)
            let gx = x5 + 0.92
            line((px, gy), (gx, gy), (gx, gy - 0.34))
            line((gx - 0.24, gy - 0.34), (gx + 0.24, gy - 0.34))
            line((gx - 0.17, gy - 0.42), (gx + 0.17, gy - 0.42))
            line((gx - 0.09, gy - 0.50), (gx + 0.09, gy - 0.50))
        })
    }
]

#question[
    (_11.11_) 什么时候使用稠密索引比使用稀疏索引更可取?
]

#question[
    (_11.15_) 假设关系$r(A,B,C)$,带有一个搜索码$(A,B)$上的$"B"^+$树索引.
    + 用这个索引来查找满足$10<A<50$的记录,最坏情况下的代价是多少?用获取的记录数目$n_1$和树的高度$h$度量.
    + 用这个索引来查找满足$10<A<50 and 5<B<10$记录,最坏情况下的代价是多少?用满足此选择的记录数目$n_2$以及上述定义的$n_1$和$h$度量.
    + 当$n_1$和$n_2$满足什么条件时,此索引是查找满足$10<A<50 and 5<B<10$的记录的一种高效方法?
]

= No.4
#question[
    (_12.1_) 假设一个块只能放入一个元组且内存最多容纳$3$个块.当应用归并排序对下述元组按第一属性进行排序时,给出每一步产生的归并段.
    ```sql
    (kangaroo,17), (wallaby, 21), (emu,1),
    (wombat,13), (platypus,3), (lion,8),
    (warthog,4), (zebra,11), (meerkat,6),
    (hyena,9), (hornbill, 2), (baboon,12)
    ```
]

#question[
    (_12.18_) 考虑关系$r_1(A,B,C),r_2(C,D,E),r_3(E,F)$,主码分别为$A,C,E$.$r_1$有$1000$个元组,$r_2$有$1500$个元组,$r_3$有$750$个元组.估计$r_1 join r_2 join r_3$的规模并给出一种高效的计算策略.
]

#question[
    (_12.19_) 考虑@1-4-2 中的关系$r_1(A,B,C),r_2(C,D,E),r_3(E,F)$.假设除了整个模式外不存在主码.令$V(C,r_1)=900,V(C,r_2)=1100,V(E,r_2)=50,V(E,r_3)=100$.设$r_1$有$1000$个元组,$r_2$有$1500$个元组,$r_3$有$750$个元组.估计$r_1 join r_2 join r_3$的规模并给出一种高效的计算策略.
]

#question[
    (_12.29_) 假设使用#KB[4]块和#MB[40]内存对一个#GB[40]的关系进行排序.设一次寻道代价#ms[5],磁盘传输速率#MB-s[40].
    + 分别给出$b_b=1$和$b_b=100$下对关系进行排序的代价(以#s()计).
    + *a*中各需要多少次归并.
    + 设使用一个延迟#mus[20]传输速率#MB-s[400]的闪存代替磁盘,分别给出$b_b=1$和$b_b=100$下对关系进行排序的代价(以#s()计).
]

#question[
    (_12.31_) 基于混合归并-连接算法设计一种算法适用于:两个关系在物理上均未排序但各自都有连接属性上的有序辅助索引.
]

#question[
    (_12.36_) 设_department_关系在```sql (dept_name, building)```上有$B^+$树索引.则处理下面选择的最佳方式时什么.
    $
        sigma_(("building"<"\"Waston\"")and("budget"<55000)and("dept_name"="\"Music\""))("department")
    $
]

#question[
    (_12.40_) 如何使用直方图估计形如$sigma_(A ll v)(r)$的选择规模.
]

#question[
    (_13.6_) 考虑图13-16(亦如下)的优先图,相应的调度时冲突可串行优化的吗?为什么?
    #align(
        center,
        diagram(
            node-stroke: .5pt,
            node((0, 0), $T_1$),
            edge((0, 0), (2, 0), "-|>"),
            edge((0, 0), (0, 1), "-|>"),
            edge((0, 0), (2, 1), "-|>"),
            node((2, 0), $T_2$),
            edge((2, 0), (2, 1), "-|>"),
            edge((2, 0), (0, 1), "-|>"),
            node((0, 1), $T_4$),
            edge((0, 1), (1, 2), "-|>"),
            node((2, 1), $T_3$),
            edge((2, 1), (1, 2), "-|>"),
            node((1, 2), $T_5$),
        ),
    )
]

#question[
    (_13.7_) 什么是无级联调度?为什么要求无级联调度?是否存在要求允许级联调度的情况?为什么?
]

#question[
    (_13.8_) 发生*丢失更新*异常是指如果事务$T_j$读取了一个数据项,然后另一个事务$T_k$写该数据项(可能基于先前的读取),这个$T_j$再写该数据项.于是$T_k$的更新丢失.
    + 给出一个表明丢失更新异常的调度.
    + 给出一个表明在*已提交读*隔离性级别可能发生丢失更新异常的调度.
    + 解释为什么在*可重复读*隔离性级别下丢失更新异常不可能发生.
]

#question[
    (_13.11_) 一个调度的定义假设操作是可以完全按时间排列的.考虑一个在多处理器系统上运行的数据库系统,其并不总是能对于运行在不同处理器上的操作确定一种准确次序.但是一个数据项上的操作是完全可以排序的.上述情况是否给冲突可串行化的定义带来问题?为什么?
]

#question[
    (_13.14_) 解释_串行调度_和_可串行化调度_的区别.
]

#question[
    (_13.15_) 考虑事务:
    - $T_13$: #pseudocode-list[
            - read(A);
            - read(B);
            - *if* A = 0 *them* B := B + 1;
            - write(B);
        ]
    - $T_14$: #pseudocode-list[
            - read(B);
            - read(A);
            - *if* B = 0 *then* A := A + 1;
            - write(A);
        ]
    令一致性需求为$A=0or B=0$,初值$A=B=0$.
    + 说明为什么包括这两个事务的每一个串行执行都保持了数据库的一致性.
    + 给出产生不可串行化调度的一次并发执行.
    + 是否存在产生可串行化调度的一次并发执行?
]
#question[
    (_13.16_) 给出具有两个事务的一个可串行化调度的示例,其中事务的提交次序与串行化的次序不同.
]
#question[
    (_13.17_) 什么是可恢复调度?为什么要求可恢复调度?存在需要允许出现不可恢复调度的情况吗?为什么?
]

#question[
    (_14.2_) 考虑事务:
    - $T_34$: #pseudocode-list[
            - read(A);
            - read(B);
            - *if* A = 0 *them* B := B + 1;
            - write(B);
        ]
    - $T_35$: #pseudocode-list[
            - read(B);
            - read(A);
            - *if* B = 0 *then* A := A + 1;
            - write(A);
        ]
    给上述事务增加封锁和解锁指令使其遵从两阶段封锁协议.这两个事务的执行会导致死锁吗?
]

#question[
    (_14.3_) 强两阶段封锁带来了什么好处?其与其他形式的两阶段封锁相比有何异同?
]

#question[
    (_14.14_) 为什么`undo-list`中事务的日志记录必须由后往前处理而执行重做时必须由前往后处理.
]

#question[
    (_14.15_) 解释检查点机制的目的.应该间隔多长时间执行一次检查点?执行检查点的频率对以下各项有无影响?
    - 无故障发生时的性能.
    - 从系统崩溃中恢复用时.
    - 从介质故障中恢复用时.
]

#question[
    (_14.24_) 如果通过死锁避免机制避免了死锁,还有可能饿死吗?为什么?
]

#question[
    (_14.34_) 如果与某块有关的某些日志记录没有在该块输出到磁盘前先被输出到稳定存储器中,解释数据库可能会变得怎样不一致.
]

#question[
    (_14.36_) 假设使用了两阶段封锁但排他锁提前释放也就是封锁不是以严格的两阶段方式实现.举例说明当使用基于日志的恢复算法时事务回滚为什么会导致错误的最终状态.
]

#question[
    (_14.37_) 考虑图14-24(亦如下)中的日志.设恰好在$<T_0 "abort">$日志记录被写出前系统崩溃,则系统恢复时会发生什么.
]
