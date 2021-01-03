package test;

import utils.DBUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
public class Test {

    public static void main(String[] args) throws SQLException, IOException, ClassNotFoundException {
        DBUtils dbUtils=new DBUtils();
        try{
            System.out.println("连接成功过");
        }catch (Exception e){
            System.out.println("连接失败");
        }
    }
}
