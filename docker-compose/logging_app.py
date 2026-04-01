import datetime
import os
import logging
import logging.handlers as handlers


logger = logging.getLogger('app')
logger.setLevel(logging.INFO)

formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

if not os.path.exists("/var/log/app"):
	os.makedirs("/var/log/app", 0o777)

logHandler = handlers.TimedRotatingFileHandler("/var/log/app/app.log", when="midnight", interval=30)
logHandler.suffix = "{:%Y-%m-%d}.log".format(datetime.datetime.now())
logHandler.setLevel(logging.INFO)
logHandler.setFormatter(formatter)
logger.addHandler(logHandler)