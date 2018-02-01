from .lpdb import dbcon
from .course import course
from .faculty import faculty


class batch():
    def addBatch(self, clist, flist, dlist, tlist):
        dlist = self.make_str(dlist)
        tlist = self.make_str(tlist)
        insert = "insert into lp.batch_trnxs(cid,fid,day,time,active) values('%s','%s','%s','%s','1')" % (
        clist, flist, dlist, tlist)
        return dbcon().do_insert(insert)

    def updateBatch(self, clist, flist, dlist, tlist, bid):
        dlist = self.make_str(dlist)
        tlist = self.make_str(tlist)
        update = "update lp.batch_trnxs set cid='%s',fid='%s',day='%s',time='%s' where bid=%d;" % (
        clist, flist, dlist, tlist, int(bid))
        return dbcon().do_insert(update)

    def getbatch(self, cid=None):
        if cid is None:
            select = "select * from lp.batch_trnxs order by bid;"
            row = dbcon().do_select(select)
            for r in range(0, len(row)):
                row[r] = list(row[r])

            for r in range(0, len(row)):
                c = course().getCourseName(row[r][1])
                row[r][1] = c[0]
                del c
                row[r][2] = faculty().getFacultyName(row[r][2])
            return row
        else:
            select = "select bid,day,time from lp.batch_trnxs where cid=%d order by bid;" % int(cid)
            row = dbcon().do_select(select)
            return self.reverse(row)

    def reverse(self,row):
        time = [None] * len(row)
        len_time = 0

        for r in range(0, len(row)):
            time[r] = row[r][2].split(',')
            len_time += len(time[r])

        ftop = 0
        id = [None] * len_time
        for r in range(0, len(time)):
            for c in range(0, len(time[r])):
                id[ftop] = row[r][0]
                ftop += 1

        ftop = 0
        dt = [None] * len_time
        for r in range(0, len(time)):
            for c in range(0, len(time[r])):
                dt[ftop] = row[r][1] + " " + time[r][c]
                ftop += 1

        return id, dt

    def Active(self, bid):
        update = "update lp.batch_trnxs set active='1' where bid=%d;" % int(bid)
        return dbcon().do_insert(update)

    def Delete(self, bid):
        update = "update lp.batch_trnxs set active='0' where bid=%d;" % int(bid)
        return dbcon().do_insert(update)

    def make_str(self, str):
        tmp = ""
        if len(str) > 1:
            for i in range(0, len(str)):
                if i == len(str) - 1:
                    tmp = tmp + str[i]
                else:
                    tmp = tmp + str[i] + ','
        else:
            return str[0]
        del str
        return tmp

    def getCid(self):
        select = "select distinct cid from lp.batch_trnxs order by cid;"
        row = dbcon().do_select(select)
        for r in range(0, len(row)):
            row[r] += course().getCourseName(row[r][0])
        return row

    def getFid(self, bid=None):
        if bid is None:
            select = "select distinct fid from lp.batch_trnxs order by fid;"
            row = dbcon().do_select(select)
            result = [[None] * 2] * len(row)
            for r in range(0, len(row)):
                result[r][0] = row[r][0]
                result[r][1] = faculty().getFacultyName(row[r][0])
            del row
            return result
        else:
            select = "select fid from lp.batch_trnxs where bid=%d;"%int(bid)
            row = dbcon().do_select(select)
            return row[0][0]

    def updatecountall(self):
        select = "select lp.admission_batch.bid,count(lp.admission_batch.bid) from lp.admission_batch inner join lp.batch_trnxs on lp.admission_batch.bid=lp.batch_trnxs.bid group by lp.admission_batch.bid;"
        data_entry = dbcon().do_select(select)

        for de in data_entry:
            update = "update lp.batch_trnxs set entries=%d where bid=%d;" % (de[1], de[0])
            dbcon().do_insert(update)

    def updatecount(self, bid):
        select = "select count(bid) from lp.admission_batch where bid=%d;" % bid
        data_entry = dbcon().do_select(select)

        update = "update lp.batch_trnxs set entries=%d WHERE bid=%d" % (data_entry[0][0], bid)
        return dbcon().do_insert(update)

    def getdtbybid(self, bid):
        select = "select day,time from lp.batch_trnxs where bid=%d;" % bid
        result = dbcon().do_select(select)
        return result[0]


if __name__ == "__main__":
    batch()
