""" Module collecting data on Kaggle and Loading it on Snowflake """

### Dependencies ###
from kaggle.api.kaggle_api_extended import KaggleApi
import pandas as pd
import os
import zipfile
import json
from snowflake.snowpark import Session

def listing_datasets(search,min_size,max_size,usability_rate,last_year_update):
    """ Lists all datasets matching searching patterns and print their metadata
    Inputs :
        - search (string) : pattern to match in the dataset's name
        - min_size (int) : minimum size of the dataset (in bytes)
        - max_size (int) : maximum size of the dataset (in bytes)
        - usability_rate (float) : minimum usability level of the dataset (between 0 and 1)
        - last_update_year (int) : last year the dataset was updated

    Output : 
        - None
    """

    api = KaggleApi()
    api.authenticate()
    datasets = api.dataset_list(search=search,min_size=min_size,max_size=max_size)
    valid_datasets = []
    for ds in datasets:
        ds_vars = vars(ds)
        if int(ds_vars['usabilityRatingNullable']) > usability_rate and int(ds_vars['lastUpdated'].year) >= last_year_update :
            valid_datasets.append(ds_vars['url'])

    for vds in valid_datasets:
        print(vds)
        print('------------------------------------------------------')

    print("Listing Completed")


def download_dataset_file(dataset_ref,file_name,force):
    """ Downloads a specific file from the Kaggle public dataset base and unzips it in the folder 'data/'
    Inputs : 
        - dataset_ref (string) : ref of the dataset
        - file_name (string) : name of the file in the dataset
        - force (Boolean) : if True erases any name matching file in the download destination ('temp/')
    Output : 
        - None
    """
    api = KaggleApi()
    api.authenticate()
    api.dataset_download_file(dataset=dataset_ref,file_name=file_name,path='temp/',force=force)

    zip_file_path = 'temp/' + file_name + '.zip'
    extract_to_path = 'data/'

    with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
        zip_ref.extractall(extract_to_path)

    os.remove('temp/' + file_name + '.zip')

    print(f"Extracted all files to {extract_to_path}")


def load_to_sf(file_to_load):
    """ Loads the csv file on Snowflake 
    Input : 
        - file_to_load (string) : name of the csv file to load
    Output : 
        - None
    """
    connection_parameters = json.load(open('connection.json'))
    session = Session.builder.configs(connection_parameters).create()

    df = pd.read_csv('data/' + file_to_load)
    snowpark_df = session.create_dataframe(df)

    table_name = 'FRAUD_DATA'
    snowpark_df.write.save_as_table(table_name, mode='append')

    session.close()

    os.remove('data/' + file_to_load)

    print("Loading Finished, please check results on Snowflake")


if __name__ == "__main__":
    listing_datasets('fraud',100000,300000,0.7,2022)
    download_dataset_file('sgpjesus/bank-account-fraud-dataset-neurips-2022','Base.csv',True)
    load_to_sf('Base.csv')