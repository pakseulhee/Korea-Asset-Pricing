  
  * 참조 정보
  TD_TRDEALMASTER: 매매관리테이블
   ORG_CODE: 사무소코드(Key)
   REPORT_YMD: 보고일자(Key)
   TR_UTI: UTI(Key)
   TR_ACTION_TYPE: 입력유형(Key)
   ITEM_AUTH_GRP: 권한그룹
   ITEM_CODE: 종목코드
   ITEM_NAME: 종목명
   WRITE_SEQ: 보고순번
   TR_RPT_STATUS: 보고상태
   DB_JOB_TYPE: DB입력유형
   UPDATE_DATE: 최종입력시간
   
  TC_TRUSERITEMAUTH: 사용자 권한 테이블
   USER_ID: 사용자ID(Key)
   ORG_CODE: 사무소코드(Key)
   ITEM_AUTH_GRP: 권한그룹(Key)
  
  1-1) 위 두개 테이블을 이용(Inner 또는 Equ 조인)하여 사용자가 'mro'이고 
       사무소코드가 '999999' 이며 보고일자가 2021년1월15일인 거래를 추출하는 쿼리를 작성 하세요
	   - 권한그룹은 mro 사용자에게 부여된 권한만 매매관리 테이블에서 조회가 되어야 함.
	   
	SELECT * 
	FROM TD_TRDEALMASTER td, TC_TRUSERITEMAUTH tc
	WHERE td.ORG_CODE = tc.ORG_CODE
	AND tc.USER_ID ='mro'
	AND tc.ORG_CODE = '999999'
	AND td.REPORT_YMD = '20210115';

	   
  1-2) 1-1)쿼리를 바탕으로 DB입력유형이 D,X가 아니고, 보고상태가 널값인(NULL)인 데이터만 추출하는 쿼리를 작성 하세요
	SELECT * 
	FROM TD_TRDEALMASTER td, TC_TRUSERITEMAUTH tc
	WHERE td.ORG_CODE = tc.ORG_CODE
	AND tc.USER_ID ='mro'
	AND tc.ORG_CODE = '999999'
	AND td.REPORT_YMD = '20210115'
	AND td.DB_JOB_TYPE NOT IN ('D', 'X')
	AND td.TR_RPT_STATUS IS null;

  1-3) 1-2)쿼리를 바탕으로 사무소코드가 '999999' 이며 보고일자가 2021년1월15일이고 동일한 TR_UTI를 가진 레코드가 1건 이상인 데이터를 추출하는 쿼리를 작성하시오
      * 엑셀샘플1	
	SELECT * 
	FROM TD_TRDEALMASTER td, TC_TRUSERITEMAUTH tc
	WHERE td.ORG_CODE = tc.ORG_CODE
	AND tc.USER_ID ='mro'
	AND tc.ORG_CODE = '999999'
	AND td.REPORT_YMD = '20210115'
	AND td.DB_JOB_TYPE NOT IN ('D', 'X')
	AND td.TR_RPT_STATUS IS null
	GROUP BY td.TR_UTI;
	HAVING count(td.TR_UTI) >= 1;
	 
  
  1-4) 1-3)쿼리를 바탕으로 매매관리 테이블을 이용(Inner 또는 Equ조인)하여 TR_UTI, ITEM_CODE, WRITE_SEQ, TR_ACTION_TYPE, ITEM_NAME을 추출하는 쿼리를 작성 하세요.
      * 엑셀샘플2
	  순서는 TR_UTI, WRITE_SEQ, UPDATE_DATE 기준 오름차순으로 정렬하여 보여주시오
	SELECT td.TR_UTI, td.ITEM_CODE, td.WRITE_SEQ, td.TR_ACTION_TYPE, td.ITEM_NAME
	FROM TD_TRDEALMASTER td, (
		SELECT * 
		FROM TD_TRDEALMASTER td, TC_TRUSERITEMAUTH tc
		WHERE td.ORG_CODE = tc.ORG_CODE
		AND tc.USER_ID ='mro'
		AND tc.ORG_CODE = '999999'
		AND td.REPORT_YMD = '20210115'
		AND td.DB_JOB_TYPE NOT IN ('D', 'X')
		AND td.TR_RPT_STATUS IS NULL
		GROUP BY td.TR_UTI
		HAVING count(td.tr_uti) >= 1
	) B
	WHERE td.ORG_CODE = B.ORG_CODE;
  
  
  * 참조 정보
  이혜원: a_fxfwd
  박슬희: b_fxfwd
  민야라: c_fxfwd
  위성경: d_fxfwd
  김성민: e_fxfwd
  
  x_fxfwd
   ORG_CODE: 사무소코드(Key)
   REPORT_YMD: 보고일자(Key)
   TR_UTI: UTI(Key)
   TR_ACTION_TYPE: 입력유형(Key)  
  
  2) 각 담당테이블에서 사무소코드가 '999999' 이고 보고일자가 2020년6월30일 데이터를 지우는 쿼리를 작성하세요
  
   - 실행후 Commit 또는 Rollback 할것.
	DELETE 
	FROM b_fxfwd
	WHERE ORG_CODE ='999999'
	AND REPORT_YMD = '20200630';
  
  3) 각 담당테이블에서 사무소코드가 '999999' 이고 보고일자가 2020년9월2이며 TR_UTI가 988400VSHVYY7UQYOW04FWD2007024000241KRWEUR20210709TR
     인 종목의 TR_ACTION_TYPE을 'D'로 업데이트 하는 쿼리를 작성 하세요
	 
	 - 실행후 Commit 또는 Rollback 할것.
	UPDATE b_fxfwd
	SET TR_ACTION_TYPE = 'D'
	WHERE ORG_CODE ='999999'
	AND REPORT_YMD = '20200902'
	AND TR_UTI = '988400VSHVYY7UQYOW04FWD2007024000241KRWEUR20210709TR';
	 
   
  
 
  
