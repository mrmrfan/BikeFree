/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     2019/5/10 18:29:59                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('bxjl') and o.name = 'FK_BXJL_BXCL_CL')
alter table bxjl
   drop constraint FK_BXJL_BXCL_CL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('bxjl') and o.name = 'FK_BXJL_BXYH_YH')
alter table bxjl
   drop constraint FK_BXJL_BXYH_YH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dd') and o.name = 'FK_DD_CZ_YH')
alter table dd
   drop constraint FK_DD_CZ_YH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('qxjl') and o.name = 'FK_QXJL_QXCL_CL')
alter table qxjl
   drop constraint FK_QXJL_QXCL_CL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('qxjl') and o.name = 'FK_QXJL_QXYH_YH')
alter table qxjl
   drop constraint FK_QXJL_QXYH_YH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('bxjl')
            and   name  = '报修车辆_FK'
            and   indid > 0
            and   indid < 255)
   drop index bxjl.报修车辆_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('bxjl')
            and   name  = '报修用户_FK'
            and   indid > 0
            and   indid < 255)
   drop index bxjl.报修用户_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('bxjl')
            and   type = 'U')
   drop table bxjl
go

if exists (select 1
            from  sysobjects
           where  id = object_id('cl')
            and   type = 'U')
   drop table cl
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dd')
            and   name  = '充值_FK'
            and   indid > 0
            and   indid < 255)
   drop index dd.充值_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dd')
            and   type = 'U')
   drop table dd
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('qxjl')
            and   name  = '骑行车辆_FK'
            and   indid > 0
            and   indid < 255)
   drop index qxjl.骑行车辆_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('qxjl')
            and   name  = '骑行用户_FK'
            and   indid > 0
            and   indid < 255)
   drop index qxjl.骑行用户_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('qxjl')
            and   type = 'U')
   drop table qxjl
go

if exists (select 1
            from  sysobjects
           where  id = object_id('yh')
            and   type = 'U')
   drop table yh
go

/*==============================================================*/
/* Table: bxjl                                                  */
/*==============================================================*/
create table bxjl (
   bxbh                 bigint               not null,
   cph                  bigint               null,
   yhm                  varchar(20)          null,
   nr                   text                 null,
   constraint PK_BXJL primary key nonclustered (bxbh)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '报修记录',
   'user', @CurrentUser, 'table', 'bxjl'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '报修编号',
   'user', @CurrentUser, 'table', 'bxjl', 'column', 'bxbh'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '车牌号',
   'user', @CurrentUser, 'table', 'bxjl', 'column', 'cph'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户名',
   'user', @CurrentUser, 'table', 'bxjl', 'column', 'yhm'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '内容',
   'user', @CurrentUser, 'table', 'bxjl', 'column', 'nr'
go

/*==============================================================*/
/* Index: 报修用户_FK                                               */
/*==============================================================*/
create index 报修用户_FK on bxjl (
yhm ASC
)
go

/*==============================================================*/
/* Index: 报修车辆_FK                                               */
/*==============================================================*/
create index 报修车辆_FK on bxjl (
cph ASC
)
go

/*==============================================================*/
/* Table: cl                                                    */
/*==============================================================*/
create table cl (
   cph                  bigint               not null,
   clwz                 varchar(40)          null,
   constraint PK_CL primary key nonclustered (cph)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '车辆',
   'user', @CurrentUser, 'table', 'cl'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '车牌号',
   'user', @CurrentUser, 'table', 'cl', 'column', 'cph'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '车辆位置',
   'user', @CurrentUser, 'table', 'cl', 'column', 'clwz'
go

/*==============================================================*/
/* Table: dd                                                    */
/*==============================================================*/
create table dd (
   ddbh                 bigint               not null,
   yhm                  varchar(20)          null,
   czje                 money                null,
   constraint PK_DD primary key nonclustered (ddbh)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '订单',
   'user', @CurrentUser, 'table', 'dd'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '订单编号',
   'user', @CurrentUser, 'table', 'dd', 'column', 'ddbh'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户名',
   'user', @CurrentUser, 'table', 'dd', 'column', 'yhm'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '充值金额',
   'user', @CurrentUser, 'table', 'dd', 'column', 'czje'
go

/*==============================================================*/
/* Index: 充值_FK                                                 */
/*==============================================================*/
create index 充值_FK on dd (
yhm ASC
)
go

/*==============================================================*/
/* Table: qxjl                                                  */
/*==============================================================*/
create table qxjl (
   qxbh                 bigint               not null,
   yhm                  varchar(20)          null,
   cph                  bigint               null,
   kssj                 datetime             null,
   jssj                 datetime             null,
   hf                   money                null,
   constraint PK_QXJL primary key nonclustered (qxbh)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '骑行记录',
   'user', @CurrentUser, 'table', 'qxjl'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '骑行编号',
   'user', @CurrentUser, 'table', 'qxjl', 'column', 'qxbh'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户名',
   'user', @CurrentUser, 'table', 'qxjl', 'column', 'yhm'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '车牌号',
   'user', @CurrentUser, 'table', 'qxjl', 'column', 'cph'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '开始时间',
   'user', @CurrentUser, 'table', 'qxjl', 'column', 'kssj'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '结束时间',
   'user', @CurrentUser, 'table', 'qxjl', 'column', 'jssj'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '花费',
   'user', @CurrentUser, 'table', 'qxjl', 'column', 'hf'
go

/*==============================================================*/
/* Index: 骑行用户_FK                                               */
/*==============================================================*/
create index 骑行用户_FK on qxjl (
yhm ASC
)
go

/*==============================================================*/
/* Index: 骑行车辆_FK                                               */
/*==============================================================*/
create index 骑行车辆_FK on qxjl (
cph ASC
)
go

/*==============================================================*/
/* Table: yh                                                    */
/*==============================================================*/
create table yh (
   yhm                  varchar(20)          not null,
   mm                   varchar(20)          null,
   xb                   char(2)              null,
   sjh                  char(11)             null,
   ye                   money                null,
   constraint PK_YH primary key nonclustered (yhm)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户',
   'user', @CurrentUser, 'table', 'yh'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户名',
   'user', @CurrentUser, 'table', 'yh', 'column', 'yhm'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '密码',
   'user', @CurrentUser, 'table', 'yh', 'column', 'mm'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '性别',
   'user', @CurrentUser, 'table', 'yh', 'column', 'xb'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '手机号',
   'user', @CurrentUser, 'table', 'yh', 'column', 'sjh'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '余额',
   'user', @CurrentUser, 'table', 'yh', 'column', 'ye'
go

alter table bxjl
   add constraint FK_BXJL_BXCL_CL foreign key (cph)
      references cl (cph)
go

alter table bxjl
   add constraint FK_BXJL_BXYH_YH foreign key (yhm)
      references yh (yhm)
go

alter table dd
   add constraint FK_DD_CZ_YH foreign key (yhm)
      references yh (yhm)
go

alter table qxjl
   add constraint FK_QXJL_QXCL_CL foreign key (cph)
      references cl (cph)
go

alter table qxjl
   add constraint FK_QXJL_QXYH_YH foreign key (yhm)
      references yh (yhm)
go

