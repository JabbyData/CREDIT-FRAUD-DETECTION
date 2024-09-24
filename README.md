Hello and Welcome on my cloud based Machine Learning project. I will present to you an overview on how to use cloud to scale machine learning projects.
My project deals with building a CREDIT CARD DEFAULT PREDICTOR using real world data. 

To be more precise, I will dive into the following steps of my work : 
1) Problem Definition
2) Data Collection
3) Data Cloud Storage
4) Model Training
5) Model Deployment


I will bring new features / improvements to this project in the upcoming weeks and I hope it will be useful. Feel free to contact me at antonin.datas@gmail.com for further information.

## 1) Problem Definition

In 2022, global online payment fraud losses reached US$41billion, an altering figure showing how much credit fault detection is a modern challenge to tackle to ensure safe business growth.
This project deals applying diverse machine learning techniques to build and train models on real world data. 
One of the main challenge of today's companies is to deal with huge amount of data, hence this project also focuses on using cloud technologies to manage efficiently these information.

## 2) Data Collection
To access **real world data** related to financial crimes, I decided to use a publicly available dataset from [Kaggle](https://www.kaggle.com/datasets/sgpjesus/bank-account-fraud-dataset-neurips-2022). 
My **criteria** for choosing a dataset on this platform are the following :

- The file is relatively large
- The data is recent
- Sources are listed and verified
- The platform indicates the level of usability of the provided dataset

To do so, I used the Kaggle Python API, you can find the detail of my search / local load of the data inside the notebook [1-Data_Extraction.py](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/1-Data_Extraction.py)

## 3) Data Cloud Storage
Instead of performing a local model building / training, I wanted to tranfer it to cloud services. [Snowflake](https://www.snowflake.com/fr/) is a superb cloud provider that helped me to do so.

First of all, I created the **data management environment** (roles + objects). Details are available in the SQL file "0-Setup.sql".

Then, I **loaded the data** on Snowflake using the Snowpark Python API (details available in the file [1-Data_Extraction.py](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/1-Data_Extraction.py)).

**Please insert your credentials in the "connection.json" file** to make it work.

### Security 
To ensure project roles / grants distribution, Snowflake offers a superb management system on which administrators can dispatch responsibilities efficiently. In that way, the file [0-Setup.sql](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/0-Setup.sql) describes how I sat up my cloud environment , creating a specific role to achieve the project tasks.
