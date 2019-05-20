from flask import *
from util import *

app = Flask(__name__)

@app.route("/", methods=['GET', 'POST'])
def homepage():
    error = None
    if request.method == 'POST':
        if request.form['addition'] == '1':
            error = valid_login(request.form['username'], request.form['password'])
            if not error:
                resp = make_response(redirect('/biking'))
                resp.set_cookie('username', request.form['username'], max_age=3600)
                return resp
        else:
            error = register(request.form['username'], request.form['password'])
    resp = make_response(render_template('homepage.html', error=error))
    resp.set_cookie('username', '', max_age=0)
    print("visiting BikeFree homepage.")
    return resp

@app.route("/biking", methods=['GET', 'POST'])
def biking():
    username = request.cookies['username']
    if request.method == 'POST':
        # 存骑行记录
        record_biking(username, request.form['bikeNum'], request.form['startTime'], request.form['endTime'], request.form['money'])
        return redirect('/biking')
    print("visiting biking page.")
    return render_template('biking.html')

@app.route("/repair", methods=['GET', 'POST'])
def repair():
    username = request.cookies['username']
    if request.method == 'POST':
        # 存报修记录
        record_repair(request.form['bikeNum'], username, request.form['content'])
        return redirect('/repair')
    print('visiting repair page.')
    return render_template('repair.html')

@app.route("/userInfo", methods=['GET', 'POST'])
def userInfo():
    username = request.cookies['username']
    if request.method == 'POST':
        #修改用户信息
        modify_userInfo(username, request.form['sex'], request.form['phoneNum'])
        return redirect('/userInfo')
    sex, phoneNum, totalBiking = read_userInfo(username)
    print("visiting userInfo page.")
    return render_template('userInfo.html', username=username, sex=sex, phoneNum=phoneNum, totalBiking=totalBiking)

@app.route("/deposit", methods=['GET', 'POST'])
def deposit():
    username = request.cookies['username']
    if request.method == 'POST':
        #充值
        add_deposit(username, request.form['deposit'])
        return redirect('/deposit')
    money, totalDeposit = read_deposit(username)
    print("visiting deposit page.")
    return render_template('deposit.html', money=money, totalDeposit=totalDeposit)

