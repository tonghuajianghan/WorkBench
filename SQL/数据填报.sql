--法人资质
--数据变更从这个表中获取数据
SELECT * FROM CORP_LICENSE WHERE ROWNUM <= '100'
SELECT LICENSE_TYPE FROM CORP_LICENSE WHERE ROWNUM <= '100'
SELECT license_data FROM CORP_LICENSE WHERE ROWNUM < '100'

--法人资质暂存表
--新增的数据存入到这个表中
SELECT * FROM CORP_LICENSE_MANUAL WHERE ROWNUM <= '100'
SELECT STATUS FROM CORP_LICENSE_MANUAL WHERE ROWNUM <= '100' OR STATUS = '5'

SELECT STATUS FROM CORP_LICENSE_MANUAL WHERE STATUS = '1'