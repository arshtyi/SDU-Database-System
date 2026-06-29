#import "@preview/ezexam:0.3.1": *
#import "@preview/zero:0.6.1": num, set-num, set-unit, zi

#show: setup.with(
    mode: EXAM,
    resume: false,
    heading-top: 0em,
    heading-bottom: .4em,
    line-height: .65em,
    par-spacing: .65em,
    enum-spacing: .65em,
    list-spacing: .65em,
)
#show link: it => text(fill: blue.darken(40%), underline(it))
#show strong: it => text(weight: "bold", it)
#set par(justify: true)

#let Title = "山东大学计算机科学与技术学院数据库系统期末试题"
#let author = "arshtyi"
#let date = datetime.today()
#set document(title: Title, date: date, author: author)
#title(Title)
#exam-info(info: (
    班级: "24智能",
    教师: "梁文革",
    时间: datetime(year: 2026, month: 6, day: 29).display("[year].[month].[day]"),
    源码: link("https://github.com/arshtyi/SDU-Database-System", "source"),
))
#set par(justify: true)
#show link: it => text(fill: blue.darken(40%), underline(it))
#show raw: set text(font: ("JetBrains Mono", "Noto Sans CJK SC"))
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: .3em, y: 0em),
    outset: (x: 0em, y: .3em),
    radius: .2em,
)
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
            stroke: .7pt + gray,
            inset: (x: 18pt, y: 10pt),
            radius: 0pt,
            {
                set align(left)
                set text(font: "New Computer Modern", size: 11pt)
                set par(leading: .55em)
                emph(body)
            },
        ),
    ),
)
#set-unit(fraction: "power")

= 存储
#question[
    分别对下列场景给出一个关系代数表达式和相应查询处理策略的实例：
    + MRU优于LRU。
    + LRU优于MRU。
]
= 查询优化
#question[
    设关系$r_1(A,B,C)$有#num[2e4]个元组，$r_2(C,D,E)$有#num[4.5e4]个元组，一个磁盘块可容纳#num[25]$r_1$元组或#num[30]$r_2$元组。若分别使用嵌套循环连接和块嵌套循环连接计算$r_1 bowtie.big r_2$，估计各自需要多少次块传输和磁盘寻道？
]
= 索引
#question[
    在同一关系的不同搜索码上建立两个聚簇索引一般是否可行？请解释并举例说明。
]
= 事务
#question[
    考虑如下调度
    - $S_1: T_2: R(B), T_2: W(B), T_1: W(A), T_1: R(B), T_3: R(A), T_1: W(B), T_2: W(A)$
    - $S_2: T_1: R(A), T_2: R(B), T_1: W(B), T_2: W(C), T_3: R(C), T_3: W(A)$
    + 给出$S_1$和$S_2$的优先图。
    + $S_1$和$S_2$是否是冲突可串行化的？若是，给出等价的串行调度。
]
= 封锁
#question[
    假设系统采用两阶段封锁，但允许事务在提交前提前释放排他锁，即并非严格两阶段封锁。请举例并画出相应调度，说明在基于日志的恢复算法中，事务回滚为什么可能导致错误的最终状态。
]
= BCNF
#question[
    设$R(A,B,C,D,E,G)$有函数依赖集$F={A->B C,B D->E,C D->A B}$。
    + 给出一个被上述函数依赖集逻辑蕴含、不包含无关属性的非平凡函数依赖，并给出寻找过程。
    + 给出从$A -> B C$开始对$R$进行的BCNF分解。
    + 说明此分解是否保持依赖。
]
= 3NF
#question[
    设$R(A,B,C,D,E,G,H)$有函数依赖集$F={A B -> C D,D -> C,D E -> B,D E H -> A B,A C -> D C}$。
    + 列出所有候选码。
    + 给出$F$的一个正则覆盖。
    + 给出3NF分解。
]
= 数据库设计
#question[
    为下述场景设计数据库：

    一个医院拥有若干科室，一个科室拥有若干医生、护士、病房。需要关注的信息如下：
    - 每个科室拥有编号与名称。
    - 每位医生拥有编号、姓名并对应若干病人。
    - 每位护士拥有编号、姓名并对应若干病人。
    - 每个病房拥有编号、名称并对应若干病人。
    - 每位病人拥有编号、姓名并有至少两位联系人信息。
    - 每位联系人拥有姓名和电话号码。
    + 给出E-R图。
    + 转化为关系模式。
]
= SQL 查询、关系代数表达式、元组关系演算
设学生关系、选课关系、课程关系分别如下：
#schema[
    S(SNo, SName, Age, Sex) \
    SC(SNo, CNo, Grade) \
    C(CNo, CName)
]
分别给出下列查询的关系代数表达式、元组关系演算和SQL 查询：
+ 所有没有学习C2课程的学生姓名。
+ 所有学习了学生S2所学全部课程的学生学号。
