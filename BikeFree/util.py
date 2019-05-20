import pymssql

# database related
db = pymssql.connect(host='127.0.0.1:1433', user='sa', password='sa', database='sharedBike')
cursor = db.cursor()

def register(username, password):
    sql1 = 'select yhm from yh where yhm=%s'
    cursor.execute(sql1, username)
    res = cursor.fetchone()
    if res is not None:
        return 'username has been used.'

    sql2 = 'insert into yh values(%s, %s, NULL, NULL, 0.0)'
    cursor.execute(sql2, (username, password))
    db.commit()
    print('register successfully')

    return None

def valid_login(username, password):
    sql = 'select * from yh where yhm=%s and mm=%s'
    cursor.execute(sql, (username, password))
    res = cursor.fetchone()
    if res is None:
        return 'username or password not correct'
    
    return None

def record_biking(username, bikeNum, startTime, endTime, money):
    sql1 = 'select count(*) from qxjl'
    cursor.execute(sql1)
    bikingNum = cursor.fetchone()[0]

    sql2 = 'set xact_abort on \
            begin tran \
            insert into qxjl values(%s, %s, %s, %s, %s, %s) \
            update yh set ye = ye-%s where yhm=%s \
            commit tran'   
    cursor.execute(sql2, (bikingNum+1, username, bikeNum, startTime, endTime, money, money, username))
    db.commit()

def record_repair(bikeNum, username, content):
    sql1 = 'select count(*) from bxjl'
    cursor.execute(sql1)
    repairNum = cursor.fetchone()[0]

    sql2 = 'insert into bxjl values(%s, %s, %s, %s)'
    cursor.execute(sql2, (repairNum+1, bikeNum, username, content))
    db.commit()

def read_userInfo(username):
    sql1 = 'select * from userInfo where yhm=%s'
    cursor.execute(sql1, username)
    _, sex, phoneNum = cursor.fetchone()

    sql2 = 'select count(*) from qxjl where yhm=%s'
    cursor.execute(sql2, username)
    totalBiking = cursor.fetchone()[0]

    return sex, phoneNum, totalBiking

def modify_userInfo(username, sex, phoneNum):
    sql = 'update yh set xb=%s, sjh=%s where yhm=%s'
    cursor.execute(sql, (sex, phoneNum, username))
    db.commit()

def read_deposit(username):
    sql1 ='select ye from yh where yhm=%s'
    cursor.execute(sql1, username)
    money = cursor.fetchone()[0]

    sql2 = 'select sum(czje) from dd where yhm=%s'
    cursor.execute(sql2, username)
    totalDeposit = cursor.fetchone()[0]

    return money, totalDeposit

def add_deposit(username, money):
    sql1 = 'select count(*) from dd'
    cursor.execute(sql1)
    orderNum = cursor.fetchone()[0]

    sql2 = 'set xact_abort on \
            begin tran \
            insert into dd values(%s, %s, %s) \
            update yh set ye = ye+%s where yhm=%s \
            commit tran' 
    cursor.execute(sql2, (orderNum+1, username, money, money, username))
    db.commit()