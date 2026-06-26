#import "@preview/ezexam:0.3.1": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cetz:0.5.2"

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

#let Title = "山东大学计算机科学与技术学院数据库系统期末模拟"
#let author = "arshtyi"
#let date = datetime.today()
#set document(title: Title, date: date, author: author)
#title(Title)
#exam-info(info: (
    班级: "24智能",
    教师: "梁文革",
    时间: datetime(year: 2026, month: 6, day: 26).display("[year].[month].[day]"),
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

= 大数据管理实现技术

#question[
    考虑图中的日志。设恰好在$<T_0 "abort">$日志记录被写出前系统崩溃，则系统恢复时会发生什么。
    #{
        set align(center)
        cetz.canvas(length: 1cm, {
            import cetz.draw: *

            let P(x, y) = (x, -y)
            let ink = luma(23%)
            let gray-stroke = luma(55%) + 0.55pt
            let black-stroke = black + 0.6pt
            let put(x, y, body, anchor: "west", size: 9pt) = content(P(x, y), anchor: anchor, text(
                size: size,
                fill: ink,
                body,
            ))
            let callout(x1, y1, x2, y2, body, radius: 0.18, size: 8.7pt) = {
                rect(P(x1, y2), P(x2, y1), radius: radius, stroke: gray-stroke, fill: white)
                content(P((x1 + x2) / 2, (y1 + y2) / 2), anchor: "center", text(
                    size: size,
                    fill: ink,
                    align(center, body),
                ))
            }

            put(1.65, 0.93, [较老], anchor: "center", size: 9pt)
            line(P(2.15, 1.04), P(2.15, 8.55), stroke: black-stroke, mark: (end: ">"))
            put(1.65, 8.77, [较新], anchor: "center", size: 9pt)

            let log-x = 3.15
            put(log-x, 0.35, [日志开始], size: 9.5pt)
            put(log-x, 0.92, [\<$T_0$ start\>])
            put(log-x, 1.49, [\<$T_0$, B, 2000, 2050\>])
            put(log-x, 2.08, [\<$T_1$ start\>])
            put(log-x, 2.65, [\<checkpoint {$T_0$, $T_1$}\>])
            put(log-x, 3.24, [\<$T_1$, C, 700, 600\>])
            put(log-x, 3.82, [\<$T_1$ commit\>])
            put(log-x, 4.40, [\<$T_2$ start\>])
            put(log-x, 4.99, [\<$T_2$, A, 500, 400\>])
            put(log-x, 5.62, [\<$T_0$, B, 2000\>])
            put(log-x, 6.20, [\<$T_0$ abort\>])
            put(log-x, 7.42, [\<$T_2$, A, 500\>])
            put(log-x, 8.02, [\<$T_2$ abort\>])

            callout(0.02, 4.42, 1.8, 5.25, [崩溃时日志\ 的结束点], radius: 0.22, size: 8.4pt)
            line(P(1.3, 5.25), P(3.05, 6.18), stroke: gray-stroke)
            line(P(2, 6.2), P(1.5, 6.2), P(1.5, 8.2), P(2, 8.2), stroke: gray-stroke)
            put(0.5, 7.4, [恢复过程中\ 加入的\ 日志记录], anchor: "center", size: 8.5pt)

            callout(7.25, 3.32, 10.45, 4.25, [（在正常操作中）\ $T_0$开始回滚], radius: 0.22, size: 8.7pt)
            callout(7.85, 4.7, 10.25, 5.3, [$T_0$回滚完成], radius: 0.18, size: 8.7pt)
            callout(7.25, 5.8, 10.45, 6.5, [崩溃时$T_2$未完成], radius: 0.22, size: 8.7pt)
            line(P(5.4, 5.62), P(7.95, 4.25), stroke: gray-stroke)
            line(P(5, 6.1), P(7.85, 5), stroke: gray-stroke)
            line(P(5.10, 6.21), P(7.25, 6.16), stroke: gray-stroke)

            line(P(11.65, 3), P(11.65, 5.9), stroke: gray-stroke, mark: (end: ">"))
            put(12.2, 2.7, [重做阶段], anchor: "east", size: 9pt)
            put(10.55, 6.2, [undo-list: $T_2$], size: 9pt)

            callout(9.9, 1.10, 13.45, 2.38, [为undo-list中所有\ 事务找到start\ 日志记录], radius: 0.30, size: 8.5pt)
            line(P(12.8, 2.38), P(13.4, 4.2), stroke: gray-stroke)

            line(P(13.45, 7), P(13.45, 4.4), stroke: gray-stroke, mark: (end: ">"))
            put(13.45, 7.3, [撤销阶段], anchor: "center", size: 9pt)
            callout(11.85, 7.65, 14.4, 8.65, [在撤销阶段\ 回滚$T_2$], radius: 0.22, size: 8.7pt)
            line(P(5.45, 7.42), P(11.85, 8.2), stroke: gray-stroke)
        })
    }
]

= 数据库设计

#question[
    模式$R = (A,B,C,D,E,G)$上有函数依赖集$F$：$ A B arrow.r C D\ A D E arrow.r G D E\ B arrow.r G C\ G arrow.r D E $给出$R$的3NF分解：
    + 所有候选码。
    + $F$的一个正则覆盖。
    + 完整算法。
    + 分解。
]

= 关系语言

#question[
    考虑图中的关系数据库。为下面查询写出SQL、关系代数表达式和元组关系演算：
    + 找出所有直接为`"Jones"`工作的员工。
    + 找出所有直接为工作的员工居住的城市。
    + 找出`"Jones"`的经理的经理的姓名。
    + 找出比居住在`"Mumbai"`的所有员工收入更高的所有员工。
    #schema[
        employee(#pk[person_name], street, city) \
        works(#pk[person_name], company_name, salary) \
        company(#pk[company_name], city) \
        manages(#pk[person_name], manager_name)
    ]
]
