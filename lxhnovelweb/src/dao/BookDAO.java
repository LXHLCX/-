package dao;

import bean.Book;
import bean.Passage;
import bean.User;
import utils.DBUtils;


import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class BookDAO {
    public Book getBookById(Integer bookId) throws SQLException, IOException, ClassNotFoundException {
        if(bookId==null)
            return null;
        String sql = "select * from book where bookId=" + bookId;
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11");
        DBUtils dbUtils = new DBUtils();
        System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
        ResultSet resultSet = dbUtils.search(sql);
        Book book = null;
        if (resultSet.next()) {
            book = new Book();
            book.setBookId(resultSet.getInt("bookId"));
            book.setBookName(resultSet.getString("bookName"));
            book.setCover(resultSet.getString("cover"));
            book.setFolder(resultSet.getString("folder"));
            book.setIntroduction(resultSet.getString("introduction"));
            book.setClassification(resultSet.getInt("classification"));
            book.setAuthor(resultSet.getString("author"));
        }
        dbUtils.close();
        return book;
    }
    public int  insertNewBook(String bookName,String introduction,int classification,String author) throws SQLException, IOException, ClassNotFoundException {
        if(bookName==null)
            bookName="";
        if(introduction==null)
            introduction="";
        if(author==null)
            author="";
        String sql="insert into book(bookName,introduction,classification,author) values('"+bookName+"','"+introduction+"',"+classification+",'"+author+"')";
        DBUtils dbUtils=new DBUtils();
        Statement statement=dbUtils.getStatement();
        statement.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);
        int newBookId=-1;
        ResultSet resultSet=statement.getGeneratedKeys();
        if(resultSet.next())
            newBookId=resultSet.getInt(1);
        resultSet.close();
        dbUtils.close();
        return newBookId;
    }
    public void updateFolder(int bookId) throws SQLException, IOException, ClassNotFoundException {
        String sql="update book set folder="+bookId+" where bookId="+bookId;
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
    }
    public void updateCover(String cover,int bookId) throws SQLException, IOException, ClassNotFoundException {
        String sql="update book set cover='"+cover+"' where bookId="+bookId;
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
    }
    public ArrayList<Book> getAllBooks() throws SQLException, IOException, ClassNotFoundException {
        String sql="select * from book";
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        Book book=null;
        ArrayList<Book> bookArrayList=new ArrayList<>();
        while (resultSet.next()){
            book=new Book();
            book.setBookId(resultSet.getInt("bookId"));
            book.setBookName(resultSet.getString("bookName"));
            book.setCover(resultSet.getString("cover"));
            book.setFolder(resultSet.getString("folder"));
            book.setIntroduction(resultSet.getString("introduction"));
            book.setClassification(resultSet.getInt("classification"));
            book.setAuthor(resultSet.getString("author"));
            bookArrayList.add(book);
        }
        dbUtils.close();
        return bookArrayList;
    }
    public void deleteBookById(Integer bookId) throws SQLException, IOException, ClassNotFoundException {
        if(bookId==null)
            return;
        String sql="delete from book where bookId="+bookId;
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
    }
    public void updateBook(Book book) throws SQLException, IOException, ClassNotFoundException {
        if(book==null)
            return;
        String sql="update book set bookName='"+book.getBookName()+"',introduction='"+book.getIntroduction()+"',classification="+book.getClassification()+",author='"+book.getAuthor()
                +"' where bookId="+book.getBookId()+"";
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
    }
    public ArrayList<Book> getANumberOfBooksByClassification(Integer number,Integer chosenClassification) throws SQLException, IOException, ClassNotFoundException {
        if(number==null||chosenClassification==null)
            return null;
        String sql=null;
        if(number>0){
            if(chosenClassification<=0)
                sql="select * from book limit 0,"+number+"";
            else sql="select * from book where classification="+chosenClassification+" limit 0,"+number+"";
        }else{
            if(chosenClassification<=0)
                sql="select * from book";
            else sql="select * from book where classification="+chosenClassification+"";
        }
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        Book book=null;
        ArrayList<Book> bookArrayList=new ArrayList<>();
        while(resultSet.next()){
            book = new Book();
            book.setBookId(resultSet.getInt("bookId"));
            book.setBookName(resultSet.getString("bookName"));
            book.setCover(resultSet.getString("cover"));
            book.setFolder(resultSet.getString("folder"));
            book.setIntroduction(resultSet.getString("introduction"));
            book.setClassification(resultSet.getInt("classification"));
            book.setAuthor(resultSet.getString("author"));
            bookArrayList.add(book);
        }
        dbUtils.close();
        return bookArrayList;
    }
    public static void readTimeAdd(Integer bookId,Integer passageNumber) throws SQLException, IOException, ClassNotFoundException {
        if(bookId==null||passageNumber==null)
            return;
        Passage passage=new PassageDAO().getOnePassageByBookIdPassageId(bookId,passageNumber);//判定该章节是否存在
        if(passage==null)
            return;
        //获取当前书籍的阅读数
        String sql="select readTimes from book where bookId="+bookId;
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        int readTimes=0;
        if(resultSet.next()){
            readTimes=resultSet.getInt("readTimes");
        }
        readTimes=readTimes+1;
        sql="update book set readTimes="+readTimes+" where bookId="+bookId+"";
        dbUtils.update(sql);
        dbUtils.close();
    }
    public ArrayList<Book> getAllBooksOrderByReadTimesLimitFourteen() throws SQLException, IOException, ClassNotFoundException {
        String sql="select * from book order by readTimes desc limit 0,14";
        DBUtils dbUtils=new DBUtils();
        ResultSet resultSet=dbUtils.search(sql);
        ArrayList<Book> bookArrayList=new ArrayList<>();
        Book book=null;
        while(resultSet.next()){
            book = new Book();
            book.setBookId(resultSet.getInt("bookId"));
            book.setBookName(resultSet.getString("bookName"));
            book.setCover(resultSet.getString("cover"));
            book.setFolder(resultSet.getString("folder"));
            book.setIntroduction(resultSet.getString("introduction"));
            book.setClassification(resultSet.getInt("classification"));
            book.setAuthor(resultSet.getString("author"));
            book.setReadTimes(resultSet.getInt("readTimes"));
            bookArrayList.add(book);
        }
        dbUtils.close();
        return bookArrayList;
    }
}
//update student set name='李阳' where id=2
//    private int bookId;
//    private String bookName;
//    private String cover;
//    private String folder;
//    private String introduction;
//    private String classification;
//    private String author;