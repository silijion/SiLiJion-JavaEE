--视图
-- 视图的概念：视图就是提供一个查询的窗口，所有数据来自于原表。
-- 查询语句创建表(跨用户查询，mysql不能够跨数据库查询)
create table emp as select * from scott.emp;
select * from emp;
-- 创建视图【必须有dba权限】
create view v_emp as select ename,job from emp;
-- 查询视图
select * from v_emp;
-- 修改视图【不推荐】 视图修改数据等于修改原表数据
update v_emp set job = 'CLERK' where ename = 'ALLEN';
commit;
--创建只读视图
create view v_emp1 as select ename,job from emp with read only;
-- 视图的作用？
-- 第一：视图可以屏蔽掉一些敏感字段。（可以屏蔽工资）
-- 第二：保证总部和分布数据及时统一。主要特性

-- 索引
-- 索引的概念：索引就是在表的列上构建一个二叉树（相当书籍目录）
-- 达到大幅度提高查询效率的目的，但是所以会影响增删改的效率。

--单列索引
-- 创建单列索引
create index idx_ename on emp(ename);
-- 单列索引触发规则，条件必须是索引列中的原始值。
select * from emp where ename = 'SCOTT';
--复合索引
-- 创建复合索引
create index idx_enamejob on emp(ename,job);
-- 复合索引中第一列为优先检索列
-- 如果要触发复合索引，必须包含有优先索引列中的原始值
select * from emp where ename = 'SCOTT' and job ='ANALYST';--触发复合索引
select * from emp where ename = 'SCOTT' or job ='ANALYST';--不触发索引（or相当写了两个查询语句）
select * from emp where ename = 'SCOTT';--触发单列索引


plsql编程语言
pl/sql编程语言是对sql语言的扩展，使得sql语言具有过程化编程的特性。（面向过程）
pl/sql编程语言比一般的过程化编程语言，更加灵活高效。
pl/sql编程语言主要用来编写存储过程和存储函数等。

-- 声明方法(不像java里面的main函数有大括号)
-- 在declare下面申明变量，begin和end之间写业务逻辑
-- emp.ename%type等于emp表中的varchar2(10)

--赋值操作可以用:=也可以使用into查询语句赋值
declare
   i number(2):= 10;
   s varchar2(10) := '小明';
   ena emp.ename%type;--引用型变量
   --存一行记录，一个对象
   emprow emp%rowtype;--记录型变量
begin
  dbms_output.put_line(i);
   dbms_output.put_line(s);
   select ename into ena from emp where empno = 7788;
   dbms_output.put_line(ena);
   select * into emprow from emp where empno = 7788;
   -- 不能直接输出这个对象 oracle连接符||
   dbms_output.put_line(emprow.ename ||'的工作为：'|| emprow.job);
end ;

-- pl/sql中的if判断
-- 输入小于18的数字，输出未成年
-- 输入大于18小于40的数字，输出中年人
--  输入大于40的数字，输出老年人
-- &引号，代表输入操作 后面的ii随便可以写
declare
    i number(3) := &ii;
begin
  if i<18 then
     dbms_output.put_line('未成年');
  elsif i<40 then
    dbms_output.put_line('中年人');
  else
    dbms_output.put_line('老年人');
  end if ;
end;

-- pl/sql中的loop循环
-- 用三种方式输出1到10个数字
-- while循环
declare
   i number(2):=1;
begin
  while i<11 loop
    dbms_output.put_line(i);
    i :=i+1;
  end loop;
end;
-- exit循环，退出循环(用得最多的)
declare
   i number(2):=1;
begin
  loop
    exit when i>10;
    dbms_output.put_line(i);
    i :=i+1;
  end loop;
end;

-- for循环
declare

begin
  for i in 1..10 loop
    dbms_output.put_line(i);
    end loop;
end;

--游标(cursor)：可以存放多个对象，多行记录。
--输出emp表中所有员工的姓名
--想要遍历游标，首先得打开它。用完再关闭
declare
    cursor c1 is select * from emp;
    emprow emp%rowtype;
begin
  open c1;
  loop
    fetch c1 into emprow;--从游标里面取值，使用当行记录型变量
    exit when c1%notfound;--拿不到里面的对象，退出。
    dbms_output.put_line(emprow.ename);
  end loop;
  close c1;
end;

---给指定部门员工涨工资
-- 游标可以传参数进去 c2(eno emp.deptno%type) 带参数游标
declare
  cursor c2(eno emp.deptno%type) is select empno from emp where deptno = eno;
  en emp.empno%type;
begin
  open c2(10);--给10号员工赋值，打开的时候给游标赋值。
  loop
     fetch c2 into en;
     exit when c2%notfound;
     update emp set sal =sal+100 where empno = en;
     commit;
  end loop;
  close c2;--关闭的时候不需要赋值。
end;

--查询10号员工的信息
select * from emp e where e.deptno = 10;


-- 存储过程
-- 存储过程：存储过程就是提前已经编译好的一段pl/sql语言，放置再数据库端
-- 可以直接被调用，这一段pl/sql一般都是固定的步骤的业务。

-- 创建存储过程的语法：(相当编译好了，并不会执行，需要调用)
create [or replace] procedure 过程名[(参数名 in/out 数据类型)]

as --后面申明变量 可以写is

begin
  pl/sql子程序;

end;

-- 给指定员工涨100块钱。(or replace可以保证再次修改，去掉or replace可以有提示)
-- 右键p1编辑，可以查看存储过程错误原因
-- 参数不需要逗号隔开，后面写的是指定类型
create or replace procedure p1(eno emp.empno%type) --默认in
is

begin
    update emp set sal=sal+100 where empno = eno;
    commit;
end;

--查询员工的工资
select sal from emp where empno = 7788;

--测试p1
declare
begin
  p1(7788);
end;

-- 存储函数
-- 语法：
create or replace function 函数名(Name in type,Name in type,...)return 数据类型 is 结果变量 数据类型;
begin

return(结果变量名);
end 函数名;

-- 存储过程与存储函数的区别
一般来讲，过程和函数的区别在于函数可以有一个返回值，而过程没有返回值
但过程和函数都可以通过out指定一个或多个输出参数。
我们可以利用out参数，在过程和函数中实现返回多个值。

-- 通过存储函数实现  【计算指定员工的年薪 】
-- 存储过程和存储函数的参数都不能带长度
-- 存储函数的返回值类型不能带长度
create or replace function f_yearsal(eno emp.empno%type) return number
is
       s number(10);
begin
       select sal*12+nvl(comm,0) into s from emp where empno = eno;
       return s;
end;

-- 测试 f_yearsal
declare
   s number(10);
begin
   s := f_yearsal(7788);
   dbms_output.put_line(s);
end;

-- out类型参数如何使用
-- 使用存储过程来算年薪
create or replace procedure p_yearsal(eno emp.empno%type,yearsal out number)
is
    s number(10);
    c emp.comm%type;
begin
  select sal*12,nvl(comm,0) into s,c from emp where empno = eno;
  yearsal := s+c;
end;

-- 测试
declare
   yearsal number(10);
begin
  p_yearsal(7788,yearsal);
  dbms_output.put_line(yearsal);
end;

-- in和out类型参数的区别是什么？
-- 凡是涉及到into查询语句赋值或者:=赋值操作的参数都用out
-- in一般是用来传值，用来给内部使用。



-- 存储过程和存储函数的区别
-- 语法区别：关键字不一样，
-- 存储函数比存储过程多了两个return
-- 本质区别：存储函数有返回值，而存储过程没有返回值。
-- 如果存储过程想实现有返回值的业务，我们就必须使用out类型的参数。
-- 即便是存储过程使用了out类型的参数，起本质也不是真的有了返回值，
-- 而是在存储过程内部给out类型参数赋值，在执行完毕后，我们直接拿到输出类型参数的值。

----我们可以使用存储函数有返回值的特性，来自定义函数【单行函数，多行函数，聚合函数】。
----而存储过程不能用来自定义函数。

----案例需求：查询出员工姓名，员工所在部门名称。
----案例准备工作：把scott用户下的dept表复制到当前用户下。
create table dept as select * from scott.dept;

-- 使用传统方式来实现案例需求
select
e.ename,d.dname
from emp e,dept d
where e.deptno=d.deptno;

-- 使用存储函数来实现提供一个部门编号，输出一个部门名称。
create or replace function fdna(dno dept.deptno%type) return dept.dname%type
is
       dna dept.dname%type;
begin
  select dname into dna from dept where deptno = dno;
   return dna;
end;

-- 使用fdna存储函数来实现案例需求
-- 可以在查询条件用
select e.ename,fdna(e.deptno)
from emp e;


-- 触发器
-- 就是制定一个规则，在我们做增删改操作的时候，
-- 只要满足该规则，自动触发，无需调用。
-- 两类触发器：
-- 语句级触发器 不包含的for each row的就是语句触发起。
-- 行级触发器：包含有for each row的就是行级触发器。
加for each row是为了使用:old或者:new对象（一行记录）。

-- 表格
触发语句  :old                        :new
insert    所有字段为空            将要插入的数据
update    更新以前的行值            更新后的行值
delete    删除以前该行值            所有字段都是空


-- 插入一条记录，输出一个新员工入职
-- (before之前触发 after之后触发)
-- insert 触发语句
-- on 作用到哪里
create or replace trigger t1
after
insert
on person
declare

begin
  dbms_output.put_line('一个新员工入职');
end;

select * from person;

-- 触发t1
insert into person values(5,'周润发');
commit;

-- 行级别触发器
-- 不能给员工降薪
-- raise_application_error(-20001~-20999之间, '错误提示信息');
create or replace trigger t2
before
update
on
emp
for each row
declare

begin
  if :old.sal>:new.sal then
    raise_application_error(-20001,'不能给员工降薪');
  end if;
end;

-- 触发t2
update emp set sal = sal-1 where empno = 7788;


-- 触发器实现主键自增。（现实开发中常用）【行级触发器】
-- 分析：在用户做插入操作之前，闹到即将插入的数据，给该数据中的主键列赋值。

create or replace trigger auid
before
insert
on
person
for each row
declare

begin
 select s_person.nextval into :new.pid from dual;
end;

-- 查询person表数据
select * from person;

-- 使用auid实现主键自增
insert into person (pname) values('周杰伦');
commit;

-- 不会影响pid的值
insert into person (pid,pname) values(2,'周杰伦');
commit;


----oracle10g    ojdbc14.jar
----oracle11g    ojdbc6.jar
