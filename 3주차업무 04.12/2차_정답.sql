
--1-1)
select *
from td_trdealmaster a
inner join tc_truseritemauth b
on b.user_id = 'mro' and a.org_code = b.org_code and a.item_auth_grp = b.item_auth_grp
where a.org_code = '999999'
and   a.report_ymd = '20210115';

SELECT * 
FROM TD_TRDEALMASTER td, TC_TRUSERITEMAUTH tc
WHERE td.ORG_CODE = tc.ORG_CODE AND td.item_auth_grp = tc.item_auth_grp
AND tc.USER_ID ='mro'
AND tc.ORG_CODE = '999999'
AND td.REPORT_YMD = '20210115';


--1-2)
select *
from td_trdealmaster a
inner join tc_truseritemauth b
on b.user_id = 'mro' and a.org_code = b.org_code and a.item_auth_grp = b.item_auth_grp
where a.org_code = '999999'
and   a.report_ymd = '20210115'
and   nvl(a.db_job_type,'9') not in ('D', 'X')
and   a.tr_rpt_status is  null
;

SELECT * 
FROM TD_TRDEALMASTER td, TC_TRUSERITEMAUTH tc
WHERE td.ORG_CODE = tc.ORG_CODE
AND tc.USER_ID ='mro'
AND tc.ORG_CODE = '999999'
AND td.REPORT_YMD = '20210115'
AND td.DB_JOB_TYPE != 'D' AND td.DB_JOB_TYPE <> 'X'
AND td.TR_RPT_STATUS IS null;


1-3)
select a.org_code, a.report_ymd, a.tr_uti
from td_trdealmaster a
inner join tc_truseritemauth b
on b.user_id = 'mro' and a.org_code = b.org_code and a.item_auth_grp = b.item_auth_grp
where a.org_code = '999999'
and   a.report_ymd = '20210115'
and   nvl(a.db_job_type,'9') not in ('D', 'X')
and   a.tr_rpt_status is  null
group by a.org_code, a.report_ymd, a.tr_uti
having count(*) > 1
;

1-4)
select a.TR_UTI, a.ITEM_CODE, a.WRITE_SEQ, a.TR_ACTION_TYPE, a.ITEM_NAME
from td_trdealmaster a 
inner join (select a.org_code, a.report_ymd, a.tr_uti
from td_trdealmaster a
inner join tc_truseritemauth b
on b.user_id = 'mro' and a.org_code = b.org_code and a.item_auth_grp = b.item_auth_grp
where a.org_code = '999999'
and   a.report_ymd = '20210115'
and   nvl(a.db_job_type,'9') not in ('D', 'X')
and   a.tr_rpt_status is  null
group by a.org_code, a.report_ymd, a.tr_uti
having count(*) > 1) b on (a.org_code = b.org_code and a.report_ymd = b.report_ymd and a.tr_uti = b.tr_uti)
order by a.TR_UTI, a.WRITE_SEQ, a.UPDATE_DATE
;


