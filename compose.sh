#!/bin/bash

rsync -avh --delete compose/ admin@appserver:/home/admin/compose/
