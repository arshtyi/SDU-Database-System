#import "@preview/ori:0.2.3": *
#import "@preview/zebraw:0.6.1": *

#let font = (
    main: "IBM Plex Serif",
    mono: "Fira Code",
    cjk: "Source Han Serif SC",
    emph-cjk: "Source Han Serif SC",
    math: "New Computer Modern Math",
    math-cjk: "Source Han Serif SC",
)

#let conf(body) = {
    set heading(
        numbering: numbly(
            "",
            "",
            "{3:i}.",
        ),
    )
    show heading.where(level: 1): set align(center)
    body
}

#let code(path, lang) = {
    raw(block: true, read(path), lang: lang)
}

#show: ori.with(
    title: [山东大学计算机科学与技术学院\ 24智能数据库系统课程实验代码],
    author: link("https://github.com/Arshtyi/SDU-Database-System", "Arshtyi"),
    // subject: "ACM Templates",
    // semester: "2026 春",
    date: datetime.today(),
    maketitle: true,
    first-line-indent: auto,
    font: font,
    // makeoutline: true,
    // outline-depth: 3,
    // size: 12pt,
    // theme: "dark",
    media: "print",
    lang: "en",
    // region: "cn",
)

#show: conf

#show: zebraw.with(
    lang: false,
    lang-font-args: font,
)
