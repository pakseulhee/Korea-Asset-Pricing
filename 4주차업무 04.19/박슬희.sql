1. 

 view name
 -- 혜원: hw_vw
 -- 슬희: sh_vw
 -- 야라: yl_vw
 -- 성경: sk_vw
 
 tc_truseritemauth, tc_cmorginfo, tc_cmcodevalue
  위 세개 테이블을 이용하여 view를 생성하시오.  
  
  tc_truseritemauth, tc_cmorginfo   --> org_code 기준으로 조인
  tc_truseritemauth, tc_cmcodevalue --> tc_truseritemauth.item_auth_grp, tc_cmcodevalue.code_id 기준으로 조인
  
  단. tc_cmcodevalue의 하단 컬럼은 고정 값으로 셋팅하여 select 
   tc_cmcodevalue.biz_grp = 'TR'
   tc_cmcodevalue.org_code = '000000'
   tc_cmcodevalue.col_id = 'ITEM_AUTH_GRP'
  
  
  
  view select 항목은 org_name, user_id, item_auth_grp, code_name, org_code
  
  1번) 참조
  
--1번 정답
CREATE VIEW sh_vw(org_name, user_id, item_auth_grp, code_name, org_code)
	AS SELECT b.org_name, a.USER_ID, a.item_auth_grp, c.code_name, a.ORG_CODE 
		FROM tc_truseritemauth a INNER JOIN tc_cmorginfo b 
			ON a.org_code = b.org_code INNER JOIN (
				SELECT *
				FROM tc_cmcodevalue
				WHERE biz_grp = 'TR'
				 AND org_code = '000000'
				 AND col_id = 'ITEM_AUTH_GRP') c 
			ON a.item_auth_grp = c.code_id;

2.  

 TD_TRDEALMASTER의 보고일자(REPORT_YMD): 20200925, 사무소코드 950000
 TD_TRFXFWD의 보고일자(REPORT_YMD): 20200925, 사무소코드 950000
 
 키값: ORG_CODE, REPORT_YMD, TR_UTI, TR_ACTION_TYPE
 
 2-1)위 두개 테이블에서 키는 일치하지만 ITEM_CODE가 다른 종목을 확인하는 쿼리를 작성하시오.
   보고일자: 20200925, 사무소코드 950000 기준
   
 --2-1정답
SELECT a.TR_UTI 
FROM TD_TRDEALMASTER a, TD_TRFXFWD b
WHERE a.ORG_CODE = b.ORG_CODE AND a.REPORT_YMD = b.REPORT_YMD 
	AND a.TR_UTI = b.TR_UTI AND a.TR_ACTION_TYPE = b.TR_ACTION_TYPE
	AND a.ITEM_CODE != b.ITEM_CODE
	AND a.REPORT_YMD = '20200925'
	AND a.ORG_CODE = '950000';


 2-2)위 두개 테이블에서 TD_TRDEALMASTER에만 있는 종목을 확인하는 쿼리를 작성하시오.(키 값 기준)
   보고일자: 20200925, 사무소코드 950000 기준
   
--2-2정답
SELECT a.TR_UTI 
FROM TD_TRDEALMASTER a LEFT OUTER join TD_TRFXFWD b
	on a.ORG_CODE = b.ORG_CODE AND a.REPORT_YMD = b.REPORT_YMD 
	AND a.TR_UTI = b.TR_UTI AND a.TR_ACTION_TYPE = b.TR_ACTION_TYPE
where b.ORG_CODE IS NULL AND b.REPORT_YMD IS NULL 
	AND b.TR_UTI IS NULL AND b.TR_ACTION_TYPE IS NULL
	AND a.REPORT_YMD = '20200925'
	AND a.ORG_CODE = '950000';

 2-3)위 두개 테이블에서 TD_TRFXFWD에만 있는 종목을 확인하는 쿼리를 작성하시오.(키 값 기준)
   보고일자: 20200925, 사무소코드 950000 기준
   
--2-3정답
SELECT a.TR_UTI 
FROM TD_TRFXFWD a LEFT OUTER join TD_TRDEALMASTER b
	on a.ORG_CODE = b.ORG_CODE AND a.REPORT_YMD = b.REPORT_YMD 
	AND a.TR_UTI = b.TR_UTI AND a.TR_ACTION_TYPE = b.TR_ACTION_TYPE
where b.ORG_CODE IS NULL AND b.REPORT_YMD IS NULL 
	AND b.TR_UTI IS NULL AND b.TR_ACTION_TYPE IS NULL
	AND a.REPORT_YMD = '20200925'
	AND a.ORG_CODE = '950000';


3.

 TD_TRDEALMASTER(매매정보)의   보고일자(REPORT_YMD): 20201116, 사무소코드 200150을 기준으로.
  매매정보의 TR_ACTION_TYPE = 'N' 
 TD_TRVALUATION(가치평가정보)의 보고일자(REPORT_YMD): 20201116, 사무소코드 200150을 기준으로.
  가치평가정보의 TR_ACTION_TYPE = 'N' 
  라는 조건하에.
 
 참조
 두 테이블의 키값: ORG_CODE, REPORT_YMD, TR_UTI, TR_ACTION_TYPE
 
 
 매매정보에는 있지만, 가치평가정보에서 누락된 데이터를 찾고 해당 TR_UTI를 찾는 쿼리를 작성 하시오.
 
--3번 정답
SELECT a.TR_UTI, a.ASSET_INST_TYPE
FROM TD_TRDEALMASTER a  LEFT OUTER JOIN TD_TRVALUATION b
	on a.ORG_CODE = b.ORG_CODE AND a.REPORT_YMD = b.REPORT_YMD 
	AND a.TR_UTI = b.TR_UTI AND a.TR_ACTION_TYPE = b.TR_ACTION_TYPE 
WHERE a.REPORT_YMD = '20201116' 
	AND a.ORG_CODE = '200150'
	AND a.TR_ACTION_TYPE = 'N'
	AND b.ORG_CODE IS NULL AND b.REPORT_YMD IS NULL 
	AND b.TR_UTI IS NULL AND b.TR_ACTION_TYPE IS NULL;
 
 
 
 
 
 
 
  
  