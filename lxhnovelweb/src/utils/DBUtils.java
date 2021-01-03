package utils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;
public class DBUtils {
    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;
    public DBUtils() throws SQLException, ClassNotFoundException, IOException {
        //读取配置
        InputStream in=Thread.currentThread().getContextClassLoader().getResourceAsStream("config/db.properties");
        Properties properties=new Properties();
        properties.load(in);
        String driverName=properties.getProperty("driverName");
        String url=properties.getProperty("url");
        //加载驱动器
        try{
            Class.forName(driverName);
            System.out.println("加载成功");
        }catch (Exception e){
            System.out.println("加载失败");
        }

        //获取连接
        this.connection=DriverManager.getConnection(url);
        //获取statement
        this.statement=this.connection.createStatement();
    }
    public Connection getConnection() {
        return connection;
    }
    public Statement getStatement() {
        return statement;
    }
    public ResultSet getResultSet() {
        return resultSet;
    }
    public void close() throws SQLException {
        if(resultSet!=null)
            resultSet.close();
        this.statement.close();
        this.connection.close();
        this.connection=null;
        this.statement=null;
    }
    public ResultSet search(String url) throws SQLException {
        if(this.resultSet!=null){
            this.resultSet.close();
            this.resultSet=null;
        }
        System.out.println("是否进入了sql查找");
        this.resultSet= this.statement.executeQuery(url);
        System.out.println("查找是否完成");
        return this.resultSet;
    }
    public boolean update(String url) throws SQLException {
        int line=0;
        line=this.statement.executeUpdate(url);
        if(line>0)
            return true;
        else
            return false;
    }
}
