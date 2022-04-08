DROP TABLE IF EXISTS ods_lhs_xhs_mappping;
CREATE TABLE ods_lhs_xhs_mappping AS SELECT
t1.`ADM层表名`,
t1.`ADM层字段名`,
t1.`ADM层上级表名` AS LHS_table,
t1.`ADM层上级字段` AS LHS_item,
t3.`ADM层赋值` AS XHS_assignment,
t3.`ADM层备注1` AS XHS_comments,
t3.`ADM层上级表名` AS XHS_table,
t3.`ADM层上级字段` AS XHS_item 
FROM
	(
	SELECT DISTINCT
		t.`ADM层表名`,
		t.`ADM层字段名`,
		t.`ADM层上级表名`,
		t.`ADM层上级字段` 
	FROM
		`sp_adm_联合贷款` t 
	WHERE
		t.`ADM层上级表名` REGEXP 'LHDK' 
	ORDER BY
		t.`ADM层表名`,
		t.`ADM层字段名`,
		t.`ADM层上级字段` 
	) t1
	LEFT JOIN (
	SELECT
		t2.`ADM层表名`,
		t2.`ADM层字段名`,
		t2.`ADM层赋值`,
		t2.`ADM层上级表名`,
		t2.`ADM层上级字段`,
		t2.`ADM层备注1` 
	FROM
		`sp_adm_联合贷款` T2 
	WHERE
		T2.`渠道标示` REGEXP 'XHS' 
	ORDER BY
		t2.`ADM层表名`,
		t2.`ADM层字段名`,
		t2.`ADM层上级字段` 
	) t3 ON t1.`ADM层表名` = t3.`ADM层表名` 
	AND t1.`ADM层字段名` = t3.`ADM层字段名`;
DELETE 
FROM
	ods_lhs_xhs_mappping 
WHERE
	ADM层表名 = 'ADM.LHDK_RECEIPT_TBL_HIST' 
	AND ADM层字段名 = 'RECEIPT_AMT';
INSERT INTO ods_lhs_xhs_mappping
VALUES
	( 'ADM.LHDK_RECEIPT_TBL_HIST', 'RECEIPT_AMT', 'ODS.XX_LHDK_RECEIPT_TBL', 'FEE_RECEIPT_AMT', NULL, NULL, 'ODS.XX_ACC_REPAYMENT_DETAIL', 'OWNER_REPAY_FEE_AMT' ),
	( 'ADM.LHDK_RECEIPT_TBL_HIST', 'RECEIPT_AMT', 'ODS.XX_LHDK_RECEIPT_TBL', 'INT_RECEIPT_AMT', NULL, NULL, 'ODS.XX_ACC_REPAYMENT_DETAIL', 'OWNER_REPAY_INT_AMT' ),
	( 'ADM.LHDK_RECEIPT_TBL_HIST', 'RECEIPT_AMT', 'ODS.XX_LHDK_RECEIPT_TBL', 'PRI_RECEIPT_AMT', NULL, NULL, 'ODS.XX_ACC_REPAYMENT_DETAIL', 'OWNER_REPAY_PRIN_AMT' ),
	( 'ADM.LHDK_RECEIPT_TBL_HIST', 'RECEIPT_AMT', 'ODS.XX_LHDK_RECEIPT_TBL', 'ODI_RECEIPT_AMT', NULL, NULL, 'ODS.XX_ACC_REPAYMENT_DETAIL', 'OWNER_REPAY_CMPD_AMT' ),
	( 'ADM.LHDK_RECEIPT_TBL_HIST', 'RECEIPT_AMT', 'ODS.XX_LHDK_RECEIPT_TBL', 'ODP_RECEIPT_AMT', NULL, NULL, 'ODS.XX_ACC_REPAYMENT_DETAIL', 'OWNER_REPAY_PNLT_AMT' );