-- dba账户
-- silijion abc123

-- 创建表空间
create tablespace qm

datafile 'D:\develop\General\Oracle\tablespace\qm.dbf'

size 100m

-- 硬盘不足，自动扩大10m
autoextend on

next 10m;

-- 删除表空间
drop tablespace silijion;

-- 创建用户 并指定表空间
create user qm
identified by qm
default tablespace qm;

-- 给用户授权
-- oracle数据库中常用角色：
connect -- 链接角色，基本角色
resource -- 开发者角色
dba --超级管理员角色

--给qm授予dba角色
grant dba to qm;

-- 切换到qm用户下

数据类型：
char(1) 不可变
varchar2(20)可变长度
number 表示一个整数或者小数 （4.2）总长度是4，保留2位小数
data 时间类型


-- 创建一个person表
create table person(
    pid number(20),
    pname varchar2(32)
);

-- 修改表结构
-- 添加一列
alter table person add (gender number(1));

-- 修改列类型
alter table person modify gender char(1);

-- 修改列名称
alter table person rename column gender to sex;

-- 删除一列
alter table person drop column sex;

-- 添加一条记录
insert into person (pid,pname) values (1,'小明');
commit;

select * from person;
-- 修改一跳记录
update person set pname='小马' where pid = 1;
 commit;

-- 三个删除
-- 删除表中全部记录
delete from person;
-- 删除表
drop from person;
-- 删除表，再次创建表。效果等同于删除表中全部记录
-- 在数据量大的情况下，尤其是表中带有索引的情况，该操作效率高
-- 索引可以 提高查询效率，但是会影响增删改效率
truncate table person;

-- 序列：默认从1开始，依次递增，主要用来给主键赋值使用。
-- dual:虚表，只是为了补全语法，没有任何意义。
-- []可选可不选
create sequence s_person;
select s_person.nextval from dual;
select s_person.currval from dual;

insert into person (pid,pname) values (s_person.nextval,'好的');

commit;

-- scott用户，密码tiger。
-- 解锁scott用户
alter user scott account unlock;
-- 解锁scott用户密码
alter user scott identified by tiger;
-- 切换到scott用户

-- 单行函数：作用于一行，返回一个值。

--字符函数
select upper('yes') from dual;
select lower('YES') from dual;
-- 数值函数
select round(26.14,1) from dual;--四舍五入，后面的参数表示保留的位数。
select round(26.14,-1) from dual;--四舍五入，后面的参数表示保留的位数。

select trunc(26.14,1) from dual;--直接截取，不在看后面的位数
select mod(10,3) from dual;--求余数

-- 日期函数
-- 查询出emp表中所有员工入职距离现在几天
select sysdate-e.hiredate from emp e;
--算出明天此刻
select sysdate+1 from dual;
-- 查看出emp表中所有员工入职距离现在几月
select months_between(sysdate,e.hiredate) from emp e;
-- 查看出emp表中所有员工入职距离现在几年
select months_between(sysdate,e.hiredate)/12 from emp e;
-- 查看出emp表中所有员工入职距离现在几周
select round((sysdate-e.hiredate)/7) from emp e;


-- 转换函数
-- 把当前日期转换成字符串
select to_char(sysdate,'yyyy-MM-dd hh:mi:ss') from dual;
-- 2020-02-23 02:02:40 去掉0
select to_char(sysdate,'fm yyyy-MM-dd hh:mi:ss') from dual;
-- 转换成24小时
select to_char(sysdate,'fm yyyy-MM-dd hh24:mi:ss') from dual;

-- 把字符串转日期
select to_date('2020-2-23 14:2:17','fm yyyy-MM-dd hh24:mm:ss') from dual;--错误
select to_date('2020-2-23 14:2:17','fm yyyy-MM-dd hh24:mi:ss') from dual;
select to_date('2020-02-23 02:02:40','yyyy-MM-dd hh:mi:ss') from dual;

--通用函数
-- 算出emp表中所有员工的年薪
select e.sal*12 from emp e;
-- 加上奖金
select e.sal*12+e.comm from emp e;
-- 奖金中有null值，用nvl()与mysql ifNull类似
select e.sal*12+nvl(e.comm,0) from emp e;


-- 条件表达式
-- 给emp表中的员工起中文名
-- else可以省略，多个字段以逗号隔开
-- mysql和oracle通用
select

   case  ename
       when 'SMITH' then '张三'

       when 'ALLEN' then '李四'

       when 'WARD' then '王五'

       else
         '醉清风'
            end

from emp;

-- 判断emp表中的员工工资，如果高于3000显示高收入，如果高于1500低于3000显示中等收入，其余显示低收入
-- case 可以写在when后面
-- 不用写小于3000，程序一步步执行的
select
   case
       when e.sal>3000 then '高收入'

       when e.sal>1500 then '中等收入'

       else
         '低收入'
            end
from emp e;

-- oracle专用条件表达式
-- oracle中，除了起别名，都用单引号。
select
     e.ename,
     decode(
         e.ename,
          'SMITH',  '张三',
          'ALLEN',  '李四',
          'WARD',  '王五',
          '醉清风'
     )
from emp e;


-- 多行函数：作用于多行，返回一个值。【聚合函数】
-- count(*)底层走的还是count(1) == count(主键这一列)
select count(1) from emp e;  --总数量
select sum(e.sal) from emp e;--总和
select max(e.sal) from emp e;--最大
select min(e.sal) from emp e;--最低
select avg(e.sal) from emp e;--平均


-- 分组查询
-- 查询出每个部门的平均工资
-- 分组查询中，出现在group by后面的原始列，才能出现在select后面
-- 没有出现在group by 后面的列，想在select后面，必须加上聚合函数。
-- 聚合函数有一个特性，可以把多行记录变成一个值。

select e.deptno,avg(e.sal)
from emp e
group by
e.deptno;

-- 查询出平均工资高于2000的部门信息

select e.deptno,avg(e.sal) asal
from emp e
group by
e.deptno
having avg(e.sal)>2000;
-- 所有条件都不能使用别名来判断
select ename, sal s from emp where sal>1500;
select ename, sal s from emp where s>1500;--错误

-- 查询出每个部门工资高于800的员工的平均工资
select e.deptno,avg(e.sal)
from emp e
where e.sal>800
group by
e.deptno;

-- where是过滤分组前的数据，having是过滤分组后的数据。
--表现形式：where必须在group by之前，having是在group by之后。

--查询出平均工资高于2000的部门
-- ***** having后面不能用asal *****
select e.deptno,avg(e.sal) asal
from emp e
group by
e.deptno
having avg(e.sal)>2000;

-- 多表查询中的一些概念
-- 笛卡尔积

select * from emp e, dept d;

-- 等值连接，内连接，mysql隐式连接
select * from emp e, dept d where e.deptno = d.deptno;
select * from emp e inner join dept d on e.deptno = d.deptno;

-- 查询出所有部门，以及部门下的员工信息。【外连接】
select * from dept d left join emp e on d.deptno = e.deptno;

-- 查询所有员工信息，以及员工所属部门。
select * from emp e left join dept d on e.deptno = d.deptno;

-- oracle中专用外连接 +号
select *
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 查询出员工姓名，员工领导姓名
-- 自连接：其实就是在不同的角度把一张表看成多张表
select
t1.ename,t2.ename
from emp t1,emp t2
where
t1.empno = t2.mgr;

-- 查询出员工姓名，员工部门名称，员工领导姓名，员工领导部门名称。【总记录13条】
-- 员工领导部门名称 and t3.deptno = t2.deptno 会变成11条记录，再将部门表拆分出来
select
t1.ename,t3.dname,t2.ename
from emp t1,emp t2,dept t3,dept t4
where
t1.empno = t2.mgr and t1.deptno = t3.deptno and t4.deptno = t2.deptno;

-- 子查询
-- 子查询返回一个值
-- 查询出工资和scott一样的员工信息
-- 其中=号是有风险的，子查询中条件ename假如不是主键，为空或者名称一样，查询出来一个集合。
select * from emp where sal in -- =
(select sal from emp where ename = 'SCOTT');
-- 子查询返回一个集合
--查询出工资和10号部门任意员工一样的员工信息
select * from emp where sal in
(select sal from emp where deptno = 10);
-- 子查询返回一张表
-- 查询出每个部门最低工资，和最低工资员工姓名，和该员工所在部门名称。
--  1.先查询出每个部门最低工资
select depno,min(sal) msal
from emp
group by deptno
-- 2.三表联查，得到最终结果
select t.deptno, t.msal,e.ename,d.dname
from
(
select deptno,min(sal) msal
from emp
group by deptno
) t ,emp e,dept d
where t.deptno = e.deptno
and t.msal = e.sal
and e.deptno = d.deptno;


--oracle中的分页
-- rownum行号：当我们做select操作的时候，
--没查询出一行记录，就会在该行上加上一个行号，
--行号从1开始，依次递增，不能跳着走。
--emp表工资倒叙排列后，每页五行记录，查询第二页。
-- 排序操作会影响rownum的顺序 ，rownum不能用表t.rownum
select rownum,e.* from emp e order by e.sal desc;
-- 如果涉及到排序，但是还要使用rownum的话，我们可以再次嵌套查询。
select rownum,t.* from (select rownum,e.* from emp e order by e.sal desc) t;

-- emp表工资倒叙排列后，每页五条记录，查询第二页。
-- rownum行号不能写上大于一个正数 rownum最小是1，可以大于0

select rownum,t.* from (
select * from emp order by sal desc
) t where rownum < 11 and rownum >5;--错误写法


select * from (
  select rownum rn,t.* from (
  select * from emp order by sal desc
  ) t where rownum < 11
) where rn > 5;

ROWNUM是一个序列，是oracle数据库从数据文件或缓冲区中读取数据的顺序。
它取得第一条记录则rownum值为1，第二条为2，依次类推。如果你用>,>=,=,between...and这些条件，
因为从缓冲区或数据文件中得到的第一条记录的rownum为1，则被删除， 接着取下条，可是它的rownum还是1，又被删除，依次类推，便没有了数据。
