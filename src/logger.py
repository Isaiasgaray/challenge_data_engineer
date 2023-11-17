import logging as log

FORMAT = '[%(levelname)s] | %(asctime)s | file %(filename)s | line %(lineno)s: %(message)s'

log.basicConfig(
    level=log.INFO,
    format=FORMAT,
    datefmt='%Y-%m-%d %H:%M:%S',
    handlers=[
        log.StreamHandler(),
        log.FileHandler('s3_download.log', 'a')
    ]
)
