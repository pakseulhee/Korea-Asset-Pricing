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
  
2.  

 TD_TRDEALMASTER의 보고일자(REPORT_YMD): 20200925, 사무소코드 950000
 TD_TRFXFWD의 보고일자(REPORT_YMD): 20200925, 사무소코드 950000
 
 키값: ORG_CODE, REPORT_YMD, TR_UTI, TR_ACTION_TYPE
 
 2-1)위 두개 테이블에서 키는 일치하지만 ITEM_CODE가 다른 종목을 확인하는 쿼리를 작성하시오.
   보고일자: 20200925, 사무소코드 950000 기준

 2-2)위 두개 테이블에서 TD_TRDEALMASTER에만 있는 종목을 확인하는 쿼리를 작성하시오.(키 값 기준)
   보고일자: 20200925, 사무소코드 950000 기준
 
 2-3)위 두개 테이블에서 TD_TRFXFWD에만 있는 종목을 확인하는 쿼리를 작성하시오.(키 값 기준)
   보고일자: 20200925, 사무소코드 950000 기준
 


3.

 TD_TRDEALMASTER(매매정보)의   보고일자(REPORT_YMD): 20201116, 사무소코드 200150을 기준으로.
  매매정보의 TR_ACTION_TYPE = 'N' 
 TD_TRVALUATION(가치평가정보)의 보고일자(REPORT_YMD): 20201116, 사무소코드 200150을 기준으로.
  가치평가정보의 TR_ACTION_TYPE = 'N' 
  라는 조건하에.
 
 참조
 두 테이블의 키값: ORG_CODE, REPORT_YMD, TR_UTI, TR_ACTION_TYPE
 
 
 매매정보에는 있지만, 가치평가정보에서 누락된 데이터를 찾고 해당 TR_UTI를 찾는 쿼리를 작성 하시오.
 
 
 
 
 
 
 
  
  