-- =====================================================
-- TELCO CUSTOMER CHURN ANALYSIS
-- SQL ANALYSIS USING GOOGLE BIGQUERY
-- =====================================================

-- QUERY 01: CHECK THE DATA 

SELECT *
FROM `churn-project-510010.telco_churn.Customer_churn`
LIMIT 10;

-- QUERY 02: CHECK TOTAL CUSTOMERS

SELECT COUNT(*) AS total_customers
FROM `churn-project-510010.telco_churn.Customer_churn`;

--QUERY 03: CHECK DUPLICATES

SELECT
  customerID,
  COUNT(*) AS customer_count
FROM `churn-project-510010.telco_churn.Customer_churn`
GROUP BY customerID
HAVING COUNT(*) > 1;

--QUERY 04: CHECK MISSING VALUES

SELECT
  COUNTIF(customerID IS NULL) AS missing_customer_id,
  COUNTIF(gender IS NULL) AS missing_gender,
  COUNTIF(tenure IS NULL) AS missing_tenure,
  COUNTIF(MonthlyCharges IS NULL) AS missing_monthly_charges,
  COUNTIF(TotalCharges IS NULL) AS missing_total_charges,
  COUNTIF(Churn IS NULL) AS missing_churn
FROM `churn-project-510010.telco_churn.Customer_churn`;

--QUERY 05: COUNT OF BLANK TOTAL CHARGES

SELECT
  COUNTIF(TRIM(TotalCharges) = '') AS blank_total_charges
FROM `churn-project-510010.telco_churn.Customer_churn`;

--QUERY 06: VIEW OF BLANK TOTAL CHARGES

SELECT
  customerID,
  tenure,
  MonthlyCharges,
  TotalCharges
FROM `churn-project-510010.telco_churn.Customer_churn`
WHERE TRIM(TotalCharges) = '';

--QUERY 07: COUNT OF CUSTOMERS BU CHURN

SELECT
  customerID,
  tenure,
  MonthlyCharges,
  TotalCharges
FROM `churn-project-510010.telco_churn.Customer_churn`
WHERE TRIM(CAST(TotalCharges AS STRING)) = ''; 

--QUERY 08: CHECK GENDER

SELECT
  Gender,
  COUNT(*) AS customer_count
FROM `churn-project-510010.telco_churn.Customer_churn`
GROUP BY Gender
ORDER BY customer_count DESC;


--QUERY 09: CHECK SENIOR CITIZEN

SELECT
  SeniorCitizen,
  COUNT(*) AS customer_count
FROM `churn-project-510010.telco_churn.Customer_churn`
GROUP BY SeniorCitizen
ORDER BY SeniorCitizen;

--QUERY 10: CHECK TENURE

SELECT
  MIN(Tenure) AS min_tenure,
  MAX(Tenure) AS max_tenure,
  ROUND(AVG(Tenure), 2) AS avg_tenure
FROM `churn-project-510010.telco_churn.Customer_churn`;

--QUERY 11: CHECK MONTHLY CHARGES

SELECT
  MIN(MonthlyCharges) AS min_monthly_charges,
  MAX(MonthlyCharges) AS max_monthly_charges,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM `churn-project-510010.telco_churn.Customer_churn`;

--QUERY 12: CONTRACT VS CHURN

SELECT
  Contract,
  Churn,
  COUNT(*) AS customer_count
FROM `churn-project-510010.telco_churn.Customer_churn`
GROUP BY Contract, Churn
ORDER BY Contract, Churn;

--QUERY 13: CONTRACT CHURN RATE

SELECT
  Contract,
  COUNTIF(Churn = TRUE) AS churned_customers,
  COUNT(*) AS total_customers,
  ROUND(COUNTIF(Churn = TRUE) * 100.0 / COUNT(*), 2) AS churn_rate
FROM `churn-project-510010.telco_churn.Customer_churn`
GROUP BY Contract
ORDER BY churn_rate DESC;


--QUERY 14: TENURE VS CHURN

SELECT
  CASE
    WHEN tenure <= 12 THEN '0-12 months'
    WHEN tenure <= 24 THEN '13-24 months'
    WHEN tenure <= 48 THEN '25-48 months'
    ELSE '49-72 months'
  END AS tenure_group,

  Churn,

  COUNT(*) AS customer_count

FROM `churn-project-510010.telco_churn.Customer_churn`

GROUP BY tenure_group, Churn
ORDER BY tenure_group, Churn;

--QUERY 15: TENURE CHURN RATE

SELECT
  CASE
    WHEN tenure <= 12 THEN '0-12 months'
    WHEN tenure <= 24 THEN '13-24 months'
    WHEN tenure <= 48 THEN '25-48 months'
    ELSE '49-72 months'
  END AS tenure_group,

  COUNT(*) AS total_customers,

  SUM(
    CASE
      WHEN Churn = TRUE THEN 1
      ELSE 0
    END
  ) AS churned_customers,

  ROUND(
    SUM(
      CASE
        WHEN Churn = TRUE THEN 1
        ELSE 0
      END
    ) * 100.0 / COUNT(*),
    2
  ) AS churn_rate

FROM `churn-project-510010.telco_churn.Customer_churn`

GROUP BY tenure_group
ORDER BY churn_rate DESC; 


--QUERY 16: MONTHLY CHARGES VS CHURN

SELECT
  Churn,
  COUNT(*) AS customer_count,
  ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charges

FROM `churn-project-510010.telco_churn.Customer_churn`

GROUP BY Churn
ORDER BY Churn;


--QUERY 17: CHARGE GROUP VS CHURN

SELECT
  CASE
    WHEN MonthlyCharges <= 40 THEN 'Low'
    WHEN MonthlyCharges <= 70 THEN 'Medium'
    ELSE 'High'
  END AS charge_group,

  Churn,

  COUNT(*) AS customer_count

FROM `churn-project-510010.telco_churn.Customer_churn`

GROUP BY charge_group, Churn
ORDER BY charge_group, Churn;


--QUERY 18: CHARGE GROUP CHURN RATE

SELECT
  CASE
    WHEN MonthlyCharges <= 40 THEN 'Low'
    WHEN MonthlyCharges <= 70 THEN 'Medium'
    ELSE 'High'
  END AS charge_group,

  COUNT(*) AS total_customers,

  SUM(
    CASE
      WHEN Churn = TRUE THEN 1
      ELSE 0
    END
  ) AS churned_customers,

  ROUND(
    SUM(
      CASE
        WHEN Churn = TRUE THEN 1
        ELSE 0
      END
    ) * 100.0 / COUNT(*),
    2
  ) AS churn_rate

FROM `churn-project-510010.telco_churn.Customer_churn`

GROUP BY charge_group
ORDER BY churn_rate DESC;













