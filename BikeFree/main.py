from router import app
from util import *

if __name__ == "__main__":
    app.run(debug=True)
    db.close()
