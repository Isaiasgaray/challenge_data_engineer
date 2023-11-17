from dotenv import load_dotenv
from pars import parser
from logger import log
import boto3
import os
import sys

def download_files(bucket, files, path_dir, s3_client):

    for file in files:
        try:
            s3_client.download_file(bucket, file, f'{path_dir}/{file}')
            log.info(f'{file} descargado con exito del bucket {bucket}')
        except Exception as e:
            log.error(f'Error al descargar {file} del bucket {bucket}: {e}')

def main():

    # Se paresean los argumentos.
    args = parser.parse_args()

    bucket = args.bucket
    files  = args.files
    
    # Creacion de carpeta para guardar los datos.
    PATH_DATASETS = 'datasets'
    os.makedirs(PATH_DATASETS, exist_ok=True)

    # Se cargan las variables de entorno.
    load_dotenv()

    ACCESS_KEY = os.environ.get('ACCESS_KEY', '')
    SECRET_KEY = os.environ.get('SECRET_KEY', '')

    # Se descargan los archivos si es posible.
    session = boto3.Session(
            aws_access_key_id=ACCESS_KEY,
            aws_secret_access_key=SECRET_KEY)

    s3 = session.client('s3')

    try:
        s3.head_bucket(Bucket=bucket)
        log.info(f'Conexion exitosa al bucket {bucket}')
    except Exception as e:
        log.error(f'No se pudo establecer conexion al bucket {bucket}: {e}')
        sys.exit(1)

    download_files(bucket, files, PATH_DATASETS, s3)

if __name__ == '__main__':
    main()
