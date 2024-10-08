Hello and Welcome on my cloud based Machine Learning project. I will present to you an overview on how to use cloud to scale machine learning projects.
My project deals with building a CREDIT CARD DEFAULT PREDICTOR using real world data. 

To be more precise, I will dive into the following steps of my work : 
1) Problem Definition
2) Data Collection
3) Data Cloud Storage
4) Model Building
5) Model Deployment


I will bring new features / improvements to this project in the upcoming weeks and I hope it will be useful. Feel free to contact me at antonin.datas@gmail.com for further information.

## 1) Problem Definition

In 2022, global online payment fraud losses reached US$41billion, an altering figure showing how much credit fault detection is a modern challenge to tackle to ensure safe business growth.
This project deals applying diverse machine learning techniques to build and train models on real world data. 
One of the main challenge of today's companies is to deal with huge amount of data, hence this project also focuses on using cloud technologies to manage efficiently these information.

I am focusing in particular on two business metrics : 
    - **accuracy**, which measure how well the model performs in average on the dataset.
    - **precision**, which measures at which level model's predictions turn out to be well classified.
    - **recall**, which measures how well the model encompasses correct classifications.
    - **f1-measure**, an harmonic mean between precision and recall to estimates the global performance of the model.

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
To ensure project roles / grants distribution, Snowflake offers a superb management system on which administrators can dispatch responsibilities efficiently. In that way, the file [0-Setup.sql](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/0-Setup.sql) describes how I have set up my cloud environment , creating a specific role to achieve the project tasks.


## 4) Model Building

### Data Cleaning

In order to perform to train the classification model, I first needed to clean the data (such treating missing values, imbalances or highly correlated features): that's why the two files [2-Data_CLeaning.ipynb](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/2-Data_CLeaning.ipynb) (local treatment) and [2-SF_Data_Cleaning.ipynb](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/2-SF_Data_Cleaning.ipynb) (equivalent in the cloud) are about.
In particular, I am relying on the **fireducks** library to accelerate data treatment (multi-threads usage) compared to the classic pandas library.

**Please note I have not find yet a efficient function to automatically treat highly correlated features using Snowpark, I will try to look further in possible ways to do so in the upcoming weeks**

### Model Building + Training

Since we want to predict binary response and that oversampling balances the dataset, I thought using a logistic regression as a first model could be a good start. Using the cholesky transformation option (much more samples than features) provided by [Scikit-Learn](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html), the local training was short (only a few seconds) and will be useful to compare to a cloud based solution.

#### Local Training

Since we are dealing with a binary classification problem, I am first trying to build a Logistic Regression model. Details are available in [3-Model_Training.ipynb](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/3-Model_Training.ipynb).

Compared to a basic classifier (one that would always detect a fraud), this first model is much more precise (79.5% vs 50%) and has approximately the same training precision as the test one (hence not overfitting the data) : it seems to be a good start !

#### Cloud Training

The next step is to scale the local model in a cloud Environment. To do so, the file [3-Model_Training.ipynb](https://github.com/JabbyData/CREDIT-FRAUD-DETECTION/blob/main/3-SF_Model_Training.ipynb) describes how to reproduces the local training on a Snowflake environment. In particular I am building a Pipeline to orchestrate preprocessing operations to automate as much as possible the training of the model.

