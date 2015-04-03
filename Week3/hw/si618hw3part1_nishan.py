#!/usr/bin/env python
# -*- coding: utf-8 -*-

#vehicles dataset
#https://drive.google.com/file/d/0BxlZefq_RVoNODZER1M4YUVMUkk/view?usp=sharing

__author__ = 'nishan'

import csv
import sqlite3 as sqlite

with sqlite.connect('vehicles.db') as con:
    cur = con.cursor()
    cur.execute("DROP TABLE IF EXISTS vehicles")
    cur.execute("CREATE TABLE vehicles(year INT, make TEXT, model TEXT, vclass TEXT, cylinders INT, displ REAL, trany TEXT, city08 INT, highway08 INT, combo08 INT)")

with open('vehicles.csv', 'rU') as input_file:
    csvread = csv.reader(input_file, delimiter=',')

    line = csvread.next()

    for line in csvread:
        year = line[63].strip()
        make = line[46].strip()
        model = line[47].strip()
        VClass = line[62].strip()

        try:
            cylinders = int(line[22].strip())
        except:
            continue
        if (cylinders == 0):
            continue

        try:
            displ = float(line[23].strip())
        except:
            continue
        if (displ == 0.0):
            continue

        trany = line[57].strip()
        city08 = line[04].strip()
        highway08 = line[34].strip()
        combo08 = line[15].strip()

        cur.execute("INSERT INTO vehicles VALUES(?,?,?,?,?,?,?,?,?,?)", (year, make, model, VClass, cylinders, displ, trany, city08, highway08, combo08))

#commit and close connection
con.commit()
con.close()
input_file.close()
