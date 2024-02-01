// *---------- Import ------------
const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser'); //* ตัวอ่านข้อมูลฝ่าน Client POST (ทำงานร่วมกัน EXPRESS)
const cors = require('cors'); 
const jwt = require('jsonwebtoken');
const util = require('util');
const path = require('path');
// *------------------------------

// *---------- Library ------------
const Cctv = require('./libs/Cctv');
const AccessControl = require('./libs/AccessControl');


// *----------- Use --------------
const app = express(); // * ตัวแปร app เป็นตัวแปรใช้เรียกในส่วนของ express
const port = 4080; // * ตัวแปรใช้ port
app.use(express.static(path.resolve(__dirname, 'dist'))); // * ใช้งานไฟล์ static ที่อยู่ในโฟลเดอร์ dist
app.use(bodyParser.urlencoded({extended: false})) //* เรียกใช้ middleware body-parser เพื่อแปลงข้อมูลจาก body ของ request เป็น JavaScript objects
app.use(bodyParser.json()); //* ใช้ไฟล์เป็น .json
app.use(cors());
// *------------------------------

// *----- เปิดใช้งาน Server --------
// const pool = mysql.createPool({
//     connectLimit: 10,
//     host : "localhost",
//     user: "root",
//     password : "",
//     database : "itservice_db"
// });
// pool.query = util.promisify(pool.query);


const pool = mysql.createPool({
    connectLimit: 10,
    host : "sql6.freemysqlhosting.net",
    user: "sql6680797",
    password : "FrY5K5x3xj",
    database : "sql6680797"
});
pool.query = util.promisify(pool.query);
// *------------------------------

// *-------- คำสั่งจาก ๆ จาก Server ----------
// ? GET PORT /
app.get('/', (req, res) => {
    res.send("Welcome to Back-END! ITVERTEX SERVICE!")
})

// ! เข้าสู่ระบบ 
app.post('/login' , (req, res) => {
    const username = req.body.username //* รับค่า username จากฝั่ง Client
    const password = req.body.password //* รับค่า password จากฝั่ง Client

    pool.query("SELECT * FROM tbl_user WHERE username = ? AND password = MD5(?)" , [username , password], function (error, results, fields) {
        // ! ถ้า ERROR
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        }

        // * ถ้าพบข้อมูล username และ password
        if (results.length) {
            res.json({
                result: true
            });
        }
        // ! ถ้าไม่พบข้อมูล username และ password
        else {
            res.json({
                result: false,
                message: "ไม่พบข้อมูล username หรือ password ไม่ถูกต้อง"
            });
        }
    });
});

// ! ENDPOINT Auth_request
app.post("/api/authen_request" , (req, res) => {
    const sql = "SELECT * FROM tbl_user WHERE MD5(username) = ?";
    //* นำ username ไปตรวจสอบว่ามีใน Database หรือไม่ ?
    pool.query(sql, [req.body.username] , (error, results) => { 
        var response ;
        if (error) {
            response = {
                result: false,
                message: error.message
            };
        } else {
            if (results.length) {
                var payload = { username : req.body.username }; //* เก็บข้อมูล username ไว้ใน payload
                var secretKey = "MySecretKey"; //* นำไปเข้ารหัสกับ Payload
                const authToken = jwt.sign(payload, secretKey); //* เข้ารหัสข้อมูล payload ด้วย SecretKey เก็บไว้ในตัวแปร authToken
                
                response = {
                    result: true,
                    data: {
                        auth_token: authToken
                    }
                }; //* ส่วนนี้เก็บผลลัพธ์ของการทำ Authentication request

            } else {
                //* ถ้าไม่มีข้อมูลในฐานข้อมูล
                response = {
                    result: false,
                    message: "Username ไม่ถูกต้อง"
                }
            }
        }
        res.json(response); //* ส่งข้อมูลกลับไปยัง client เป็นรูปแบบ JSON
    });
});

// *  End point Access_request
app.post("/api/access_request" , (req, res) => {
    const authtenSignature = req.body.auth_signature;
    const authToken = req.body.auth_token;

    var decoded = jwt.verify(authToken, "MySecretKey"); //* ตรวจสอบ AuthToken , MysecretKey

    if (decoded) { //* ถ้าตรวจสอบแล้วผ่าน
        const query = "SELECT a.user_Id, a.username, a.u_name , a.u_lastname , a.u_tel , a.u_email ,  a.u_role , b.role_name "
                +   "FROM tbl_user a JOIN tbl_roles b ON a.u_role = b.role_id WHERE MD5(CONCAT(username, '&' , password)) = ?";
        pool.query(query, [authtenSignature] , (error, results) => {
            var response ; //* ตัวแปรเก็บค่า
            if (error) {
                response = {
                    result : false,
                    message : error.message
                };
            } else {
                if (results.length > 0) {
                    var payload = {
                        user_Id : results[0].user_id ,
                        username : results[0].username,
                        u_name : results[0].u_name , 
                        u_lastname : results[0].u_lastname,
                        u_tel : results[0].u_tel,
                        u_email : results[0].u_email,
                        u_role : results[0].u_role
                    };
                    const accessToken = jwt.sign(payload, "MySecretKey");
                    response = {
                        result : true,
                        data : {
                            access_token : accessToken,
                            account_info : payload
                        }
                    };
                } else {
                    response = {
                        result: false,
                        message: "Username หรือ Password ไม่ถูกต้อง"
                    };
                }
            }
            res.json(response); //* ส่งค่า response เข้าใน JSON
        });
    }
});

// *----- ป้องกันไม่ให้คนที่ไม่ได้เข้าสู่ระบบดึงข้อมูลไปใช้งาน --------
let checkAuth = (req, res , next) => {
    let token = null;

    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        token = req.headers.authorization.split(' ')[1];
    } else if (req.query && req.query.token) {
        token = req.query.token;
    } else {
        token = req.body.token;
    }
    
    if (token) {
        jwt.verify(token, "MySecretKey" , (err, decoded) => {
            if (err) {
                res.send(JSON.stringify({
                    result: false,
                    message: "ไม่ได้เข้าสู่ระบบ"
                }));
            } else {
                req.decoded = decoded;
                next();
            }
        });
    } else {
        res.status(401).send("Not authorized");
    }
}
// *-----------------------------------------------------
// *  แสดงข้อมูลรายการแจ้งซ่อม
app.get("/api/repair_read", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_repair a " +
    "JOIN tbl_customer b ON a.cus_number = b.cus_number "  +
    "JOIN tbl_device c ON a.device_number = c.device_number " +
    "JOIN tbl_device_types d ON c.device_types = d.device_type_id " +
    "JOIN tbl_device_brand f ON c.device_brand = f.brand_id " + 
    "JOIN tbl_status g ON a.status = g.status_id " ;

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
});
// *-----------------------------------------------------
app.get("/api/repair_read2/", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_repair a " +
    "JOIN tbl_customer b ON a.cus_number = b.cus_number "  +
    "JOIN tbl_device c ON a.device_number = c.device_number " +
    "JOIN tbl_device_types d ON c.device_types = d.device_type_id " +
    "JOIN tbl_device_brand f ON c.device_brand = f.brand_id " + 
    "JOIN tbl_status g ON a.status = g.status_id WHERE a.status = 1" ;

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
});
// *-----------------------------------------------------

// *-----------------------------------------------------
app.get("/api/repair_read3/", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_repair a " +
    "JOIN tbl_customer b ON a.cus_number = b.cus_number "  +
    "JOIN tbl_device c ON a.device_number = c.device_number " +
    "JOIN tbl_device_types d ON c.device_types = d.device_type_id " +
    "JOIN tbl_device_brand f ON c.device_brand = f.brand_id " + 
    "JOIN tbl_status g ON a.status = g.status_id WHERE a.status = 6" ;

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
});
// *-----------------------------------------------------

// *-----------------------------------------------------
app.get("/api/repair_read4/", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_repair a " +
    "JOIN tbl_customer b ON a.cus_number = b.cus_number "  +
    "JOIN tbl_device c ON a.device_number = c.device_number " +
    "JOIN tbl_device_types d ON c.device_types = d.device_type_id " +
    "JOIN tbl_device_brand f ON c.device_brand = f.brand_id " + 
    "JOIN tbl_status g ON a.status = g.status_id WHERE a.status = 2" ;

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
});
// *-----------------------------------------------------

// *-----------------------------------------------------
app.get("/api/repair_read5/", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_repair a " +
    "JOIN tbl_customer b ON a.cus_number = b.cus_number "  +
    "JOIN tbl_device c ON a.device_number = c.device_number " +
    "JOIN tbl_device_types d ON c.device_types = d.device_type_id " +
    "JOIN tbl_device_brand f ON c.device_brand = f.brand_id " + 
    "JOIN tbl_status g ON a.status = g.status_id WHERE a.status = 4" ;

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
});
// *-----------------------------------------------------
app.get("/api/repair_read6/", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_repair a " +
    "JOIN tbl_customer b ON a.cus_number = b.cus_number "  +
    "JOIN tbl_device c ON a.device_number = c.device_number " +
    "JOIN tbl_device_types d ON c.device_types = d.device_type_id " +
    "JOIN tbl_device_brand f ON c.device_brand = f.brand_id " + 
    "JOIN tbl_status g ON a.status = g.status_id WHERE a.status = 3" ;

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
});
// *-----------------------------------------------------

// *------------------- ค้นหาข้อมูลลูกค้า (ระบุ) -------------
app.get('/api/customer/readone/:cus_number' , checkAuth , (req, res) => {
    const cus_number = req.params.cus_number; // จากที่ค้นหาจากฝั่ง Clients
    const sql = "SELECT * FROM tbl_customer WHERE cus_number = ? ";

    pool.query(sql, [cus_number], (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            if (results.length === 0) {
                res.json({
                    result: false,
                    message: "ไม่พบข้อมูลที่ตรงกับค้นหา"
                });
            } else {
                res.json({
                    result: true,
                    data: results
                });
            }
        }
    });
});

// *------------------- แสดงข้อมูลลูกค้า -------------
app.get("/api/customer_read", checkAuth , (req, res) => {
    const query = "SELECT * FROM tbl_customer";

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
    
});
// *-----------------------------------------------
// *    แสดงข้อมูลกราฟ
app.get("/api/report", (req, res) => {
    const query = "SELECT a.device_type_name, COALESCE(COUNT(c.device_number), 0) AS total " +
                "FROM tbl_device_types a " +
                "JOIN tbl_device b ON a.device_type_id = b.device_types " +
                "JOIN tbl_repair c ON b.device_number = c.device_number " +
                "GROUP BY a.device_type_name";

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message
            });
        } else {
            res.json({
                result: true,
                data: results
            });
        }
    });
    
});

app.get("/api/cctv_read_all", checkAuth, (req, res) => {
    const query = "SELECT t1.ipc_id, t1.ipc_address, t1.ipc_name, t2.ipc_status_name FROM tbl_ipc t1" +
    " JOIN tbl_ipc_status t2 ON t1.ipc_status = t2.ipc_status";

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message,
            });
        } else {
            res.json({
                result: true,
                data: results,
            });
        }
    });

});

app.get("/api/ipc_status_name", checkAuth, (req, res) => {
    const query = "SELECT * FROM tbl_ipc_status";

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message,
            });
        } else {
            res.json({
                result: true,
                data: results,
            });
        }
    });
});

app.post("/api/cctv/create", checkAuth, async (req, res) => {
    const input = req.body;

    try {
        var result = await Cctv.createCctv(pool,
            input.ipc_address,
            input.ipc_name,
            input.ipc_status);
            
        res.json({
            result: true,
        });    

    } catch (ex) {
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.get("/api/cctv/:ipc_id", checkAuth, async (req, res) => {
    const ipc_id = req.params.ipc_id;
    try {
        var result = await Cctv.getByIpcId(pool, ipc_id);

        res.json({
            result: true,
            data: result,
        });
    } catch (ex) {
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.post("/api/cctv/update", checkAuth, async (req, res) => {
    const input = req.body;

    try {
        var result = await Cctv.updateCctv(pool,
            input.ipc_id,
            input.ipc_address,
            input.ipc_name,
            input.ipc_status);

        res.json({
            result: true,
        });
    } catch (ex) {
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.post("/api/cctv/delete", checkAuth, async (req, res) => {
    const input = req.body;
    try{
        var result = await Cctv.deleteCctv(pool, input.ipc_id);

        res.json({
            result: true,
        });
        
    }catch(ex){
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.get("/api/ac_read_all", checkAuth, (req, res) => {
    const query = "SELECT t1.ac_id, t1.ac_ip, t1.ac_device_name, t2.place_name FROM tbl_access_ct t1" +
     " JOIN tbl_place t2 ON t1.place_id = t2.place_id";

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message,
            });
        } else {
            res.json({
                result: true,
                data: results,
            });
        }
    });

});

app.get("/api/ac_place_name", checkAuth, (req, res) => {
    const query = "SELECT * FROM tbl_place";

    pool.query(query, (error, results) => {
        if (error) {
            res.json({
                result: false,
                message: error.message,
            });
        } else {
            res.json({
                result: true,
                data: results,
            });
        }
    });
});

app.post("/api/AccessControl/create", checkAuth, async (req, res) => {
    const input = req.body;

    try {
        var result = await AccessControl.createAccess(pool,
            input.ac_ip,
            input.ac_device_name,
            input.place_id);
            
        res.json({
            result: true,
        });    

    } catch (ex) {
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.get("/api/AccessControl/:ac_id", checkAuth, async (req, res) => {
    const ac_id = req.params.ac_id;
    try {
        var result = await AccessControl.getByAcId(pool, ac_id);

        res.json({
            result: true,
            data: result,
        });
    } catch (ex) {
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.post("/api/AccessControl/update", checkAuth, async (req, res) => {
    const input = req.body;

    try {
        var result = await AccessControl.updateAccess(pool,
            input.ac_id,
            input.ac_ip,
            input.ac_device_name,
            input.place_id);

        res.json({
            result: true,
        });
    } catch (ex) {
        res.json({
            result: false,
            message: ex.message,
        });
    }
});

app.post("/api/AccessControl/delete", checkAuth, async (req, res) => {
    const input = req.body;
    try{
        var result = await AccessControl.deleteAccess(pool, input.ac_id);

        res.json({
            result: true,
        });
        
    }catch(ex){
        res.json({
            result: false,
            message: ex.message,
        });
    }
});


app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});
