const mysql = require('mysql');

module.exports = {
    createAccess: async (pool, acIp, acName, acPlaceId) => {
        var sql = "INSERT INTO tbl_access_ct (ac_ip, ac_device_name, place_id) " 
                + "VALUES (?,?,?)";
        sql = mysql.format(sql, [acIp, acName, acPlaceId]);

        return await pool.query(sql);
    },

    getByAcId: async (pool, acId) => {
        var sql = "SELECT * FROM tbl_access_ct WHERE ac_id = ?";
        sql = mysql.format(sql, [acId]);

        return await pool.query(sql);
    },

    updateAccess: async (pool, acId, acIp, acName, acPlaceId) => {
        var sql = "UPDATE tbl_access_ct SET "
                + "ac_ip=?,"
                + "ac_device_name=?,"
                + "place_id=? " 
                + "WHERE ac_id= ?";
        sql = mysql.format(sql, [acIp, acName, acPlaceId, acId]);

        return await pool.query(sql);
    },

    deleteAccess: async (pool, acId) => {
        var sql = "DELETE FROM tbl_access_ct WHERE ac_id = ?;";
        sql = mysql.format(sql, [acId]);

        return await pool.query(sql);
    }

}