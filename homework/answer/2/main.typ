#import "@preview/tyniverse:0.2.3": homework
#import "@preview/zebraw:0.6.1": *
// #import "@preview/subpar:0.2.2"
// #import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
// #import "@preview/pinit:0.2.2": *

#set page("a4")
#show: homework.template.with(
    course: "数据库系统",
    number: 2,
    student-infos: ((name: "彭靖轩", id: "202400130242"),),
)
#set enum(numbering: n => emph(strong(numbering("a.", n))))
#show: zebraw.with(lang: false)

#homework.simple-question[_10.1_]
1. 第一种.因为实时查询要求可预期的短响应时间;缓存方案会有命中/未命中波动,最坏情况不稳定.
2. 第二种.因为超大 `customer` 中只有少量热点块时,放热点到 SSD 性价比更高,冷热分层更合适.

#homework.simple-question[_10.2_]
只用外侧磁道的优势：
1. 传输速率更高(外侧每圈可读写的数据更多).
2. I/O 性能更稳定、延迟更可预测(有利于数据库负载).

#homework.simple-question[_10.4_]
1. 保持记录原有顺序,查询顺序扫描更友好;但删除代价较高(要移动多条记录).
2. 删除代价中等(只移动一条,这里是把 7 移到 5),空间也紧凑;但会打乱记录顺序.
3. 删除代价最低(只做标记);但会产生空洞,后续扫描变慢,需要空闲链表或定期重组.

#homework.simple-question[_10.5_]
设图 10-7 初始空闲链表: 头 -> 1 -> 4 -> 6 -> null。
1. 插入 (24556, Turnamian, Finance, 9800): 占用记录 1, 新空闲链表为 头 -> 4 -> 6 -> null。
2. 删除记录 2: 采用头插法回收, 新空闲链表为 头 -> 2 -> 4 -> 6 -> null。
3. 插入 (34556, Thompson, Music, 67000): 占用记录 2, 新空闲链表为 头 -> 4 -> 6 -> null。

#homework.simple-question[_10.6_]
section 的一个实例(3 个课段):
1. (sec-1, DB, 2026S)
2. (sec-2, AI, 2026S)
3. (sec-3, OS, 2026S)

takes 的一个实例(每个课段 5 人, 共 15 条):
1. sec-1: (s01, sec-1), (s02, sec-1), (s03, sec-1), (s04, sec-1), (s05, sec-1)
2. sec-2: (s06, sec-2), (s07, sec-2), (s08, sec-2), (s09, sec-2), (s10, sec-2)
3. sec-3: (s11, sec-3), (s12, sec-3), (s13, sec-3), (s14, sec-3), (s15, sec-3)

多表聚簇的一种文件结构(按 sec_id 聚簇):
1. 簇 C1: section(sec-1, DB, 2026S) + 5 条 takes(sec-1)
2. 簇 C2: section(sec-2, AI, 2026S) + 5 条 takes(sec-2)
3. 簇 C3: section(sec-3, OS, 2026S) + 5 条 takes(sec-3)

#homework.simple-question[_10.10_]
1. $ product_("ID", "name")(sum_("salary" > 0)"instructor") $ (基本是全表顺序扫描).顺序扫描/外排读,缓冲区满时优先淘汰“刚读过”的页(MRU);因为这些页短期内最不可能再被访问.
2. $ sum_("dept_name" = "Comp. Sci.")"instructor" $ (通过索引反复访问热点页).B+ 树索引查找(点查或小范围查),会反复用到根页、内部页和少量热点数据页;LRU 更能保留这些最近用过的页.

#homework.simple-question[_10.14_]
1. 变长字段为 null 时: 偏移量可设为该字段前一字段的结束位置(或任意约定值),长度字段设为 0;是否为空由空位图判定.
2. 可以.做法是把属性分组到多个子记录/子表(垂直分解),主记录只保留主键和少量常用列;空属性所在子记录不存在时,开销可接近仅 1 个空位图位(外加极少目录/指针开销).

#homework.simple-question[_10.15_]
1. 局部性与 I/O 次数(连续块更少寻道与旋转等待).
2. 缓冲命中率(相关记录放近更容易命中缓存).
3. 插入/删除与碎片开销(坏分配会导致迁移、链指针跳转和重组).
4. 并发与吞吐(热点块过于集中会加剧锁/闩竞争).

#homework.simple-question[_10.19_]
可用“价值密度”选择淘汰对象。
1. 设对象 i 在最近 n 秒引用率为 $f_i$, 读取代价为 $c_i$, 大小为 $s_i$.
2. 定义保留价值: $ V_i = (f_i * c_i) / s_i $
3. 缓冲区不足时,优先移出 $V_i$ 最小的对象(并跳过脏页写回中的不可立即淘汰页).
访问少、获取便宜、却占空间大的对象先淘汰;访问频繁或代价高的对象保留.
