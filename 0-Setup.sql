USE ROLE ACCOUNTADMIN;

-- Creation of the database
USE ROLE SYSADMIN;
CREATE WAREHOUSE IF NOT EXISTS FRAUD_DETECT_WH;
CREATE DATABASE IF NOT EXISTS FRAUD_DETECT_DB;
CREATE SCHEMA IF NOT EXISTS FRAUD_DETECT_SM;

USE SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM;

-- Role Creation to manipulate the database
USE ROLE USERADMIN;
CREATE ROLE IF NOT EXISTS DEV_FRAUD_DETECTOR;

USE ROLE SECURITYADMIN;
GRANT USAGE ON DATABASE FRAUD_DETECT_DB TO ROLE DEV_FRAUD_DETECTOR;
GRANT USAGE ON SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM TO ROLE DEV_FRAUD_DETECTOR;
GRANT MODIFY ON SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM TO ROLE DEV_FRAUD_DETECTOR;
GRANT CREATE FILE FORMAT ON SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM TO ROLE DEV_FRAUD_DETECTOR;
GRANT USAGE ON FILE FORMAT FRAUD_DETECT_DB.FRAUD_DETECT_SM.CSVFORMAT TO ROLE DEV_FRAUD_DETECTOR;
GRANT CREATE STAGE ON SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM TO ROLE DEV_FRAUD_DETECTOR;
GRANT USAGE ON STAGE FRAUD_DETECT_DB.FRAUD_DETECT_SM.INTERNAL_FRAUD_STG TO ROLE DEV_FRAUD_DETECTOR;
GRANT READ ON STAGE FRAUD_DETECT_DB.FRAUD_DETECT_SM.INTERNAL_FRAUD_STG TO ROLE DEV_FRAUD_DETECTOR;
GRANT WRITE ON STAGE FRAUD_DETECT_DB.FRAUD_DETECT_SM.INTERNAL_FRAUD_STG TO ROLE DEV_FRAUD_DETECTOR;
GRANT USAGE ON WAREHOUSE FRAUD_DETECT_WH TO ROLE DEV_FRAUD_DETECTOR;
GRANT MODIFY ON DATABASE FRAUD_DETECT_DB TO ROLE DEV_FRAUD_DETECTOR;
GRANT OWNERSHIP ON TABLE FRAUD_DETECT_DB.FRAUD_DETECT_SM.FRAUD_DATA TO ROLE DEV_FRAUD_DETECTOR REVOKE CURRENT GRANTS;
GRANT OWNERSHIP ON SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM TO ROLE DEV_FRAUD_DETECTOR REVOKE CURRENT GRANTS;
show grants to role dev_fraud_detector;

-- Assigning the role to an user
GRANT ROLE DEV_FRAUD_DETECTOR TO USER JABBYDATAS;

USE ROLE DEV_FRAUD_DETECTOR;

CREATE file format csvformat
    skip_header = 1
    type = CSV;

CREATE STAGE IF NOT EXISTS INTERNAL_FRAUD_STG
    DIRECTORY = (ENABLE = TRUE)
    FILE_FORMAT = csvformat;

-- Creation of tables to store data
CREATE TABLE IF NOT EXISTS FRAUD_DATA(
    FRAUD_BOOL SMALLINT,
    INCOME NUMBER(30),
    NAME_EMAIL_SIMILARITY NUMBER(30),
    PREV_ADRESS_MONTH_COUNT INT,
    CURRENT_ADRESS_MONTH_COUNT INT,
    CUSTOMER_AGE INT,
    DAYS_SINCE_REQUEST NUMBER(30),
    INTENDED_BALCON_AMOUNT NUMBER(30),
    PAYMENT_TYPE VARCHAR(250),
    ZIP_COUNT_4W INT,
    VELOCITY_6H NUMBER(30),
    VELOCITY_24H NUMBER(30),
    VELOCITY_4W NUMBER(30),
    BANK_BRANCH_COUNT_8W INT,
    DATE_OF_BIRTH_DISTINCT_EMAILS_4W INT,
    EMPLOYMENT_STATUS VARCHAR(250),
    CREDIT_RISK_SCORE INT,
    EMAIL_IS_FREE INT,
    HOUSING_STATUS VARCHAR(250),
    PHONE_HOME_VALID INT,
    PHONE_MOBILE_VALID INT,
    BANK_MONTHS_COUNT INT,
    HAS_OTHER_CARDS INT,
    PROPOSED_CREDIT_LIMIT NUMBER(30),
    FOREIGN_REQUEST INT,
    SOURCE VARCHAR(250),
    SESSION_LENGTH_IN_MINUTES NUMBER(30),
    DEVICE_OS VARCHAR(250),
    KEEP_ALIVE_SESSION INT,
    DEVICE_DISTINCT_EMAILS_8W INT,
    DEVICE_FRAUD_COUNT INT,
    MONTH SMALLINT
);

-- Config to manip the data
USE ROLE DEV_FRAUD_DETECTOR;
USE SCHEMA FRAUD_DETECT_DB.FRAUD_DETECT_SM;
USE WAREHOUSE FRAUD_DETECT_WH;