from argparse import ArgumentParser

parser = ArgumentParser()

# Argumento para el bucket o repositorio de datos.
parser.add_argument(
         'bucket',
         help='Bucket de Amazon S3')
 
# Argumento para los archivos a descargar
parser.add_argument(
         'files',
         nargs='+',
         help='Archivo(s) a descargar')