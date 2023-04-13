# Программный комплекс для прототипирования систем на кристалле большого размера с использованием нескольких чипов ПЛИС 

**Описание:** Программно – аппаратный комплекс, автоматизирующий генерацию прошивок для ПЛИС, и соединяющий обе ПЛИС высокоскоростным интерфейсом.
Задачи:
1)	Разработка программного комплекса для разделения cети на кристалле по нескольким ПЛИС;
2)	Реализация взаимодействия между ПЛИС посредством интерфейса Ethernet;
3)	Имплементация и прототипирование сети на кристалле и реализацию сложной системы на кристалле на двух ПЛИС, соединенных между собой параллельной шиной;

В данной работе использовалась сеть на кристалле, разработанная УЛ САПР МИЭМ. Данная сеть состоит из N узлов (для примера на рисунке их 9), каждый из которых представляет собой роутер и процессор SchoolMIPS. Данная топология называется циркулянтной.

![топология сети](https://drive.google.com/uc ? id = 1pi5jrOrbGSxens0jkL4leA_7By4ls1Bg)
https://drive.google.com/file/d/1pi5jrOrbGSxens0jkL4leA_7By4ls1Bg/view?usp=sharing

Программное обеспечение для генерации прошивок (парсер) для двух ПЛИС позволяет упростить разработчику сетей на кристалле и процессоров прототипирование перспективных архитектур на нескольких ПЛИС. Парсер параметризирован, что позволяет с легкостью разъеденить сеть на две ПЛИС: необходимо указать какие роутеры будут имплементированы  в выбранной ПЛИС. Синтез списка соединений основан на открытом инструменте Yosys (https://github.com/YosysHQ/yosys), что упрощает перенос проекта на ПЛИС разных проихводителей (в проекте использовались ПЛИС Xilinx).

Быстродействие системы из нескольких ПЛИС упирается в пропускную способность линий связи кристаллов ПЛИС. Использование GPIO не оправданно по быстродействию, а также недостаточным количеством выводов ПЛИС для больших систем на кристалле (СнК). Решением проблем может быть использование сверхскоростных интерфейсов (например Ethernet). Связь  по Ethernet   реализована благодаря UDP коммутатотору.

### Структура (основной код):

- ***Парсер***

```mermaid
graph TD;
  A["Парсер (папка)"]-->C["parser.py - генерация файлов верхнего уровня иерархии для двух ПЛИС"]
  A["Парсер (папка)"]-->B["auto_scripts(папка)"]
  B["auto_scripts (папка)"]-->D["synth_noc_fpga_1.ys - синтез списка соединений"]
  B["auto_scripts (папка)"]-->E["test_edif_script.tcl - имплементация и генерация прошивки для ПЛИС"]
```
- ***Коммутатор***
```mermaid
graph TD;
  A["Commutator (папка)"]-->B["Mode_commutator (папка) - шинный комутатор"];
  A["Commutator (папка)"]-->C["UDP_commutator (папка) - UDP коммутатор"];
  B["Mode_commutator (папка) - шинный комутатор"]-->D["clock_control.v - контроллер коммутатор и генеартор частоты"];
  B["Mode_commutator (папка) - шинный комутатор"]-->F["mod_rx_commut.v - применик"];
  B["Mode_commutator (папка) - шинный комутатор"]-->G["mod_tx_commut.v - передатчик"];
  C["UDP_commutator (папка) - UDP коммутатор"]-->E["new_commutator.rar - архив проекта UDP коммутатора в Vivado"];
```
