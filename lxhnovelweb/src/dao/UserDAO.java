package dao;

import bean.Book;
import bean.User;
import utils.DBUtils;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
    public static boolean isRegisted(Integer userId) throws SQLException, IOException, ClassNotFoundException {
        if(userId==null)
            return true;
        String sql="select userId from user where userId="+userId;
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        boolean flag=false;
        if(resultSet.next())
            flag=true;
        else
            flag=false;
        dbUtils.close();
        return flag;
    }
    public static boolean registed(User user) throws SQLException, IOException, ClassNotFoundException {
        String sql="insert into user(userId,nickName,password) values("+user .getUserId()+",'"+user.getNickName()+"','"+user.getPassword()+"')";
        System.out.println(sql);
        DBUtils dbUtils=new DBUtils();
        boolean flag=true;//记录账号是否保存成功
        flag=dbUtils.update(sql);
        dbUtils.close();
        return flag;
    }
    public static boolean login(Integer userId,String password) throws SQLException, IOException, ClassNotFoundException {
        String sql="select userId,password from user where userId="+userId+" and password='"+password+"'";
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        boolean flag=false;
        if(resultSet.next())
            flag=true;
        else
            flag=false;
        dbUtils.close();
        return flag;
    }
    public static User getUserByUserId(Integer userId) throws SQLException, IOException, ClassNotFoundException {
        if(userId==null)
            return null;
        String sql="select * from user where userId="+userId;
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        User user=new User();
        if(resultSet.next()){
            user.setUserId(resultSet.getInt("userId"));
            user.setPassword(resultSet.getString("password"));
            user.setNickName(resultSet.getString("nickName"));
            user.setAdministrator(resultSet.getInt("administrator"));
        }
        return user;
    }
    public static ArrayList<User> getAllUsers() throws SQLException, IOException, ClassNotFoundException {
        String sql="select * from user";
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        User user=null;
        ArrayList<User> userArrayList=new ArrayList<>();
        while(resultSet.next()){
            user=new User();
            user.setUserId(resultSet.getInt("userId"));
            user.setNickName(resultSet.getString("nickName"));
            user.setPassword(resultSet.getString("password"));
            user.setAdministrator(resultSet.getInt("administrator"));
            userArrayList.add(user);
        }
        return userArrayList;
    }
    public static ArrayList<User> getNotAdministorUsers() throws SQLException, IOException, ClassNotFoundException {
        String sql="select * from user where administrator!=1";
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        User user=null;
        ArrayList<User> userArrayList=new ArrayList<>();
        while(resultSet.next()){
            user=new User();
            user.setUserId(resultSet.getInt("userId"));
            user.setNickName(resultSet.getString("nickName"));
            user.setPassword(resultSet.getString("password"));
            user.setAdministrator(resultSet.getInt("administrator"));
            userArrayList.add(user);
        }
        return userArrayList;
    }
    public static void deleteUser(Integer userId) throws SQLException, IOException, ClassNotFoundException {
        if(userId==null)
            return;
        String sql="delete from user where userId="+userId;
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
        return;
    }
}
//    userId
//            password
//    nickName
//            administrator
