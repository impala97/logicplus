import psycopg2 as db


class dbcon:
    global con
    con = db.connect(dbname='logicplus', host='localhost', user='postgres', password='root')
    global cursor
    cursor = con.cursor()

    def __init__(self):
        pass

    def do_select(self, select):
        cursor.execute(select)

        row = cursor.fetchall()
        return row

    def do_insert(self, insert):
        result = cursor.execute(insert)
        con.commit()
        return True


if __name__ == "__main__":
    dbcon()
