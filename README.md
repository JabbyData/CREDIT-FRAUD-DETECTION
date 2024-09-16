Hello and Welcome on my cloud based Machine Learning project. I will present to you my work in depth so that you can have an overview on how to use cloud for your future machine learning projects.
My project deals with building a CREDIT CARD DEFAULT PREDICTOR using real world data. 

To be more precise, I will dive into the following steps of my work : 
1) Problem Definition
2) Data Collection
3) Data Cloud Storage
4) Model Training
5) Model Deployment

I hope this project will be useful, feel free to contact me at antonin.data@gmail.com for further information.

## 1) Problem Definition

- Store data locally -> cloud 
- Perform local analysis -> cloud

## 2) Data Collection
To access real world data related to financial crimes, I decided to use a publicly available dataset from [Kaggle](https://www.kaggle.com/datasets/sgpjesus/bank-account-fraud-dataset-neurips-2022). 
My criterias for choosing a dataset on this platform are the following :

- The file is relatively large
- The data is recent
- Sources are listed and verified
- The platform indicates the level of usability of the provided dataset

To do so, I used the Kaggle Python API, you can find the detail of my search / local load of the data inside the notebook "1.kaggle_connection.ipynb"

## 3) Data Cloud Storage
Instead of performing a local model building / training, I wanted to tranfer it to cloud services. [Snowflake](https://www.snowflake.com/fr/) is a superb cloud provider that helped me to do so.

First of all, I created the **data management environment** (roles + objects). Details are available in the SQL file "0-Setup.sql".

Then, I **loaded the data** on Snowflake using the Snowpark Python API (details available in the file "2-Data_ingestion.ipynb").

**Please insert your credentials in the "connection.json" file** to make it work.
