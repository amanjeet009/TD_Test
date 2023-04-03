CREATE or replace VIEW "EXT"."CSA_DRAW_v01_SVW" ( "PAYMENT_TYPE", "RECOVERY_FLAG", "FULLNAME", "USERID", "PSTN_NAME", "PART_EMAIL", "PERIODNAME", "KPI_NAME", "ACTUAL_QUOTA", "TARGET_QUOTA", "INCENTIVE_VALUE", "BUSINESSUNIT", "COMPANY_CODE", "POSITION_GROUP_NAME", "TITLE_NAME", "SALES_ROLE", "ATB_YTD", "Target_Bonus_Curr", "ATB_MBO", "COST_CENTER", "ROLE_START_DATE", "ROLE_END_DATE", "MANAGER_USERID", "MANAGER_NAME", "Quarter", "INCENTIVE_NAME", "PersonneID", "Payout_Curve", "Fixed_Value", "% Achievement", "Dummy" ) AS 
SELECT DISTINCT inct.genericattribute1 AS payment_type,
			     (CASE
                      WHEN inct.genericboolean2 = 1 THEN 'Yes'
                      WHEN inct.genericboolean2 = 0 THEN 'No'
                  END) AS recovery_flag,
                  trim(part.firstname || ' ' || part.lastname) AS FULLNAME,
                  part.userid AS userid,
                  capd.positionname AS pstn_name,
                  part.participantemail AS part_email,
                  perd.name AS periodname,
                  inct.genericattribute2  AS kpi_name, --OBJECTIVE
                  '0' AS actual_quota,
                  '0' AS target_quota,
                  mes.value AS incentive_value,
                  bunt.name AS businessunit,
                  to_integer(pstn.genericnumber3) AS company_code,
                  psgp.name AS position_group_name,
                  titl.name AS title_name,
                  pstn.genericattribute1 AS sales_role,
                  pstn.genericattribute8 AS atb_ytd,
                  pstn.genericattribute7 AS target_bonus_curr,
                  pstn.genericattribute9 AS atb_mbo,
                  pstn.genericnumber2 AS cost_center,
                  to_char(pstn.genericdate1, 'MM-DD-YYYY') AS role_start_date,
                  to_char(pstn.genericdate2,'MM-DD-YYYY') AS role_end_date,
                  (SELECT part01.userid
                     FROM tcmp.cs_participant part01
                    WHERE part01.payeeseq = capd.managerparticipantseq
                      AND part01.removedate = to_date('01/01/2200','dd/mm/yyyy')
                      AND part01.islast = 1) AS manager_userid,
                  (SELECT part01.firstname || ' ' || part01.lastname
                     FROM tcmp.cs_participant part01
                    WHERE part01.payeeseq = capd.managerparticipantseq
                      AND part01.removedate = to_date('01/01/2200','dd/mm/yyyy')
                      AND part01.islast = 1) AS manager_name,
                  (CASE
                      WHEN to_char(perd.startdate, 'mon') IN ('jan', 'feb', 'mar') THEN 'Q1'
                      WHEN to_char(perd.startdate, 'mon') IN ('apr', 'may', 'jun') THEN 'Q2'
                      WHEN to_char(perd.startdate, 'mon') IN ('jul', 'aug', 'sep') THEN 'Q3'
                      WHEN to_char(perd.startdate, 'mon') IN ('oct', 'nov', 'dec') THEN 'Q4'
                  END) || '' || (substring(perd.name, length(perd.name) - 4, 5)) AS quarter,
                  inct.name AS incentive_name,
                  to_integer(pstn.genericnumber5) AS personneid,
                  pstn.genericnumber4 AS payout_curve,
                  INCT.VALUE AS Fixed_Value,
                  case
                	when inct.UNITTYPEFORGENERICNUMBER3 = 1970324836974598 --unit type seq for percent
                	then concat(to_char(inct.genericnumber3 * 100),' %')
                 else 
                	null
                  end as "% Achievement",
                  1 as Dummy

    FROM cs_incentive inct
         INNER JOIN cs_period perd ON perd.periodseq = inct.periodseq
         INNER JOIN cs_participant part ON part.payeeseq = inct.payeeseq 
         INNER JOIN cs_measurement mes
             ON inct.payeeseq = mes.payeeseq
        	 AND inct.positionseq = mes.positionseq
             AND inct.periodseq = mes.periodseq
         INNER JOIN tcmp.csa_padimension capd
             ON inct.periodseq = capd.periodseq
             AND inct.positionseq = capd.positionseq
             AND inct.payeeseq = capd.participantseq
         INNER JOIN cs_businessunit bunt ON capd.businessunitmap = bunt.mask
         INNER JOIN cs_position pstn ON part.payeeseq = pstn.payeeseq AND pstn.ruleelementownerseq = capd.positionseq
         INNER JOIN cs_positiongroup psgp ON pstn.positiongroupseq = psgp.positiongroupseq
         INNER JOIN cs_title titl ON titl.ruleelementownerseq = pstn.titleseq
   WHERE inct.genericattribute1 IN ('Draw')
   and mes.name like '%Draw%'
		-- and inct.value > 0 
        AND perd.removedate = to_date('01/01/2200','dd/mm/yyyy')
    	AND part.islast = 1
        AND part.removedate = to_date('01/01/2200','dd/mm/yyyy')
        AND psgp.removedate = to_date('01/01/2200','dd/mm/yyyy')
        AND pstn.removedate = to_date('01/01/2200','dd/mm/yyyy')
        AND pstn.islast = 1
        AND titl.islast = 1
		AND titl.removedate = to_date('01/01/2200','dd/mm/yyyy') 
