const mysql = require('mysql');

module.exports = {
    createCctv: async (pool, ipcAddress, ipcName, ipcStatus) => {
        var sql = "INSERT INTO tbl_ipc (ipc_address, ipc_name, ipc_status) " 
                + "VALUES (?,?,?)";
        sql = mysql.format(sql, [ipcAddress, ipcName, ipcStatus]);

        return await pool.query(sql);
    },

    getByIpcId: async (pool, ipcId) => {
        var sql = "SELECT * FROM tbl_ipc WHERE ipc_id = ?";
        sql = mysql.format(sql, [ipcId]);

        return await pool.query(sql);
    },

    updateCctv: async (pool, ipcId, ipAddress, ipcName, ipcStatus) => {
        var sql = "UPDATE tbl_ipc SET "
                + "ipc_address=?,"
                + "ipc_name=?,"
                + "ipc_status=? "
                + "WHERE ipc_id = ?";
        sql = mysql.format(sql, [ipAddress, ipcName, ipcStatus, ipcId]);

        return await pool.query(sql);
    },

    deleteCctv: async (pool, ipcId) => {
        var sql = "DELETE FROM tbl_ipc WHERE ipc_id = ?";
        sql = mysql.format(sql, [ipcId]);

        return await pool.query(sql);
    }

}