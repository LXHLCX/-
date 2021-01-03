package dao;

import bean.Collection;
import utils.DBUtils;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CollectionDAO {

    public static void collectionBook(int userId,int bookId) throws SQLException, IOException, ClassNotFoundException {
        String sql="insert into collection(userId,bookId) values("+userId+","+bookId+")";
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
        return;
    }
    public static boolean isCollection(int userId,int bookId) throws SQLException, IOException, ClassNotFoundException {
        String sql="select userId,bookId from collection where userId="+userId+" and bookId="+bookId;
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        boolean flag=true;
        if(resultSet.next())
            flag=true;
        else
            flag=false;
        dbUtils.close();
        return flag;
    }
    public static ArrayList<Collection> getAllCollection(Integer userId) throws SQLException, IOException, ClassNotFoundException {
        String sql="select userId,bookId from collection where userId="+userId+" order by bookId";
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        ArrayList<Collection> collectionArrayList=new ArrayList<>();
        Collection collection=null;
        while (resultSet.next()){
            collection=new Collection();
            collection.setUserId(resultSet.getInt("userId"));
            collection.setBookId(resultSet.getInt("bookId"));
            collectionArrayList.add(collection);
        }
        dbUtils.close();
        return collectionArrayList;
    }
}
//    String sql="select * from book where bookId="+bookId;
//        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11");
//                DBUtils dbUtils=new DBUtils();
//                System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
//                ResultSet resultSet=dbUtils.search(sql);
//                Book book=null;
//                if(resultSet.next()){
//                book=new Book();
//                book.setBookId(resultSet.getInt("bookId"));
//                book.setBookName(resultSet.getString("bookName"));
//                book.setCover(resultSet.getString("cover"));
//                book.setFolder(resultSet.getString("folder"));
//                book.setIntroduction(resultSet.getString("introduction"));
//                book.setClassification(resultSet.getString("classification"));
//                book.setAuthor(resultSet.getString("author"));
//                }
//                dbUtils.close();
//                return book;